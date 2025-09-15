import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_data.dart';
import '../config/api_config.dart';

class WeatherService {
  // API Key agora vem do arquivo de configuração
  static const String _apiKey = ApiConfig.weatherApiKey;
  static const String _baseUrl = ApiConfig.weatherApiBaseUrl;

  /// Busca os dados do tempo atual para uma cidade específica
  Future<WeatherData> getCurrentWeather(String city) async {
    try {
      final url = Uri.parse('$_baseUrl/current.json?key=$_apiKey&q=$city&lang=pt');
      
      print('Fazendo requisição para: ${url.toString()}');
      
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return WeatherData.fromJson(jsonData);
      } else {
        throw WeatherException(_handleErrorCode(response.statusCode));
      }
    } catch (e) {
      if (e is WeatherException) {
        rethrow;
      }
      throw WeatherException('Erro na conexão: $e');
    }
  }

  /// Busca a previsão do tempo para os próximos dias
  Future<WeatherForecast> getForecast(String city, {int days = 3}) async {
    try {
      final url = Uri.parse('$_baseUrl/forecast.json?key=$_apiKey&q=$city&days=$days&lang=pt');
      
      print('Fazendo requisição para previsão: ${url.toString()}');
      
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return WeatherForecast.fromJson(jsonData);
      } else {
        throw WeatherException(_handleErrorCode(response.statusCode));
      }
    } catch (e) {
      if (e is WeatherException) {
        rethrow;
      }
      throw WeatherException('Erro na conexão: $e');
    }
  }

  String _handleErrorCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Cidade não encontrada ou parâmetros inválidos';
      case 401:
        return 'Chave de API inválida';
      case 403:
        return 'API key desativada ou limite excedido';
      case 404:
        return 'Cidade não encontrada';
      default:
        return 'Erro no servidor (código: $statusCode)';
    }
  }
}

class WeatherException implements Exception {
  final String message;
  WeatherException(this.message);

  @override
  String toString() => 'WeatherException: $message';
}