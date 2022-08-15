import 'package:flutter_application_2/core/core.dart';
import 'package:flutter_application_2/features/features.dart';

class HomeRepository {
  final HttpClient httpClient = HttpClient();
  Future<List<TaskModel>?> readAll() async {
    return await httpClient.readAll();
    
  }

  Future<TaskModel?> create(String title) async {
    return await httpClient.create(title, 'A Fazer');
  }
}