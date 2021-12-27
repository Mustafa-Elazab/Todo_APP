import 'package:sqflite/sqflite.dart';
import 'package:todo_app/app/data/models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _versoin = 1;
  static const String _tableName = "tasks";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _db =
          await openDatabase(_path, version: _versoin, onCreate: (db, version) {
      
        return db.execute(
          "CREATE TABLE $_tableName("
          "id INTEGER PRIMARY KEY, "
          "title TEXT, note TEXT, date TEXT, "
          "startTime TEXT, endTime TEXT, "
          "remind INTEGER, repeat TEXT, "
          "color INTEGER, "
          "isComplete INTEGER)",
        );
      });
    // ignore: empty_catches
    } catch (e) {
   
    }
  }

  static Future<int> insert(Task? task) async {
    return await _db!.insert(_tableName, task!.toJson());
  }

   static Future <List<Map<String,dynamic>>> getAll () async {
    return await _db!.query(_tableName);
  }
 
 static delete(Task task){
     _db!.delete(_tableName,where: 'id=?',whereArgs: [task.id]);
     
    
 }

  static update(int id) async{
   return await _db!.rawUpdate('''
     UPDATE tasks
     SET isComplete = ? 
     WHERE id =?
     ''', [1, id]);
    
 }

}
