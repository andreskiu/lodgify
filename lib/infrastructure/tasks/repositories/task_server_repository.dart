import 'dart:convert';

import 'package:challenge/infrastructure/tasks/models/mock_progress_response.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:challenge/domain/core/error_content.dart';
import 'package:challenge/domain/tasks/models/group.dart';
import 'package:challenge/infrastructure/tasks/services/interfaces/i_task_data_provider.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ITasksDataProvider)
class TaskServerRepository extends ITasksDataProvider {
  final Dio dio;
  TaskServerRepository({
    required this.dio,
  });
  @override
  Future<dartz.Either<ErrorContent, List<Group>>> getAlltasks() async {
    try {
      final _response = await dio.get('/mock-progress');
      // parse json
      final String data = _response.data;
      // transform into entities
      final List<dynamic> _responseGroups = json.decode(data);
      final _groups = _responseGroups
          .map((map) => GroupResponse.fromMap(map).toEntity())
          .toList();

      return Right(_groups);
    } on Exception catch (e) {
      return Left(ErrorContent.server("Fail to get tasks"));
    }
  }
}
