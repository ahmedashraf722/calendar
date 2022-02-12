import 'package:calendar/models/task.dart';
import 'package:calendar/ui/size_config.dart';
import 'package:calendar/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

SizedBox sizedBox(double h, double w) {
  return SizedBox(
    height: h,
    width: w,
  );
}

showBottomSheetItem(BuildContext context, Task task) {
  Get.bottomSheet(
    SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        width: MediaQuery.of(context).size.width,
        color: Get.isDarkMode ? darkHeaderClr : Colors.white,
        child: Column(
          children: [
            sizedBox(20.0, 0.0),
            task.isCompleted == 1
                ? Container()
                : buildBottomSheet(
                    label: 'Event Completed',
                    onTap: () {
                      Get.back();
                    },
                    clr: primaryClr,
                  ),
            task.isCompleted == 1
                ? Container()
                : Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),
            buildBottomSheet(
              label: 'Delete Event',
              onTap: () {
                Get.back();
              },
              clr: Colors.red[300]!,
            ),
            Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),
            buildBottomSheet(
              label: 'Cancel',
              onTap: () {
                Get.back();
              },
              clr: primaryClr,
            ),
            sizedBox(20.0, 0.0),
          ],
        ),
      ),
    ),
  );
}

buildBottomSheet({
  required String label,
  required Function() onTap,
  required Color clr,
  bool isClose = false,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 65,
      width: SizeConfig.screenWidth * 0.9,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: isClose
              ? Get.isDarkMode
                  ? Colors.grey.shade600
                  : Colors.grey.shade300
              : clr,
        ),
        borderRadius: BorderRadius.circular(20.0),
        color: isClose ? Colors.transparent : clr,
      ),
      child: Center(
        child: Text(
          label,
          style: isClose
              ? Themes.titleStyle
              : Themes.titleStyle.copyWith(
                  color: Colors.white,
                ),
        ),
      ),
    ),
  );
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); //size each chuck 800
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });
}

void navigateAndFinish(BuildContext ctx, Widget widget) =>
    Navigator.pushAndRemoveUntil(
      ctx,
      MaterialPageRoute(builder: (ctx) => widget),
      (route) => false,
    );

TextFormField defaultFormFieldF({
  required TextEditingController controller,
  required TextInputType type,
  required FormFieldValidator<String>? validate,
  required String label,
  String? text,
  IconData? iconPrefix,
  IconData? suffix,
  FocusNode? focusNodes,
  Widget? suffixIcon,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChanged,
  required GestureTapCallback onTab,
  bool isPassword = false,
  bool isClicked = true,
  bool autoFocused = false,
  EdgeInsetsGeometry? contentPadding = const EdgeInsets.all(4.0),
  double radiusEnable = 25.0,
  double radiusBorder = 25.0,
  int maxLinesL = 1,
  Color colorE = Colors.blueGrey,
  double radiusWidth = 2.0,
  TextAlignVertical? textAlignVertical = TextAlignVertical.top,
}) {
  return TextFormField(
    maxLines: maxLinesL,
    controller: controller,
    keyboardType: type,
    enabled: isClicked,
    textAlignVertical: textAlignVertical,
    autofocus: autoFocused,
    focusNode: focusNodes,
    validator: validate,
    onTap: onTab,
    onChanged: onChanged,
    obscureText: isPassword,
    onFieldSubmitted: onSubmit,
    decoration: InputDecoration(
      contentPadding: contentPadding,
      label: Text(label),
      hintText: text,
      prefixIcon: Icon(iconPrefix),
      suffix: Icon(suffix),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusEnable),
        borderSide: BorderSide(
          color: colorE,
          width: radiusWidth,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusBorder),
        borderSide: const BorderSide(
          color: Colors.deepOrange,
        ),
      ),
    ),
  );
}

void showToast({
  required String message,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: chooseToastState(state),
      textColor: Colors.white,
      fontSize: 20.0,
    );

enum ToastState { success, failed, warned }

Color chooseToastState(ToastState state) {
  switch (state) {
    case ToastState.success:
      return Colors.green;
    case ToastState.failed:
      return Colors.red;
    case ToastState.warned:
      return Colors.yellow;
  }
}

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double height = 45.0,
  bool isUpperCase = true,
  double radius = 10.0,
  VoidCallback? function,
  required String text,
}) {
  return Container(
    width: width,
    height: height,
    child: MaterialButton(
      onPressed: function,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: background,
    ),
  );
}

Widget defaultTextButton({
  required VoidCallback? function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );
