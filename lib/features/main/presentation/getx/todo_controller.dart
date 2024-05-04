import 'package:get/get.dart';
import 'package:todo_test_ruskvant/features/main/models/todo_model.dart';
import 'package:todo_test_ruskvant/features/main/repositories/todo_repository.dart';

class TodoController extends GetxController with StateMixin<List<TodoModel>> {
  final TodoRepository todoRepository;
  late final List<TodoModel> todoList;

  TodoController({
    required this.todoRepository,
  });

  @override
  void onInit() {
    getTodoList();
    super.onInit();
  }

  void getTodoList() async {
    change(null, status: RxStatus.loading());
    try {
      final todoListFromDataSource = await todoRepository.getTodoList();
      todoList = todoListFromDataSource;
      change(todoList, status: RxStatus.success());
    } catch (e) {
      todoList = [];
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void changeTodoItem({
    required TodoModel todoItem,
    bool? completed,
    String? title,
  }) {
    int index = todoList.indexOf(todoItem);
    todoList[index] = todoList[index].copyWith(
      completed: completed ?? todoList[index].completed,
      title: title ?? todoList[index].title,
    );
    change(todoList, status: RxStatus.success());
  }

  void addTodoItem({
    required bool completed,
    required String title,
  }) {
    todoList.insert(
      0,
      TodoModel(
        id: todoList.length + 1,
        title: title,
        completed: completed,
      ),
    );
    change(todoList, status: RxStatus.success());
  }

  void removeLastTodo() {
    todoList.removeAt(0);
    change(todoList, status: RxStatus.success());
  }
}
