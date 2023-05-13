import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());
  bool isAddShow = false;
      var scaffoldKey = GlobalKey<ScaffoldState>();

  

  

  changeIsAddShow() {
    isAddShow = !isAddShow;
    emit(IsAddShowState());
  }
}
