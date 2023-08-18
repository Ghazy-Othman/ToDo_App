//
//
//

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller with ChangeNotifier {
  List<String> completedTasks = [];
  List<String> uncompletedTasks = [];

  Controller() {
    readData();
  }

  // Read data function
  // We have to call this function when the app starts ..... inside initState() methode
  Future<void> readData() async {
    await SharedPreferences.getInstance().then((prefs) {
      completedTasks = prefs.getStringList("completedTasks") ?? [];
      uncompletedTasks = prefs.getStringList("uncompletedTasks") ?? [];
    });
    notifyListeners();
  }

  // Add task
  Future<void> addTask(String value) async {
    await SharedPreferences.getInstance().then((prefs) {
      uncompletedTasks.add(value);
      prefs.setStringList("unCompletedTasks", uncompletedTasks);
    });
    notifyListeners();
  }

  // Remove completed task
  Future<void> removeCompletedTask(int index) async {
    await SharedPreferences.getInstance().then((prefs) {
      completedTasks.removeAt(index);
      prefs.setStringList("completedTasks", completedTasks);
    });
    notifyListeners();
  }

// Remove uncompleted task
  Future<void> removeUncompletedTask(int index) async {
    await SharedPreferences.getInstance().then((prefs) {
      uncompletedTasks.removeAt(index);
      prefs.setStringList("uncompletedTasks", uncompletedTasks);
    });
    notifyListeners();
  }

  // Make task completed
  Future<void> makeTaskCompleted(int index) async {
    await SharedPreferences.getInstance().then((prefs) {
      completedTasks.add(uncompletedTasks[index]);
      removeUncompletedTask(index);
      prefs.setStringList("completedTasks", completedTasks);
      prefs.setStringList("uncompletedTasks", uncompletedTasks);
    });
    notifyListeners();
  }
}
