import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_test_ruskvant/features/main/presentation/getx/todo_controller.dart';
import 'package:todo_test_ruskvant/features/main/presentation/pages/todo_form_screen.dart';
import 'package:todo_test_ruskvant/features/main/presentation/widgets/todo_item_widget.dart';
import 'package:todo_test_ruskvant/locator_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TodoController todoController = sl();

  void goToCreateTaskScreen() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TodoFormScreen(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: todoController.obx(
        (state) => ListView.builder(
          itemBuilder: (context, index) {
            return TodoItemWidget(
              todoModel: state[index],
            );
          },
          itemCount: state!.length,
        ),
        onError: (error) => Center(
          child: Text(error.toString()),
        ),
        onLoading: const Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToCreateTaskScreen,
        tooltip: 'Add task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
