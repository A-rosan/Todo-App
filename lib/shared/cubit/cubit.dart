import 'package:flutter/material.dart';
import 'package:flutter_application_2/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/archive_screen/archive_screen.dart';
import '../../modules/done_screen/done_screen.dart';
import '../../modules/tasks_screen/tasks_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  var database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  int screenIndex = 0;
  List<Widget> screens = [
    const TasksScreen(),
    const DoneScreen(),
    const ArchiveScreen(),
  ];

  List<String> titles = [
    "tasks screen",
    "done screen",
    "archive screen",
  ];
  void changeIndex(int index) {
    screenIndex = index;
    emit(ChaneBottmNavBar());
  }

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print("Database created");
        database
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print("Database table created");
        }).catchError((error) {
          print(error.toString());
        });
      },
      onOpen: (database) {
        getData(database);
        print("Database opend");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabase());
    });
  }

  insertDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print("$value inserted success");
        emit(AppInsertDatabase());
        getData(database);
      }).catchError((error) {
        print("Error in inserting ${error.toString()}");
      });
      // return null;
    });
  }

  void getData(database) async {
    newTasks=[];
    doneTasks=[];
    archiveTasks=[];
    return await database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archiveTasks.add(element);
        }
      });
      emit(AppGetDatabase());
    });
  }
  void deleteData({required int id})async {
    return await database
    .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value){
      getData(database);
      emit(AppDeleteDatabase());
    });
  }

  void upateData({
    required String status,
    required int id,
  }) async {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
          getData(database);
      emit(AppUpdateDatabase());
    });
  }
}
