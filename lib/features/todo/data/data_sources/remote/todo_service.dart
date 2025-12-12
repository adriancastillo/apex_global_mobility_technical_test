import 'package:apex_global_mobility_test/shared/constans.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../models/todo_model.dart';

part 'todo_service.g.dart';

@singleton
@RestApi(baseUrl: todoBaseUrl)
abstract class TodoService {
  @factoryMethod
  factory TodoService(@Named('agm') Dio dio) = _TodoService;

  @GET('/todos')
  Future<List<TodoModel>> getTodos();
}
