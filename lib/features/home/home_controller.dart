import 'package:flutter/cupertino.dart';
import 'package:flutter_application_2/features/home/home_repository.dart';
import 'models/models.dart';

class HomeController extends ChangeNotifier {

  final HomeRepository homeRepository = HomeRepository();

  bool isLoading = false;
  bool isAddTaskLoading = false;
  List<TaskModel> tasks = [];

  Future<void> readAll() async {
    isLoading = true;
    notifyListeners();
    final tasks = await homeRepository.readAll();
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
    final task = await homeRepository.create(title);
    if (task != null) {
       final tasks = await homeRepository.readAll();
      if (tasks != null) {
        this.tasks = tasks;
        this.tasks = tasks.reversed.toList();
      }
    }
    isAddTaskLoading = false;
    notifyListeners();
  }
}