import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/task_cubit.dart';
import 'package:todo_app/cubits/task_state.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/widgets/tasks_list/new_task.dart';
import 'package:todo_app/widgets/tasks_list/tasks_list.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  void _openAddTaskOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (ctx) => NewTask(onAddTask: _addTask));
  }

  void _addTask(Task task) {
    final taskCubit = context.read<TaskCubit>();
    taskCubit.addTask(task);
  }

  void _removeTask(Task task) {
    final taskCubit = context.read<TaskCubit>();
    final taskIndex = taskCubit.state.tasks.indexOf(task);

    taskCubit.removeTask(task);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Task deleted'),
      duration: const Duration(seconds: 4),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          taskCubit.undoRemoveTask(task, taskIndex);
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _openAddTaskOverlay,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Tasks List'),
          centerTitle: true,
        ),
        body: BlocBuilder<TaskCubit, TaskState>(
          builder: (BuildContext context, state) {
            if (state.tasks.isEmpty) {
              return Center(
                child: Text(
                  'No tasks yet. Add your first task!',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                      child: TasksList(
                    tasksList: state.tasks,
                    onRemoveTask: _removeTask,
                  )),
                ],
              );
            }
          },
        ));
  }
}
