import 'package:flutter/material.dart';
import 'package:todo_test_ruskvant/features/main/models/todo_model.dart';
import 'package:todo_test_ruskvant/features/main/presentation/getx/todo_controller.dart';
import 'package:todo_test_ruskvant/features/main/presentation/pages/todo_form_screen.dart';
import 'package:todo_test_ruskvant/locator_service.dart';

class TodoItemWidget extends StatefulWidget {
  final TodoModel todoModel;

  const TodoItemWidget({
    super.key,
    required this.todoModel,
  });

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  final TodoController todoController = sl();

  void goToEditTaskScreen() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TodoFormScreen(
            todoModel: widget.todoModel,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: widget.todoModel.completed,
        onChanged: (bool? value) {
          setState(() {
            todoController.changeTodoItem(
              todoItem: widget.todoModel,
              completed: value ?? false,
            );
          });
        },
      ),
      onTap: goToEditTaskScreen,
      title: Text(
        widget.todoModel.title,
      ),
      subtitle: Text(
        widget.todoModel.id.toString(),
      ),
      trailing: IconButton(
        onPressed: goToEditTaskScreen,
        icon: const Icon(
          Icons.edit,
        ),
      ),
    );
  }
}
