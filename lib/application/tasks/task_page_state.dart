import 'dart:async';

import 'package:challenge/domain/core/error_content.dart';
import 'package:challenge/domain/core/use_case.dart';
import 'package:challenge/domain/tasks/models/group.dart';
import 'package:challenge/domain/tasks/models/task.dart';
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
    _state.calculateTotalProgress();
    return _state;
  }

  late GetTasksUseCase getTasksUseCase;
  TaskPageState._({
    required this.getTasksUseCase,
  });

  ErrorContent? error;
  List<Group> groups = [];
  double previousProgressPercent = 0;
  double totalProgressPercent = 0;

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

  double calculateTotalProgress() {
    int totalSum = 0;
    int totalProgress = 0;

    groups.forEach((group) {
      group.tasks.forEach((task) {
        totalSum = totalSum + task.value;
        if (task.checked) {
          totalProgress = totalProgress + task.value;
        }
      });
    });
    previousProgressPercent = totalProgressPercent;
    totalProgressPercent = (totalProgress / totalSum) * 100;
    notifyListeners();
    return totalProgressPercent;
  }

  void checkTask(Group group, Task task, bool isChecked) {
    final _groupIndex = groups.indexOf(group);
    if (_groupIndex == -1) {
      return;
    }
    final _taskIndex = groups[_groupIndex].tasks.indexOf(task);
    if (_taskIndex == -1) {
      return;
    }

    final _editedTask = groups[_groupIndex].tasks[_taskIndex].copyWith(
          checked: isChecked,
        );
    groups[_groupIndex].tasks[_taskIndex] = _editedTask;
    calculateTotalProgress();

    notifyListeners();
  }
}
