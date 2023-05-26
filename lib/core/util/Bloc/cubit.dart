import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_algoriza/core/util/Bloc/states.dart';
import 'package:todo_algoriza/core/util/services/notfication_services.dart';

class AppBloc extends Cubit<AppStates> {
  AppBloc() : super(InitialAppState());

  static AppBloc get(context) => BlocProvider.of(context);

  late Database db;

  TextEditingController TitleController = TextEditingController();
  TextEditingController DatelineController = TextEditingController();
  TextEditingController StartTimeController = TextEditingController();
  TextEditingController EndTimeController = TextEditingController();
  TextEditingController RemindController = TextEditingController();
  TextEditingController RepeatController = TextEditingController();
  TextEditingController emailAdressController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  DateTime selectedDateNow = DateTime.now();

  List<Map> allTasks = [];
  List<Map> CompletedTasks = [];
  List<Map> UnCompletedTasks = [];
  List<Map> FavoriteTask = [];

  List<Color> colorslist = [
    Colors.blue.shade400,
    Color.fromARGB(255, 114, 91, 99),
    Colors.orange.shade400,
    Colors.yellow.shade600
  ];

  //Create and Open DataBase and Table
  // void CreateUserDataBase() async {
  //   await openDatabase(
  //     'Todo.db',
  //     version: 1,
  //     onCreate: (database, version) async {
  //       await database
  //           .execute(
  //               'CREATE TABLE User (userName TEXT, email TEXT, password TEXT)')
  //           .then((value) {
  //         debugPrint('Table created');
  //         emit(AppUserDataBaseTableCreatedState());
  //       }).catchError((error) {
  //         debugPrint('Error when Create Table ${error.toString()}');
  //       });
  //     },
  //     onOpen: (database) {
  //       db = database;
  //       // GetDataFromDataBase(db);
  //       debugPrint('open DataBase');
  //     },
  //   ).then((value) {
  //     db = value;
  //     emit(AppCreateUserDataBaseState());
  //   });
  // }

  //Create and Open DataBase and Table
  void CreateDataBase() async {
    await openDatabase(
      'Todo.db',
      version: 1,
      onCreate: (database, version) async {
        debugPrint('DataBase is Created');
        await database
            .execute(
                'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, dateline TEXT, starttime TEXT, endtime TEXT,remind TEXT,repreat TEXT ,iscompleted INTEGER , is_fav TEXT,status TEXT)')
            .then((value) {
          debugPrint('Table created');
          emit(AppDataBaseTableCreatedState());
        }).catchError((error) {
          debugPrint('Error when Create Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        db = database;
        GetDataFromDataBase(db);
        debugPrint('open DataBase');
      },
    ).then((value) {
      db = value;
      emit(AppCreateDataBaseState());
    });
  }

  void InsertDataBase({bool isFav = false}) async {
    await db.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO Tasks(title, dateline,starttime,endtime,remind,repreat,iscompleted,status, is_fav) VALUES("${TitleController.text}"," ${DatelineController.text}", "${StartTimeController.text}","${EndTimeController.text}","${RemindController.text}","${RepeatController.text}","0","unCompleted" ,"${isFav}")')
          .then((value) {
        debugPrint('$value insert successfully');
        TitleController.clear();
        DatelineController.clear();
        StartTimeController.clear();
        EndTimeController.clear();
        RemindController.clear();
        RepeatController.clear();
        GetDataFromDataBase(db);
        emit(AppInsertDataBaseState());
      }).catchError((error) {
        debugPrint('Error when insert new  ${error.toString()}');
      });
    });
  }

  // void InsertUserDataBase() async {
  //   await db.transaction((txn) async {
  //     txn
  //         .rawInsert(
  //             'INSERT INTO User(username, email,password) VALUES("${userNameController.text}"," ${emailAdressController.text}", "${passwordController.text}")')
  //         .then((value) {
  //       debugPrint('$value insert successfully');
  //       userNameController.clear();
  //       passwordController.clear();
  //       emailAdressController.clear();
  //       GetDataFromDataBase(db);
  //       emit(AppInsertUserDataBaseState());
  //     }).catchError((error) {
  //       debugPrint('Error when insert new  ${error.toString()}');
  //     });
  //   });
  // }

  void GetDataFromDataBase(db) async {
    allTasks = [];
    CompletedTasks = [];
    UnCompletedTasks = [];
    FavoriteTask = [];
    emit(AppGetDataBaseLoadingState());
    //now retrieving data
    db.rawQuery('SELECT * FROM Tasks').then((value) {
      allTasks = value;
      value.forEach((element) {
        if (element['status'] == 'completed') {
          CompletedTasks.add(element);
        } else if (element['status'] == 'unCompleted') {
          UnCompletedTasks.add(element);
        }
        if (element['is_fav'] == 'true') {
          FavoriteTask.add(element);
        }
      });
      debugPrint(allTasks.toString());
      emit(AppGetDataBaseState());
    });
  }

  void DeleteItem({required int id}) async {
    db.rawDelete('DELETE FROM Tasks WHERE id = ?', ['$id']).then((value) {
      GetDataFromDataBase(db);
      debugPrint('Success Item Deleted');
      emit(AppDeleteItemState());
    });
  }

  void deleteAll({@required Database}) async {
    db.rawDelete('Delete  from Tasks').then((value) {
      GetDataFromDataBase(db);
      emit(AppDeleteAllDataBaseState());
    });
  }

  void MoveDataBaseScreen({required String status, required int id}) async {
    emit(AppMoveDataBaseScreenState());
    db.rawUpdate('UPDATE Tasks SET status = ?   WHERE id = ?',
        ['$status', '$id']).then((value) {
      GetDataFromDataBase(db);
      emit(AppMoveDataBaseScreenState());
    });
  }

  void MarkIsCompleted({
    required int id,
    required int iscompleted,
  }) {
    emit(AppMarkIsCompletedStete());
    db.rawUpdate('UPDATE Tasks SET iscompleted = ?  WHERE id = ?',
        ['$iscompleted', '$id']).then((value) {
      GetDataFromDataBase(db);
      emit(AppMarkIsCompletedStete());
    });
  }

  late NotifyHelper notifyHelper;

  void Notification() {
    notifyHelper = NotifyHelper();
    notifyHelper.requestIOSPermissions();
    notifyHelper.initializeNotification();
    emit(NotifictayionAppState());
  }

  void setIsChecked({required bool value}) {
    value = !value;
    emit(AppSetCheckedSuccess(value));
  }

  void setIsFav(Map<dynamic, dynamic> model) {
    emit(AppSetFavLoadingState());
    db
        .rawUpdate(
            'UPDATE tasks SET is_fav = "${model['is_fav'] == 'true' ? 'false' : 'true'}" WHERE id = "${model['id']}"')
        .then((value) {
      print('${model['title']} is updated successfully');
      emit(AppSetFavSuccessfulState());
      GetDataFromDataBase(db);
    }).catchError((error) {
      print('Error when update ${model['title']} ${error.toString()}');
      emit(AppSetFavErrorState(error));
    });
  }

  DateTime? scheduleDate;

  void setSchedulDate(DateTime date) {
    scheduleDate = date;
    emit(SelectedDateLineValueState());
  }
}
