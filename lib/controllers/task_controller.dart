import 'package:calendar/db/db_helper_cubit.dart';
import 'package:calendar/models/task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  final RxList<Task> tasks = <Task>[].obs;

  addEvent({Task? task, BuildContext? context}) {
    var cubit = DBHelperCubit.get(context!);
    cubit.insertToDatabase(task: task);
  }

  getEvents({BuildContext? context}) async {
    var cubit = DBHelperCubit.get(context!);
    final List<Map<String, dynamic>> taskList = await cubit.query();
    tasks.assignAll(taskList.map((e) => Task.fromJson(e)).toList());
  }

  updateEvents({Task? task, BuildContext? context}) async {
    var cubit = DBHelperCubit.get(context!);
    cubit.updateData(task: task);
    getEvents();
  }

  updateMarkCompletedEvents({int? id, BuildContext? context}) async {
    var cubit = DBHelperCubit.get(context!);
    cubit.updateDataComplete(id: id);
    getEvents();
  }

  deleteEvents({Task? task, BuildContext? context}) async {
    var cubit = DBHelperCubit.get(context!);
    cubit.deleteData(task: task);
    getEvents();
  }
}
