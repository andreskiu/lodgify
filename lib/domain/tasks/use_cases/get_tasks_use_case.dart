import 'package:challenge/domain/core/error_content.dart';
import 'package:challenge/domain/core/use_case.dart';
import 'package:challenge/domain/tasks/models/group.dart';
import 'package:challenge/domain/tasks/services/tasks_service.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetTasksUseCase extends UseCase<List<Group>, NoParams> {
  final ITasksService service;

  GetTasksUseCase(this.service);

  @override
  Future<Either<ErrorContent, List<Group>>> call(
    NoParams params,
  ) async {
    // final _paramsError = params.areValid();
    // if (_paramsError != null) {
    //   return Left(_paramsError);
    // }
    return service.getAlltasks();
  }
}
