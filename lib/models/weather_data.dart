class WeatherData {
  final Location location;
  final Current current;

  WeatherData({required this.location, required this.current});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
    );
  }

  @override
  String toString() {
    return '''
╔════════════════════════════════════════════════════════════════╗
║                        CLIMA ATUAL                             ║
╠════════════════════════════════════════════════════════════════╣
║ Local: ${location.name}, ${location.country}                   ║
║ Região: ${location.region}                                     ║     
║ Hora local: ${location.localtime}                              ║
║                                                                ║ 
║ Temperatura: ${current.tempC}°C (${current.tempF}°F)           ║ 
║ Sensação térmica: ${current.feelslikeC}°C                      ║  
║ Condição: ${current.condition.text}                            ║   
║                                                                ║ 
║ Umidade: ${current.humidity}%                                  ║               
║ Vento: ${current.windKph} km/h ${current.windDir}              ║  
║ Pressão: ${current.pressureMb} mb                              ║
║ Visibilidade: ${current.visKm} km                              ║     
║ Índice UV: ${current.uv}                                       ║              
╚════════════════════════════════════════════════════════════════╝
''';
  }
}

class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tzId;
  final int localtimeEpoch;
  final String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'] ?? '',
      region: json['region'] ?? '',
      country: json['country'] ?? '',
      lat: json['lat']?.toDouble() ?? 0.0,
      lon: json['lon']?.toDouble() ?? 0.0,
      tzId: json['tz_id'] ?? '',
      localtimeEpoch: json['localtime_epoch'] ?? 0,
      localtime: json['localtime'] ?? '',
    );
  }
}

class Current {
  final int lastUpdatedEpoch;
  final String lastUpdated;
  final double tempC;
  final double tempF;
  final int isDay;
  final Condition condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final double pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double feelslikeF;
  final double visKm;
  final double visMiles;
  final double uv;
  final double gustMph;
  final double gustKph;

  Current({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      lastUpdatedEpoch: json['last_updated_epoch'] ?? 0,
      lastUpdated: json['last_updated'] ?? '',
      tempC: json['temp_c']?.toDouble() ?? 0.0,
      tempF: json['temp_f']?.toDouble() ?? 0.0,
      isDay: json['is_day'] ?? 0,
      condition: Condition.fromJson(json['condition'] ?? {}),
      windMph: json['wind_mph']?.toDouble() ?? 0.0,
      windKph: json['wind_kph']?.toDouble() ?? 0.0,
      windDegree: json['wind_degree'] ?? 0,
      windDir: json['wind_dir'] ?? '',
      pressureMb: json['pressure_mb']?.toDouble() ?? 0.0,
      pressureIn: json['pressure_in']?.toDouble() ?? 0.0,
      precipMm: json['precip_mm']?.toDouble() ?? 0.0,
      precipIn: json['precip_in']?.toDouble() ?? 0.0,
      humidity: json['humidity'] ?? 0,
      cloud: json['cloud'] ?? 0,
      feelslikeC: json['feelslike_c']?.toDouble() ?? 0.0,
      feelslikeF: json['feelslike_f']?.toDouble() ?? 0.0,
      visKm: json['vis_km']?.toDouble() ?? 0.0,
      visMiles: json['vis_miles']?.toDouble() ?? 0.0,
      uv: json['uv']?.toDouble() ?? 0.0,
      gustMph: json['gust_mph']?.toDouble() ?? 0.0,
      gustKph: json['gust_kph']?.toDouble() ?? 0.0,
    );
  }
}

class Condition {
  final String text;
  final String icon;
  final int code;

  Condition({required this.text, required this.icon, required this.code});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'] ?? '',
      icon: json['icon'] ?? '',
      code: json['code'] ?? 0,
    );
  }
}

// Classes para previsão do tempo
class WeatherForecast {
  final Location location;
  final Current current;
  final Forecast forecast;

