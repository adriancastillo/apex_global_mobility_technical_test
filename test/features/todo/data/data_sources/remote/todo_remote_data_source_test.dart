import 'package:apex_global_mobility_test/features/todo/data/data_sources/remote/todo_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:apex_global_mobility_test/features/todo/data/data_sources/remote/todo_remote_data_source.dart';
import 'package:apex_global_mobility_test/features/todo/data/data_sources/remote/todo_service.dart';
import 'package:apex_global_mobility_test/features/todo/data/models/todo_model.dart';

class MockTodoService extends Mock implements TodoService {}

void main() {
  late MockTodoService service;
  late TodoRemoteDataSource datasource;

  setUp(() {
    service = MockTodoService();
    datasource = TodoRemoteDataSourceImpl(service);
  });

  test('Should return list of todos when service returns data', () async {
    // Arrange
    final mockResponse = [TodoModel(id: 1, title: 'Test', completed: false)];

    when(() => service.getTodos()).thenAnswer((_) async => mockResponse);

    // Act
    final result = await datasource.fetchTodos();

    // Assert
    expect(result.length, 1);
    expect(result.first.title, 'Test');
    verify(() => service.getTodos()).called(1);
  });

  test('Should throw exception when service fails', () async {
    // Arrange
    when(() => service.getTodos()).thenThrow(Exception('Network error'));

    // Act & Assert
    expect(() => datasource.fetchTodos(), throwsException);

    verify(() => service.getTodos()).called(1);
  });
}
