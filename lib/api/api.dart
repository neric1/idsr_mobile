
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:idsr/data/constants.dart';


class Api {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: Constants.baseUrl));
  final String baseUrl = Constants.baseUrl;
  String? token;

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    final basicAuth = 'Basic ${base64Encode(utf8.encode('${dotenv.env['USERNAME'] ?? ""}:${dotenv.env['PASSWORD'] ?? ""}'))}';

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

