part of 'AppBloc.dart';

abstract class AppEvent {}

class AppInitialEvent extends AppEvent {}

class AppLoadedEvent extends AppEvent {}

class AppClearEvent extends AppEvent {
  final TaskModel? currentTask;
  AppClearEvent({this.currentTask});
}

class AppSaveEvent extends AppEvent {
  final TaskModel? currentTask;
  AppSaveEvent({this.currentTask});
}
