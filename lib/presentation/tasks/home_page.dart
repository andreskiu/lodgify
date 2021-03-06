import 'dart:async';

import 'package:challenge/application/tasks/task_page_state.dart';
import 'package:challenge/domain/tasks/models/group.dart';
import 'package:challenge/domain/tasks/models/task.dart';
import 'package:challenge/presentation/core/responsivity/responsive_calculations.dart';
import 'package:challenge/presentation/palette/colors.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'widgets/custom_linear_indicator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<TaskPageState> _createState;

  @override
  void initState() {
    super.initState();
    _createState = GetIt.I.getAsync<TaskPageState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<TaskPageState>(
          future: _createState,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            return ChangeNotifierProvider<TaskPageState>.value(
                value: snapshot.data!,
                builder: (context, child) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Info.horizontalUnit * 2,
                      vertical: Info.verticalUnit * 2,
                    ),
                    child: Card(
                      elevation: 4,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: Info.verticalUnit * 2,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: Info.verticalUnit * 2,
                                horizontal: Info.horizontalUnit * 5,
                              ),
                              child: const CardHeader(),
                            ),
                            Consumer<TaskPageState>(
                              builder: (context, state, child) {
                                return GroupView(
                                  groups: state.groups,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}

class CardHeader extends StatefulWidget {
  const CardHeader({
    Key? key,
  }) : super(key: key);

  @override
  _CardHeaderState createState() => _CardHeaderState();
}

class _CardHeaderState extends State<CardHeader> with TickerProviderStateMixin {
  double currentValue = 0;
  double finalValue = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lodgify Grouped Tasks',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: Info.verticalUnit * 2,
        ),
        Consumer<TaskPageState>(builder: (context, state, child) {
          return CustomLinearIndicator(
            value: state.totalProgressPercent,
          );
        }),
      ],
    );
  }
}

class GroupView extends StatefulWidget {
  const GroupView({
    Key? key,
    required this.groups,
  }) : super(key: key);

  final List<Group> groups;
  @override
  _GroupViewState createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  late List<bool> expandedGroups;
  @override
  void initState() {
    super.initState();
    expandedGroups = List.filled(widget.groups.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (index, isExpanded) {
        setState(() {
          expandedGroups[index] = !isExpanded;
        });
      },
      children: List.generate(widget.groups.length, (groupIndex) {
        return ExpansionPanel(
          headerBuilder: (context, expanded) {
            return Padding(
              padding: EdgeInsets.only(
                left: Info.horizontalUnit * 5,
              ),
              child: Row(
                children: [
                  Icon(
                    expanded
                        ? Icons.assignment_turned_in_outlined
                        : Icons.assignment_outlined,
                    color: expanded ? ColorPalette.green : Colors.black,
                  ),
                  SizedBox(
                    width: Info.horizontalUnit * 4,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      widget.groups[groupIndex].name,
                      style: TextStyle(
                        color: expanded ? ColorPalette.green : Colors.black,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(expanded ? 'Hide' : "Show"),
                ],
              ),
            );
          },
          canTapOnHeader: true,
          isExpanded: expandedGroups[groupIndex],
          body: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.groups[groupIndex].tasks.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, taskIndex) {
              return Padding(
                padding: EdgeInsets.only(
                  left: Info.horizontalUnit * 8,
                  bottom: Info.verticalUnit,
                ),
                child: TaskView(
                  group: widget.groups[groupIndex],
                  task: widget.groups[groupIndex].tasks[taskIndex],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

class TaskView extends StatelessWidget {
  const TaskView({
    Key? key,
    required this.task,
    required this.group,
  }) : super(key: key);
  final Task task;
  final Group group;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: task.checked,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          activeColor: ColorPalette.green,
          onChanged: (checked) {
            GetIt.I.get<TaskPageState>().checkTask(group, task, checked!);
          },
        ),
        SizedBox(
          width: Info.horizontalUnit * 2,
        ),
        Text(task.description),
      ],
    );
  }
}
