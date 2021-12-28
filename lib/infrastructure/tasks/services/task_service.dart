import 'package:dartz/dartz.dart';

import 'package:challenge/domain/core/error_content.dart';
import 'package:challenge/domain/tasks/models/group.dart';
import 'package:challenge/domain/tasks/services/tasks_service.dart';
import 'package:injectable/injectable.dart';

import 'interfaces/i_task_data_provider.dart';

@lazySingleton
class TaskService extends ITasksService {
  final ITasksDataProvider provider;
  TaskService({
    required this.provider,
  });
  @override
  Future<Either<ErrorContent, List<Group>>> getAlltasks() {
    return provider.getAlltasks();
  }
}
