import 'package:equatable/equatable.dart';

import 'package:challenge/domain/tasks/models/task.dart';

class Group extends Equatable {
  final String name;
  final List<Task> tasks;
  const Group({
    required this.name,
    required this.tasks,
  });

  @override
  List<Object?> get props => [
        name,
        tasks.length,
      ];
}
