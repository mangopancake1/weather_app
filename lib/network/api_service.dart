import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

class ApiService {
  final String apiKey = dotenv.env['API_KEY']!;
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.openweathermap.org/data/2.5',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));
}