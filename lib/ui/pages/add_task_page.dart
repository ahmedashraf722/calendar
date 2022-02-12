import 'package:calendar/controllers/task_controller.dart';
import 'package:calendar/db/db_helper_cubit.dart';
import 'package:calendar/db/state.dart';
import 'package:calendar/models/task.dart';
import 'package:calendar/ui/theme.dart';
import 'package:calendar/ui/widgets/button.dart';
import 'package:calendar/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  var _selectDate = DateTime.now();
  var startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  var endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 30)))
      .toString();
  int _selectRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectColor = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DBHelperCubit, DbStates>(
      listener: (context, state) {
        if (state is AppInsertDatabaseState) {
          Get.back();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: context.theme.backgroundColor,
            title: Text(
              'Add Event',
              style: Themes.titleTaskStyle,
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            actions: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/human.png'),
                minRadius: 23.0,
              ),
              sizedBox(0.0, 10.0),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  sizedBox(20.0, 0.0),
                  InputField(
                    title: 'Title',
                    hint: 'write title here',
                    controller: _titleController,
                  ),
                  InputField(
                    title: 'Note',
                    hint: 'write note here',
                    controller: _noteController,
                  ),
                  InputField(
                    title: 'Date',
                    hint: DateFormat.yMMMMEEEEd().format(_selectDate),
                    widget: IconButton(
                      onPressed: () {
                        getDate();
                      },
                      icon: const Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InputField(
                          title: 'Start Time',
                          hint: startTime,
                          widget: IconButton(
                            onPressed: () {
                              getStartTime();
                            },
                            icon: const Icon(
                              Icons.access_time,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InputField(
                          title: 'End Time',
                          hint: endTime,
                          widget: IconButton(
                            onPressed: () {
                              getEndTime();
                            },
                            icon: const Icon(
                              Icons.access_time,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  InputField(
                    title: 'Remind',
                    hint: '$_selectRemind minutes only',
                    widget: DropdownButton(
                      value: _selectRemind,
                      items: remindList
                          .map(
                            (element) => DropdownMenuItem(
                              value: element,
                              child: Text(
                                element.toString(),
                                style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectRemind = newValue!;
                        });
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                      underline: Container(height: 0.0),
                      iconSize: 30,
                      style: Themes.dropDownMenuStyle,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  InputField(
                    title: 'Repeat',
                    hint: _selectRepeat,
                    widget: DropdownButton<String>(
                      value: _selectRepeat,
                      items: repeatList
                          .map(
                            (element) => DropdownMenuItem(
                              value: element,
                              child: Text(
                                element.toString(),
                                style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectRepeat = newValue.toString();
                        });
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                      underline: Container(height: 0.0),
                      iconSize: 30,
                      style: Themes.dropDownMenuStyle,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 15.0,
                    ),
                    child: Row(
                      children: [
                        _colorSelect(),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: MyButton(
                            text: 'Created',
                            onTap: () {
                              validateData();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  sizedBox(100.0, 0.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  getDate() async {
    DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: _selectDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (datePicked != null) {
      setState(() {
        _selectDate = datePicked;
      });
    } else {
      printFullText('error here date');
    }
  }

  getStartTime() async {
    TimeOfDay? timeOfDayPicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    String formatTime = timeOfDayPicked!.format(context);

    setState(() {
      startTime = formatTime;
    });
  }

  getEndTime() async {
    TimeOfDay? timeOfDayPicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        DateTime.now().add(
          const Duration(
            minutes: 30,
          ),
        ),
      ),
    );
    String formatTime = timeOfDayPicked!.format(context);
    setState(() {
      endTime = formatTime;
    });
  }

  validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      addEvent();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        'Required',
        'Enter all fields are required',
        duration: const Duration(seconds: 5),
        colorText: pinkClr,
        backgroundColor: Colors.white,
        icon: const Icon(Icons.warning_outlined, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      printFullText('###Error here...');
    }
  }

  addEvent() async {
    try {
      var data = await _taskController.addEvent(
        task: Task(
          title: _titleController.text,
          note: _noteController.text,
          date: DateFormat.yMMMMEEEEd().format(_selectDate),
          startTime: startTime,
          endTime: endTime,
          remind: _selectRemind,
          repeat: _selectRepeat,
          color: _selectColor,
          isCompleted: 0,
        ),
      );
      printFullText(data.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _colorSelect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: Themes.colorTaskStyle,
        ),
        sizedBox(5.0, 0.0),
        Wrap(
          children: List.generate(
            3,
            (index) => InkWell(
              borderRadius: BorderRadius.circular(10.0),
              onTap: () {
                setState(() {
                  _selectColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? orangeClr
                          : pinkClr,
                  minRadius: 15.0,
                  child: _selectColor == index
                      ? const Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 15.0,
                        )
                      : Container(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
