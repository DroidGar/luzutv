import 'dart:async';
import 'dart:io';

import 'package:http/src/base_request.dart';
import 'package:http/src/base_response.dart';
import 'package:http_interceptor/models/interceptor_contract.dart';
import 'package:luzu/features/auth/data/datasource/auth_local_data_source.dart';

class AuthInterceptor implements InterceptorContract {
  final AuthLocalDataSourceBase localDataSource;

  AuthInterceptor(this.localDataSource);

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async {
    final session = await localDataSource.getSession();
    request.headers["x-authorization"] = session.token;
    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) {
    return response;
  }

  @override
  FutureOr<bool> shouldInterceptRequest() {
    return true;
  }

  @override
  FutureOr<bool> shouldInterceptResponse() {
    return false;
  }
}
