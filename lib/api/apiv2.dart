
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:idsr/data/constants.dart';
import 'package:idsr/session_hive.dart';


class ApiV2 {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: Constants.baseUrl));
  final String baseUrl = Constants.baseUrl;
  String? token;

  ApiV2._internal();

  static final _singleton = ApiV2._internal();

  factory ApiV2() => _singleton;

  static Dio createDio() {
    final basicAuth = 'Basic ${base64Encode(utf8.encode('${Session.getUsername()}:${Session.getPassword()}'))}';

    var dio = Dio(BaseOptions(
      headers: {
        "Authorization": basicAuth,
        "Content-Type":"application/json"
      },
      baseUrl:Constants.baseUrl,
      receiveTimeout: Duration(seconds: 120), // Increased from 60 to 120 seconds
      connectTimeout: Duration(seconds: 120), // Increased from 60 to 120 seconds
      sendTimeout: Duration(seconds: 120), // Increased from 60 to 120 seconds
    ));

    dio.interceptors.addAll({
      LogInterceptor(requestBody: true,responseBody: true)
    });
    return dio;
  }
}

