import 'package:calendar/db/state.dart';
import 'package:calendar/models/task.dart';
import 'package:calendar/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperCubit extends Cubit<DbStates> {
  DBHelperCubit() : super(AppInitialState());

  static DBHelperCubit get(BuildContext context) => BlocProvider.of(context);

  Database? database;

  Future<void> createDatabase() async {
    await openDatabase(
      'event.db',
      version: 1,
      onCreate: (databaseNew, version) async {
        printFullText('database created');
        await databaseNew
            .execute('CREATE TABLE tasks'
                '( id INTEGER PRIMARY KEY,'
                'title TEXT, note TEXT,'
                'date STRING, startTime STRING,'
                'endTime STRING, remind INTEGER,'
                'repeat STRING, color INTEGER, isCompleted INTEGER)')
            .then((value) {
          printFullText('table created');
        }).catchError((error) {
          printFullText('error when creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        printFullText('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    }).catchError((e) {
      printFullText(e.toString());
    });
  }

  insertToDatabase({Task? task}) async {
    await database!.insert('tasks', task!.toJson()).then((value) {
      printFullText('$value inserted successfully');
      emit(AppInsertDatabaseState());
    }).catchError((error) {
      printFullText('error when inserting New Record ${error.toString()}');
    });
  }

  updateData({Task? task}) async {
    database!.update(
      'tasks',
      task!.toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
    emit(AppUpdateDatabaseState());
  }

  void deleteData({Task? task}) async {
    database!.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [task!.id],
    ).then((value) {
      emit(AppDeleteDataFromDatabaseState());
    });
  }

  query() async {
    await database!.query('tasks');
    printFullText('query data');
    emit(AppGetDataFromDatabaseState());
  }

  void updateDataComplete({int? id}) async {
    database!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id = ?
   ''', [1, id]);
    printFullText('update data');
    emit(AppChangeCompleteDatabaseState());
  }
}
