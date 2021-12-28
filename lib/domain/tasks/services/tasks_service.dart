import 'package:challenge/domain/core/error_content.dart';
import 'package:challenge/domain/tasks/models/group.dart';
import 'package:dartz/dartz.dart';

abstract class ITasksService {
  Future<Either<ErrorContent, List<Group>>> getAlltasks();
}
