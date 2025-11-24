import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String get domain => dotenv.env['API_URL'] ?? "";
  static String baseUrl = "$domain/api/";
}