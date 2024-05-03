import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:todo_test_ruskvant/features/main/presentation/getx/todo_controller.dart';
import 'package:todo_test_ruskvant/features/main/repositories/todo_repository.dart';
import 'package:todo_test_ruskvant/features/main/services/todo_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // GetX
  sl.registerLazySingleton<TodoController>(() => Get.put(TodoController(todoRepository: sl())));

  // Repository
  sl.registerLazySingleton<TodoRepository>(() => TodoRepository(todoService: sl()));

  // Services
  sl.registerLazySingleton<TodoService>(() => TodoService(sl()));

  // External
  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
      ),
    ),
  );
}
