import 'package:flutter/cupertino.dart';
import 'package:flutter_application_2/core/core.dart';
import 'models/models.dart';

class HomeController extends ChangeNotifier {

  final HttpClient _httpClient = HttpClient();

  bool isLoading = false;
  bool isAddTaskLoading = false;
  List<TaskModel> tasks = [];

  Future<void> readAll() async {
    isLoading = true;
    notifyListeners();
    final tasks = await _httpClient.readAll();
    if (tasks != null) {
      this.tasks = tasks;
      this.tasks = tasks.reversed.toList();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> create(String title) async {
    isAddTaskLoading = true;
    notifyListeners();
    final task = await _httpClient.create(title, 'A Fazer');
    if (task != null) {
       final tasks = await _httpClient.readAll();
      if (tasks != null) {
        this.tasks = tasks;
        this.tasks = tasks.reversed.toList();
      }
    }
    isAddTaskLoading = false;
    notifyListeners();
  }
}