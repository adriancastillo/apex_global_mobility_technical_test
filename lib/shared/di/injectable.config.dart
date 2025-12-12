// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:apex_global_mobility_test/features/country/data/data_sources/country_remote_data_source.dart'
    as _i205;
import 'package:apex_global_mobility_test/features/country/data/data_sources/country_remote_data_source_impl.dart'
    as _i465;
import 'package:apex_global_mobility_test/features/country/data/repositories/country_repository_impl.dart'
    as _i255;
import 'package:apex_global_mobility_test/features/country/domain/repositories/country_repository.dart'
    as _i991;
import 'package:apex_global_mobility_test/features/country/domain/uses_case/fetch_countries.dart'
    as _i703;
import 'package:apex_global_mobility_test/features/todo/data/data_sources/local/todo_local_data_source.dart'
    as _i980;
import 'package:apex_global_mobility_test/features/todo/data/data_sources/local/todo_local_data_source_impl.dart'
    as _i48;
import 'package:apex_global_mobility_test/features/todo/data/data_sources/remote/todo_remote_data_source.dart'
    as _i580;
import 'package:apex_global_mobility_test/features/todo/data/data_sources/remote/todo_remote_data_source_impl.dart'
    as _i803;
import 'package:apex_global_mobility_test/features/todo/data/data_sources/remote/todo_service.dart'
    as _i544;
import 'package:apex_global_mobility_test/features/todo/data/repositories/todo_repository_impl.dart'
    as _i368;
import 'package:apex_global_mobility_test/features/todo/domain/repositories/todo_repository.dart'
    as _i946;
import 'package:apex_global_mobility_test/features/todo/domain/use_cases/fetch_todos.dart'
    as _i250;
import 'package:apex_global_mobility_test/features/todo/domain/use_cases/register_todo.dart'
    as _i538;
import 'package:apex_global_mobility_test/features/todo/domain/use_cases/update_todo.dart'
    as _i731;
import 'package:apex_global_mobility_test/shared/di/modules.dart' as _i273;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:graphql/client.dart' as _i763;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/web.dart' as _i120;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;
import 'package:sqflite/sqflite.dart' as _i779;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final loggerModule = _$LoggerModule();
    final graphQLModule = _$GraphQLModule();
    final networkModule = _$NetworkModule();
    gh.factory<_i528.PrettyDioLogger>(() => loggerModule.prettyDioLogger);
    gh.lazySingleton<_i763.GraphQLClient>(() => graphQLModule.graphQLClient());
    gh.lazySingleton<_i120.Logger>(() => loggerModule.logger);
    gh.singleton<_i205.CountryRemoteDataSource>(
      () => _i465.CountryRemoteDataSourceImpl(gh<_i763.GraphQLClient>()),
    );
    gh.singleton<_i980.TodoLocalDataSource>(
      () => _i48.TodoLocalDataSourceImpl(gh<_i779.Database>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.agmDio(gh<_i528.PrettyDioLogger>()),
      instanceName: 'agm',
    );
    gh.singleton<_i544.TodoService>(
      () => _i544.TodoService.new(gh<_i361.Dio>(instanceName: 'agm')),
    );
    gh.singleton<_i991.CountryRepository>(
      () => _i255.CountryRepositoryImpl(gh<_i205.CountryRemoteDataSource>()),
    );
    gh.singleton<_i703.FetchCountries>(
      () => _i703.FetchCountries(gh<_i991.CountryRepository>()),
    );
    gh.singleton<_i580.TodoRemoteDataSource>(
      () => _i803.TodoRemoteDataSourceImpl(gh<_i544.TodoService>()),
    );
    gh.singleton<_i946.TodoRepository>(
      () => _i368.TodoRepositoryImpl(
        remote: gh<_i580.TodoRemoteDataSource>(),
        local: gh<_i980.TodoLocalDataSource>(),
      ),
    );
    gh.singleton<_i731.UpdateTodo>(
      () => _i731.UpdateTodo(gh<_i946.TodoRepository>()),
    );
    gh.singleton<_i250.FetchTodos>(
      () => _i250.FetchTodos(gh<_i946.TodoRepository>()),
    );
    gh.singleton<_i538.RegisterTodo>(
      () => _i538.RegisterTodo(gh<_i946.TodoRepository>()),
    );
    return this;
  }
}

class _$LoggerModule extends _i273.LoggerModule {}

class _$GraphQLModule extends _i273.GraphQLModule {}

class _$NetworkModule extends _i273.NetworkModule {}