  WeatherForecast({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }

  @override
  String toString() {
    String result =
        '''
╔════════════════════════════════════════════════════════════════╗
║                    PREVISÃO DO TEMPO                           ║
║                    ${location.name}, ${location.country}       ║                       
╚════════════════════════════════════════════════════════════════╝

''';

    for (int i = 0; i < forecast.forecastday.length; i++) {
      final day = forecast.forecastday[i];
      result +=
          '''
┌──────────────────────────────────────────────────────────────────────────────┐
│ ${day.date} - ${day.day.condition.text}                                      │                                                                              
│ Temperatura: ${day.day.avgtempC}°C                                           │        
│ Máx: ${day.day.maxtempC}°C | Mín: ${day.day.mintempC}°C                      │   
│ Chuva: ${day.day.dailyChanceOfRain}% | Umidade: ${day.day.avghumidity}%      │
│ Vento: ${day.day.maxwindKph} km/h                                            │
└──────────────────────────────────────────────────────────────────────────────┘

''';
    }

    return result;
  }
}

class Forecast {
  final List<Forecastday> forecastday;

  Forecast({required this.forecastday});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    var list = json['forecastday'] as List;
    List<Forecastday> forecastList = list
        .map((i) => Forecastday.fromJson(i))
        .toList();
    return Forecast(forecastday: forecastList);
  }
}

class Forecastday {
  final String date;
  final int dateEpoch;
  final Day day;

  Forecastday({required this.date, required this.dateEpoch, required this.day});

  factory Forecastday.fromJson(Map<String, dynamic> json) {
    return Forecastday(
      date: json['date'],
      dateEpoch: json['date_epoch'],
      day: Day.fromJson(json['day']),
    );
  }
}

class Day {
  final double maxtempC;
  final double maxtempF;
  final double mintempC;
  final double mintempF;
  final double avgtempC;
  final double avgtempF;
  final double maxwindMph;
  final double maxwindKph;
  final double totalprecipMm;
  final double totalprecipIn;
  final double avgvisKm;
  final double avgvisMiles;
  final int avghumidity;
  final int dailyWillItRain;
  final int dailyChanceOfRain;
  final int dailyWillItSnow;
  final int dailyChanceOfSnow;
  final Condition condition;
  final double uv;

  Day({
    required this.maxtempC,
    required this.maxtempF,
    required this.mintempC,
    required this.mintempF,
    required this.avgtempC,
    required this.avgtempF,
    required this.maxwindMph,
    required this.maxwindKph,
    required this.totalprecipMm,
    required this.totalprecipIn,
    required this.avgvisKm,
    required this.avgvisMiles,
    required this.avghumidity,
    required this.dailyWillItRain,
    required this.dailyChanceOfRain,
    required this.dailyWillItSnow,
    required this.dailyChanceOfSnow,
    required this.condition,
    required this.uv,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxtempC: json['maxtemp_c']?.toDouble() ?? 0.0,
      maxtempF: json['maxtemp_f']?.toDouble() ?? 0.0,
      mintempC: json['mintemp_c']?.toDouble() ?? 0.0,
      mintempF: json['mintemp_f']?.toDouble() ?? 0.0,
      avgtempC: json['avgtemp_c']?.toDouble() ?? 0.0,
      avgtempF: json['avgtemp_f']?.toDouble() ?? 0.0,
      maxwindMph: json['maxwind_mph']?.toDouble() ?? 0.0,
      maxwindKph: json['maxwind_kph']?.toDouble() ?? 0.0,
      totalprecipMm: json['totalprecip_mm']?.toDouble() ?? 0.0,
      totalprecipIn: json['totalprecip_in']?.toDouble() ?? 0.0,
      avgvisKm: json['avgvis_km']?.toDouble() ?? 0.0,
      avgvisMiles: json['avgvis_miles']?.toDouble() ?? 0.0,
      avghumidity: json['avghumidity'] ?? 0,
      dailyWillItRain: json['daily_will_it_rain'] ?? 0,
      dailyChanceOfRain: json['daily_chance_of_rain'] ?? 0,
      dailyWillItSnow: json['daily_will_it_snow'] ?? 0,
      dailyChanceOfSnow: json['daily_chance_of_snow'] ?? 0,
      condition: Condition.fromJson(json['condition'] ?? {}),
      uv: json['uv']?.toDouble() ?? 0.0,
    );
  }
}
