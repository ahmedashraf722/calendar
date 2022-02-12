import 'package:calendar/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

class NotificationScreen extends StatefulWidget {
  final String payLoad;

  const NotificationScreen({Key? key, required this.payLoad}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payload = '';

  @override
  void initState() {
    super.initState();
    _payload = widget.payLoad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _payload.split('|')[0],
          style: Themes.headingStyle,
        ),
        elevation: 0.0,
        backgroundColor: context.theme.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Column(
              children: [
                const SizedBox(height: 5.0),
                Text(
                  'Hello, Ahmed',
                  style: Themes.subHeadingStyle,
                ),
                const SizedBox(height: 10.0),
                Text(
                  'You have a new reminder',
                  style: Themes.subStyle,
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                decoration: BoxDecoration(
                  color: bluishClr,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBox(20.0, 0.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.text_fields,
                            size: 30,
                            color: Colors.white,
                          ),
                          sizedBox(0.0, 20.0),
                          Text(
                            'Title',
                            style: Themes.bodyStyle,
                          ),
                        ],
                      ),
                      sizedBox(20.0, 0.0),
                      Text(
                        _payload.split('|')[0],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      sizedBox(20.0, 0.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.description,
                            size: 30,
                            color: Colors.white,
                          ),
                          sizedBox(0.0, 20.0),
                          Text(
                            'Description',
                            style: Themes.bodyStyle,
                          ),
                        ],
                      ),
                      sizedBox(20.0, 0.0),
                      Text(
                        _payload.split('|')[1],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      sizedBox(20.0, 0.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                          sizedBox(0.0, 20.0),
                          Text(
                            'Date',
                            style: Themes.bodyStyle,
                          ),
                        ],
                      ),
                      sizedBox(20.0, 0.0),
                      Text(
                        _payload.split('|')[2],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      sizedBox(20.0, 0.0),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
