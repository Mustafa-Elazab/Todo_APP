import 'package:get/get.dart';
import 'package:todo_app/app/data/models/task.dart';
import 'package:todo_app/app/data/services/db_helper.dart';

class TaskController extends GetxController {


  var taskList = <Task>[].obs;
  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.getAll();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    DBHelper.delete(task);
    getTasks();
    update();
  }

  void taskComplete(int id) async{
    await DBHelper.update(id);
    getTasks();
    update();
  }
}
