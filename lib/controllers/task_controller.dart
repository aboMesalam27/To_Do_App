import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> taskList = <Task>[].obs;

  Future<int> addTSK({ Task? task}) {
    return DBHelper.insert(task);

  }


 Future<void> getTask() async {
 try{
   final List<Map<String, dynamic>> tasksGet = await DBHelper.query();
   taskList.assignAll(tasksGet.map((data) => Task.fromJson(data)).toList());
 }catch(e){
   print("error here=$e");
 }
  }

  void delete(Task task) async {
    await DBHelper.delete(task);
    getTask();
  }void deleteAllTask() async {
    await DBHelper.deleteAllTask();
    getTask();
  }
  void markTaskCompleted(int id)async{
    await DBHelper.update(id);
    getTask();
  }
}
