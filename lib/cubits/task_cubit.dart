import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/task_state.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit()
      : super(TaskState(tasks: [
          Task(
            title: 'Task 1: Update application UI',
            description: "Change home screen UI profile section",
            isDone: false,
          ),
        ])) {
    loadTasks();
  }

  void addTask(Task task) async {
    final updatedTasks = List<Task>.from(state.tasks)..add(task);
    emit(TaskState(tasks: updatedTasks));
    await saveTasks(updatedTasks);
  }

  void removeTask(Task task) async {
    final updatedTasks = List<Task>.from(state.tasks)..remove(task);
    emit(TaskState(tasks: updatedTasks));
    await saveTasks(updatedTasks);
  }

  void undoRemoveTask(Task task, int taskIndex) async {
    final updatedTasks = List<Task>.from(state.tasks)..insert(taskIndex, task);
    emit(TaskState(tasks: updatedTasks));
    await saveTasks(updatedTasks);
  }

  void toggleTaskStatus(Task task, bool isChecked) async {
    final updatedTasks = [...state.tasks];
    state.tasks[state.tasks.indexOf(task)].isDone = !isChecked;
    emit(TaskState(tasks: state.tasks));
    await saveTasks(updatedTasks);
  }

  void updateTask(Task updatedTask) async {
  final updatedTasks = [...state.tasks];
  
  final index = updatedTasks.indexWhere((task) => task.id == updatedTask.id);
  
  if (index != -1) {
    updatedTasks[index] = updatedTask;
    emit(TaskState(tasks: updatedTasks));
    await saveTasks(updatedTasks);
  }
}

  Future<void> saveTasks(List<Task> tasks) async {
    final preferences = await SharedPreferences.getInstance();
    final taskList = tasks.map((task) => jsonEncode(task.toJson())).toList();
    await preferences.setStringList('tasks', taskList);
    print(preferences.getStringList('tasks'));
  }

  Future<void> loadTasks() async {
    final preferences = await SharedPreferences.getInstance();
    final taskList = preferences.getStringList('tasks');

    if (taskList != null) {
      final tasks = taskList.map((taskString) {
        final taskMap = jsonDecode(taskString);
        return Task.fromJson(taskMap);
      }).toList();
      emit(TaskState(tasks: tasks));
    }
  }
}
