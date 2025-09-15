import 'package:weather_app/weather_app.dart';

/// Ponto de entrada principal do aplicativo
void main() async {
  final app = WeatherApp();
  await app.run();
}