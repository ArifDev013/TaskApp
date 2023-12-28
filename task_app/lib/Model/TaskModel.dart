class TaskModel {
  int? id;
  String? taskName;
  String? taskDiscription;
  String? employee;

  TaskModel({
    this.id,
    this.taskName = "",
    this.taskDiscription,
    this.employee,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        taskName: json["taskName"].toString(),
        taskDiscription: json["TaskDiscription"],
        employee: json["employee"],
      );

  Map<String, dynamic> toJson({bool isUpdate = false}) => {
        if (!isUpdate) ...{"id": id},
        "taskName": taskName.toString(),
        "TaskDiscription": taskDiscription,
        "employee": employee,
      };
}
