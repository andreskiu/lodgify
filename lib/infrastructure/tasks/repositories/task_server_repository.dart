import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:challenge/domain/core/error_content.dart';
import 'package:challenge/domain/tasks/models/group.dart';
import 'package:challenge/domain/tasks/services/tasks_service.dart';
import 'package:challenge/infrastructure/tasks/services/interfaces/i_task_data_provider.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ITasksDataProvider)
class TaskServerRepository extends ITasksDataProvider {
  final Dio dio;
  TaskServerRepository({
    required this.dio,
  });
  @override
  Future<Either<ErrorContent, List<Group>>> getAlltasks() {
    // TODO: implement getAlltasks
    throw UnimplementedError();
  }
}
