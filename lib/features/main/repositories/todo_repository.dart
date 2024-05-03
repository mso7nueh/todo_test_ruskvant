import 'package:todo_test_ruskvant/features/main/models/todo_model.dart';
import 'package:todo_test_ruskvant/features/main/services/todo_service.dart';

class TodoRepository {
  final TodoService todoService;

  TodoRepository({
    required this.todoService,
  });

  /// TODO "dartz" package Either<Failure, Result> for error handling
  Future<List<TodoModel>> getTodoList() async {
    try {
      return await todoService.getTodoList();
    } catch (e) {
      return [];
    }
  }
}
