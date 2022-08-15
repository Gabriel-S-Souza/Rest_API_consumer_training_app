import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_application_2/features/home/models/task_model.dart';
import 'core.dart';

class HttpClient {
  final _dio = Dio(
    BaseOptions(
      baseUrl: apiDomain + apiBasePath,
    ),
  );

  Future read() async {}

  Future<List<TaskModel>?> readAll() async {
    try {
      final response = await _dio.get('/tasks');

      return (response.data as List).map((toReceive) => 
          TaskModel.fromJson(toReceive)).toList();

    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future create(String title, String status) async {
    try {
      final response = await _dio.post(
        '/tasks',
        data: {
          'title': title,
          'status': status,
        },
      );

      return TaskModel.fromJson(response.data);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future delete() async {}
}