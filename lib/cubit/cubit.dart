import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_task/cubit/states.dart';
import 'package:project_task/service/databese.dart';
import 'package:random_string/random_string.dart';

class TaskBloc extends Cubit<TaskStates> {
  TaskBloc() : super(TaskInitialState());

  static TaskBloc get(context) => BlocProvider.of(context);

  TextEditingController taskTitle = TextEditingController();
  String taskTitleString ='';
  TextEditingController dueDate = TextEditingController();
  String datePiker = '';
  bool isFinish = false;
  Stream? tasksStream;

  void fillDueDateController() {
    dueDate.text = datePiker;
    emit(AddDateInController());
  }

  Future<void> addTask(context) async {
    String id = randomAlphaNumeric(10);
    Map<String, dynamic> taskMap = {
      "ID": id,
      "TitleTask": taskTitle.text,
      "DueDate": dueDate.text,
      "IsFinish": false
    };
    await DatabaseMethods().addTask(taskMap, id).then(
      (value) {
        Navigator.pop(context);
        return Fluttertoast.showToast(
            msg: "Task Upload Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green.shade500,
            textColor: Colors.white,
            fontSize: 16.0);
      },
    );
    emit(TaskAddState());
  }

  Future<void> editTask({context, id}) async {
    Map<String, dynamic> updateTask = {
      "ID": id,
      "TitleTask": taskTitle.text,
      "DueDate": dueDate.text,
      "IsFinish": false
    };
    await DatabaseMethods().editTask(id, updateTask).then(
      (value) {
        Navigator.pop(context);
        return Fluttertoast.showToast(
            msg: "Task Edit Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green.shade500,
            textColor: Colors.white,
            fontSize: 16.0);
      },
    );
    emit(TaskEditState());
  }

  Future<void> editIsFinishTask({context, id,taskTitle,dueDate,isFinish}) async {
    Map<String, dynamic> updateTask = {
      "ID": id,
      "TitleTask": taskTitle,
      "DueDate": dueDate,
      "IsFinish": isFinish = !isFinish
    };
    await DatabaseMethods().editTask(id, updateTask).then(
          (value) {
        return Fluttertoast.showToast(
            msg: isFinish?'Done' : 'Not Done',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green.shade500,
            textColor: Colors.white,
            fontSize: 16.0);
      },
    );
    emit(TaskEditIsFinishState());
  }

  Future<void> deleteTask({context, id}) async {
    await DatabaseMethods().deleteTask(id).then(
      (value) {
        Navigator.pop(context);
        return Fluttertoast.showToast(
            msg: "Task Delete Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red.shade500,
            textColor: Colors.white,
            fontSize: 16.0);
      },
    );
    emit(TaskDeleteState());
  }
}
