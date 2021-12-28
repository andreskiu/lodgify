import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String description;
  final int value;
  final bool checked;
  const Task({
    required this.description,
    required this.value,
    required this.checked,
  });

  @override
  List<Object?> get props => [
        description,
        value,
        checked,
      ];

  Task copyWith({
    String? description,
    int? value,
    bool? checked,
  }) {
    return Task(
      description: description ?? this.description,
      value: value ?? this.value,
      checked: checked ?? this.checked,
    );
  }
}
