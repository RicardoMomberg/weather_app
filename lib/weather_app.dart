import 'dart:io';
import 'services/weather_service.dart';
import 'models/weather_data.dart';

class WeatherApp {
  final WeatherService _weatherService = WeatherService();

  /// Inicia o aplicativo
  Future<void> run() async {
    _showWelcomeMessage();

    while (true) {
      try {
        await _showMainMenu();
      } catch (e) {
        print('\n❌ Erro inesperado: $e\n');
      }
    }
  }

  void _showWelcomeMessage() {
    print('''
╔════════════════════════════════════════════════════════════════╗
║                    🌤️  CONSULTA DO TEMPO  🌤️                   ║
║                                                                ║
║     Bem-vindo ao aplicativo de consulta de previsão do tempo   ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝
''');
  }

  Future<void> _showMainMenu() async {
    print('''
┌────────────────────────────────────────┐
│            MENU PRINCIPAL              │
├────────────────────────────────────────┤
│ 1 - Consultar clima atual              │
│ 2 - Consultar previsão (3 dias)        │
│ 3 - Sair                               │
└────────────────────────────────────────┘
''');

    stdout.write('Escolha uma opção (1-3): ');
    final choice = stdin.readLineSync()?.trim();

    switch (choice) {
      case '1':
        await _getCurrentWeather();
        break;
      case '2':
        await _getForecast();
        break;
      case '3':
        _showGoodbyeMessage();
        exit(0);
      default:
        print('\n❌ Opção inválida! Tente novamente.\n');
    }
  }

  Future<void> _getCurrentWeather() async {
    final city = _getCityInput();
    if (city == null) return;

    print('\n🔄 Buscando informações do clima atual para "$city"...\n');

    try {
      final weatherData = await _weatherService.getCurrentWeather(city);
      print(weatherData.toString());
    } on WeatherException catch (e) {
      print('\n❌ ${e.message}\n');
    } catch (e) {
      print('\n❌ Erro inesperado: $e\n');
    }

    _waitForUserInput();
  }

  Future<void> _getForecast() async {
    final city = _getCityInput();
    if (city == null) return;

    print('\n🔄 Buscando previsão do tempo para "$city"...\n');

    try {
      final forecast = await _weatherService.getForecast(city, days: 3);
      print(forecast.toString());
    } on WeatherException catch (e) {
      print('\n❌ ${e.message}\n');
    } catch (e) {
      print('\n❌ Erro inesperado: $e\n');
    }

    _waitForUserInput();
  }

  String? _getCityInput() {
    stdout.write('\n🌍 Digite o nome da cidade (ou "voltar" para retornar): ');
    final input = stdin.readLineSync()?.trim();

    if (input == null || input.isEmpty) {
      print('\n❌ Nome da cidade não pode estar vazio!\n');
      return null;
    }

    if (input.toLowerCase() == 'voltar') {
      print('\n↩️ Voltando ao menu principal...\n');
      return null;
    }

    return input;
  }

  void _waitForUserInput() {
    print('\n📱 Pressione Enter para continuar...');
    stdin.readLineSync();
    print('\n');
  }

  void _showGoodbyeMessage() {
    print('''
╔════════════════════════════════════════════════════════════════╗
║                     👋 OBRIGADO POR USAR!                      ║
║                                                                ║
║            Espero que tenha gostado do aplicativo!             ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝

🌤️ Até logo!
''');
  }
}
