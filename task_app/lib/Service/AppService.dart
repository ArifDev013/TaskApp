import 'package:task_app/Model/TaskModel.dart';
import 'package:task_app/Util/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class AppService {
  Future getAllTasks() async {
    List<TaskModel> result = List.empty(growable: true);
    Database db = await DbHelper.db;
    var res = await db.rawQuery("Select * from Tasks");
    if (res.isEmpty) return null;
    List.generate(
        res.length, (index) => result.add(TaskModel.fromJson(res[index])));
    return result;
  }

  Future saveTasks(TaskModel model) async {
    Database db = await DbHelper.db;
    if (model.id != null) {
      return await db.update("Tasks", model.toJson(isUpdate: true),
          where: 'id=?', whereArgs: [model.id]);
    } else {
      return await db.insert("Tasks", model.toJson());
    }
  }
}
