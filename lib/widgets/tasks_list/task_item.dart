import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/task_cubit.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/widgets/tasks_list/update_task.dart';

class TaskItem extends StatefulWidget {
  const TaskItem(
    this.task, {
    super.key,
  });
  final Task task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  void _openUpdateTaskOverlay(BuildContext context, Task task) {
    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (ctx) => UpdateTask(task: task, onUpdateTask: _updateTask));
  }

  void _updateTask(Task task) {
    final taskCubit = context.read<TaskCubit>();
    taskCubit.updateTask(task);
  }

  @override
  Widget build(BuildContext context) {
    final taskCubit = context.read<TaskCubit>();
    return InkWell(
      onTap: () {
        _openUpdateTaskOverlay(context, widget.task);
      },
      child: Card(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    widget.task.description ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                      value: widget.task.isDone,
                      onChanged: (_) {
                        taskCubit.toggleTaskStatus(
                            widget.task, widget.task.isDone!);
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
