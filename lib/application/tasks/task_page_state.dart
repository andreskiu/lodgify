import 'package:challenge/domain/core/error_content.dart';
import 'package:challenge/domain/core/use_case.dart';
import 'package:challenge/domain/tasks/models/group.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:challenge/domain/tasks/use_cases/get_tasks_use_case.dart';

@lazySingleton
class TaskPageState extends ChangeNotifier {
  @factoryMethod
  static Future<TaskPageState> initState() async {
    final _state = TaskPageState._(
      getTasksUseCase: GetIt.I.get<GetTasksUseCase>(),
    );
    await _state.getAllTasks();
    return _state;
  }

  late GetTasksUseCase getTasksUseCase;
  TaskPageState._({
    required this.getTasksUseCase,
  });

  ErrorContent? error;
  List<Group> groups = [];

  Future<bool> getAllTasks() async {
    final _params = NoParams();
    final _tasksOrFailure = await getTasksUseCase.call(_params);

    _tasksOrFailure.fold((failure) {
      error = failure;
    }, (grps) {
      groups = grps;
      error = null;
    });
    return _tasksOrFailure.isRight();
  }
}
