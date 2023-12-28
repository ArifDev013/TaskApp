import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/Model/TaskModel.dart';
import 'package:task_app/Service/AppService.dart';

part 'AppState.dart';
part 'AppEvent.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppService _appService = AppService();

  AppBloc() : super(AppInitialState()) {
    on<AppEvent>((event, emit) async {
      var data;
      try {
        data = await _appService.getAllTasks();
      } catch (e) {
        print(e.toString());
      }
      emit(AppBlocLoadedState(
          tasks: data,
          currentTask: TaskModel(),
          taskForAssignnt: data.isEmpty ? TaskModel() : data.first,
          txtTaskName: TextEditingController(),
          txtTaskDescription: TextEditingController()));
    });
    on<AppClearEvent>(clear);
    on<AppSaveEvent>(Save);
    add(AppInitialEvent());
  }
  Future clear(AppClearEvent event, Emitter<AppState> emit) async {
    var data = await _appService.getAllTasks();
    emit(AppBlocLoadedState(
        tasks: data,
        currentTask: TaskModel(),
        taskForAssignnt: data.isEmpty ? TaskModel() : data.first,
        txtTaskName: TextEditingController(),
        txtTaskDescription: TextEditingController()));
  }

  Future Save(AppSaveEvent event, Emitter<AppState> state) async {
    var res = await _appService.saveTasks(event.currentTask!);
    if (res > 0) {
      var data = await _appService.getAllTasks();
      emit(AppBlocLoadedState(
          tasks: data,
          currentTask: TaskModel(),
          txtTaskName: TextEditingController(),
          taskForAssignnt: data.isEmpty ? TaskModel() : data.first,
          txtTaskDescription: TextEditingController()));
    }
  }
}
