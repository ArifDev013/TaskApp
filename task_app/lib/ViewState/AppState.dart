part of 'AppBloc.dart';

abstract class AppState {}

class AppInitialState extends AppState {}

class AppBlocLoadedState extends AppState {
  final List<TaskModel>? tasks;
  TaskModel? currentTask;
  TaskModel? taskForAssignnt;
  TextEditingController? txtTaskName;
  TextEditingController? txtTaskDescription;
  List<String> employees = ["EMPLOYEE1", "EMPLOYEE2", "EMPLOYEE3", "EMPLOYEE4"];
  AppBlocLoadedState(
      {this.tasks,
      this.currentTask,
      this.taskForAssignnt,
      this.txtTaskDescription,
      this.txtTaskName}) {}
  clear() async {
    currentTask = TaskModel();
  }

  // Future<bool> validateFields() async =>
  //     txtTaskName!.text.isEmpty ? false : true;
}
