import 'package:apex_global_mobility_test/shared/constans.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:graphql/client.dart';
import 'package:logger/web.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class GraphQLModule {
  @lazySingleton
  GraphQLClient graphQLClient() {
    final link = HttpLink(countryBaseUrl);

    return GraphQLClient(link: link, cache: GraphQLCache());
  }
}

@module
abstract class NetworkModule {
  Dio _baseDio(PrettyDioLogger logger) {
    Dio dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.interceptors.add(logger);

    return dio;
  }

  @Named('agm')
  @lazySingleton
  Dio agmDio(PrettyDioLogger logger) {
    return _baseDio(logger);
  }
}

@module
abstract class LoggerModule {
  @lazySingleton
  Logger get logger => Logger(
    filter: LoggerFilter(),
    printer: PrettyPrinter(
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  PrettyDioLogger get prettyDioLogger => PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    error: true,
    compact: true,
    maxWidth: 90,
  );
}

class LoggerFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return kReleaseMode ? false : true;
  }
}
