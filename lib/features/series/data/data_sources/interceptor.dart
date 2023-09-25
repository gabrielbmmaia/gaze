import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor implements InterceptorContract {
  Logger logger = Logger();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    logger.v(
      'Request: ${data.baseUrl}\n'
      'Headers: ${data.headers}\n'
      'Body: ${data.body}',
    );
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode ~/ 100 == 2) {
      logger.i(
        'Request: ${data.url}\n'
        'StatusCode: ${data.statusCode}\n'
        'Headers: ${data.headers}\n'
        'Body: ${data.body}',
      );
    } else {
      logger.e(
        'Request: ${data.url}\n'
        'StatusCode: ${data.statusCode}\n'
        'Headers: ${data.headers}\n'
        'Body: ${data.body}',
      );
    }
    return data;
  }
}

 final client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
