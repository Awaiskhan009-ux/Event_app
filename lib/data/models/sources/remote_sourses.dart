import 'package:dio/dio.dart';
import 'package:my_events_2025/core/constant/api_constants.dart';


class RemoteDataSource {
  final Dio _dio = Dio();

  RemoteDataSource() {
    
    _dio.options.baseUrl = ApiConstants.authBaseUrl; 
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    
    
    _dio.options.validateStatus = (status) {
      return status != null && (status >= 200 && status < 300 || status == 400 || status == 401 || status == 404);
    };
  }

  
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        ApiConstants.loginEndpoint,
        data: {
          'email': email,
          'password': password,
        },
      );
      
      if (response.data != null && response.data['token'] != null) {
    
        return {'token': response.data['token'], 'email': email};
      } else {
    
        throw Exception(response.data['error'] ?? 'Invalid email or password.');
      }
      
    } on DioException catch (e) {
       if (e.response != null && e.response!.data != null) {
           throw Exception(e.response!.data['error'] ?? 'Server authentication error.');
       }
       throw Exception('Network Error: Please check your internet connection.');
    } catch (e) {
      throw Exception('Login Failed: ${e.toString()}');
    }
  }

  // 2. Events Fetch Function (MockAPI.io)
  Future<List<dynamic>> getEvents() async {
    try {
  
      final fullUrl = '${ApiConstants.baseUrl}${ApiConstants.eventsEndpoint}';
      
      final response = await _dio.get(fullUrl);
      
      if (response.statusCode == 200 && response.data is List) {
        return response.data;
      }
      
  
      throw Exception('API Response Format Error or Status Code: ${response.statusCode}');

    } catch (e) {
      throw Exception('Failed to load events: ${e.toString()}');
    }
  }
}