import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

class NewTask extends StatefulWidget {
  const NewTask({
    super.key,
    required this.onAddTask,
  });

  final void Function(Task task) onAddTask;

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _submitTaskData() {
    if (_titleController.text.trim().isEmpty) {
      if (Platform.isIOS) {
        showCupertinoDialog(
          context: context,
          builder: (ctx) {
            return CupertinoAlertDialog(
              title: const Text('Invalid input'),
              content: const Text('Please enter a valid title'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Ok'))
              ],
            );
          },
        );
      } else {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Invalid input'),
                content: const Text('Please enter a valid title'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('Ok'))
                ],
              );
            });
      }
      return;
    }
    widget.onAddTask(
      Task(
        title: _titleController.text,
        description: _descriptionController.text,
        isDone: false,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: width <= 600
              ? MediaQuery.of(context).size.height / 2
              : double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 10, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (width >= 600)
                    Column(
                      children: [
                        TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text(
                              'Title',
                            ),
                            counterText: '',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: _descriptionController,
                          maxLength: 50,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            alignLabelWithHint: true,
                            counterText: '',
                            label: Text('Description (optional)'),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _titleController.clear();
                                  _descriptionController.clear();
                                },
                                child: const Text('Cancel')),
                            const SizedBox(
                              width: 5,
                            ),
                            ElevatedButton(
                                onPressed: _submitTaskData,
                                child: const Text('Save Task')),
                          ],
                        )
                      ],
                    )
                  else
                    Column(
                      children: [
                        TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text('Title'),
                              counterText: '',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: _descriptionController,
                          maxLength: 50,
                          maxLines: 6,
                          decoration: const InputDecoration(
                            counterText: '',
                            alignLabelWithHint: true,
                            label: Text('Description (optional)'),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _titleController.clear();
                                  _descriptionController.clear();
                                },
                                child: const Text('Cancel')),
                            const SizedBox(
                              width: 5,
                            ),
                            ElevatedButton(
                                onPressed: _submitTaskData,
                                child: const Text('Save Task')),
                          ],
                        )
                      ],
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
