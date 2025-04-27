import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/widgets/tasks_list/task_item.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.tasksList,
    required this.onRemoveTask,
  });

  final void Function(Task task) onRemoveTask;

  final List<Task> tasksList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasksList.length,
      itemBuilder: (context, index) {
        final task = tasksList[index];
        return Dismissible(
            key: ValueKey(task.id),
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.7),
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(
                  horizontal: Theme.of(context).cardTheme.margin!.horizontal),
              child: const Icon(Icons.delete),
            ),
            onDismissed: (direction) => onRemoveTask(task),
            child: TaskItem(task, key: ValueKey(task.id),));
      },
    );
  }
}
