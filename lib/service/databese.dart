import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addTask(Map<String, dynamic> taskMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('Task')
        .doc(id)
        .set(taskMap);
  }

  Future<Stream<QuerySnapshot>> getAllTasks() async {
    return await FirebaseFirestore.instance.collection('Task').snapshots();
  }

  Future editTask(String id, Map<String, dynamic> updateTask) async {
    return await FirebaseFirestore.instance
        .collection('Task')
        .doc(id)
        .update(updateTask);
  }

  Future deleteTask(String id) async {
    return await FirebaseFirestore.instance.collection('Task').doc(id).delete();
  }
}
