import 'dart:convert';

import 'package:challenge/domain/tasks/models/group.dart';
import 'package:challenge/domain/tasks/models/task.dart';

class GroupResponse {
  final String name;
  final List<TaskResponse> tasks;
  GroupResponse({
    required this.name,
    required this.tasks,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'tasks': tasks.map((x) => x.toMap()).toList(),
    };
  }

  factory GroupResponse.fromMap(Map<String, dynamic> map) {
    return GroupResponse(
      name: map['name'] ?? '',
      tasks: List<TaskResponse>.from(
          map['tasks']?.map((x) => TaskResponse.fromMap(x))),
    );
  }

  Group toEntity() {
    return Group(
      name: name,
      tasks: tasks.map((t) => t.toEntity()).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupResponse.fromJson(String source) =>
      GroupResponse.fromMap(json.decode(source));
}

class TaskResponse {
  final String description;
  final String? name;
  final int value;
  final bool checked;
  const TaskResponse({
    required this.description,
    this.name = '',
    required this.value,
    required this.checked,
  });

  Task toEntity() {
    return Task(
      description: description.isEmpty ? name ?? '' : description,
      checked: checked,
      value: value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'name': name,
      'value': value,
      'checked': checked,
    };
  }

  factory TaskResponse.fromMap(Map<String, dynamic> map) {
    return TaskResponse(
      description: map['description'] ?? '',
      name: map['name'],
      value: map['value']?.toInt() ?? 0,
      checked: map['checked'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskResponse.fromJson(String source) =>
      TaskResponse.fromMap(json.decode(source));
}
