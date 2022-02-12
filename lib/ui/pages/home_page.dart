import 'package:calendar/controllers/task_controller.dart';
import 'package:calendar/db/db_helper_cubit.dart';
import 'package:calendar/db/state.dart';
import 'package:calendar/services/notification_services.dart';
import 'package:calendar/services/theme_services.dart';
import 'package:calendar/ui/constants.dart';
import 'package:calendar/ui/pages/add_task_page.dart';
import 'package:calendar/ui/pages/notification_screen.dart';
import 'package:calendar/ui/size_config.dart';
import 'package:calendar/ui/theme.dart';
import 'package:calendar/ui/widgets/button.dart';
import 'package:calendar/ui/widgets/task_tile.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectDate = DateTime.now();
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DBHelperCubit, DbStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SizeConfig().init(context);
        //_taskController.getEvents();
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: context.theme.backgroundColor,
            title: Text(
              'Calender',
              style: Themes.headingStyle,
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () async {
                ThemeServices().switchTheme();
              },
              icon: const Icon(Icons.brightness_4_outlined),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(const NotificationScreen(
                    payLoad: 'Title| Description| 1, Jan, 2022',
                  ));
                },
                icon: const Icon(Icons.add),
              ),
              sizedBox(0.0, 5.0),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/human.png'),
                minRadius: 20.0,
              ),
              sizedBox(0.0, 10.0),
            ],
          ),
          body: Column(
            children: [
              sizedBox(10.0, 0.0),
              _eventBar(),
              _dateBar(),
              sizedBox(20.0, 0.0),
              _showEvent(),
            ],
          ),
        );
      },
    );
  }

  Widget _eventBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMd().format(_selectDate).toString(),
                style: Themes.subHeadingStyle,
              ),
              sizedBox(5.0, 0.0),
              Text(
                'Today',
                style: Themes.titleBarStyle,
              ),
            ],
          ),
          const Spacer(),
          MyButton(
            text: 'Add Event',
            onTap: () async {
              await Get.to(
                const AddTaskPage(),
                // curve: Curves.bounceInOut,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _dateBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: DatePicker(
        DateTime.now(),
        selectedTextColor: primaryClr,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.grey.shade200,
        dateTextStyle: Themes.dateStyle,
        dayTextStyle: Themes.dateStyle,
        monthTextStyle: Themes.dateStyle,
        onDateChange: (newValue) {
          setState(() {
            _selectDate = newValue;
          });
        },
      ),
    );
  }

  Widget _showEvent() {
    return Obx(() {
      if (_taskController.tasks.isEmpty) {
        return _noTasks();
      } else {
        return Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, index) {
              var task = _taskController.tasks[index];
              var date = DateFormat.jm().parse(task.startTime!);
              var myTime = DateFormat('HH:mm').format(date);
              _notificationHelper.scheduledNotification(
                int.parse(myTime.toString().split(':')[0]),
                int.parse(myTime.toString().split(':')[1]),
                task,
              );
              return AnimationConfiguration.staggeredList(
                duration: const Duration(milliseconds: 400),
                position: index,
                child: SlideAnimation(
                  horizontalOffset: 300,
                  curve: Curves.easeInCubic,
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        showBottomSheetItem(
                          context,
                          task,
                        );
                      },
                      child: TaskTile(
                        task: task,
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: _taskController.tasks.length,
          ),
        );
      }
    });
  }

  Widget _noTasks() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 120.0),
          child: AnimatedOpacity(
            opacity: 0.5,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/task.svg',
                  semanticsLabel: 'task',
                  height: 150.0,
                  color: primaryClr.withOpacity(0.8),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Text(
                    '  you don\'t have any task yet'
                    '\nplease add any task now....',
                    style: Themes.colorTaskStyle,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
