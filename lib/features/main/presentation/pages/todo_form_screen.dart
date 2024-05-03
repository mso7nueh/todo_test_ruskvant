import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_test_ruskvant/features/main/models/todo_model.dart';
import 'package:todo_test_ruskvant/features/main/presentation/getx/todo_controller.dart';
import 'package:todo_test_ruskvant/locator_service.dart';

class TodoFormScreen extends StatefulWidget {
  final TodoModel? todoModel;

  const TodoFormScreen({
    super.key,
    this.todoModel,
  });

  @override
  State<TodoFormScreen> createState() => _TodoFormScreenState();
}

class _TodoFormScreenState extends State<TodoFormScreen> {
  final TodoController todoController = sl();
  late final TextEditingController textEditingController;
  late bool isCompleted;

  @override
  void initState() {
    isCompleted = widget.todoModel?.completed ?? false;
    textEditingController = TextEditingController(text: widget.todoModel != null ? widget.todoModel!.title : '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.todoModel != null ? widget.todoModel!.id.toString() : 'Create task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextFormField(
              controller: textEditingController,
            ),
            const SizedBox(height: 16),
            CupertinoSwitch(
              value: isCompleted,
              onChanged: (value) {
                setState(() {
                  isCompleted = value;
                });
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (widget.todoModel != null) {
                    todoController.changeTodoItem(
                      todoItem: widget.todoModel!,
                      completed: isCompleted,
                      title: textEditingController.text,
                    );
                  } else {
                    todoController.addTodoItem(
                      completed: isCompleted,
                      title: textEditingController.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Task added successfully!'),
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          todoController.removeLastTask();
                        },
                      ),
                    ));
                  }
                  Navigator.pop(context);
                },
                child: Text(widget.todoModel != null ? 'Save' : 'Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
