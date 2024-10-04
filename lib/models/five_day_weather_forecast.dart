import 'package:weather_app/models/current_weather_model.dart';

class FiveDayForecastModel {
  List<WeatherList>? weatherList;

  FiveDayForecastModel({this.weatherList});

  factory FiveDayForecastModel.fromJson(Map<String, dynamic> json) {
    return FiveDayForecastModel(
      weatherList: (json['list'] as List?)?.map((v) => WeatherList.fromJson(v)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (weatherList != null)
        'list': weatherList!.map((v) => v.toJson()).toList(),
    };
  }
}

class WeatherList {
  Main? main;
  List<Weather>? weather;
  String? dtTxt;

  WeatherList({this.main, this.weather, this.dtTxt});

  factory WeatherList.fromJson(Map<String, dynamic> json) {
    return WeatherList(
      main: json['main'] != null ? Main.fromJson(json['main']) : null,
      weather: (json['weather'] as List?)?.map((v) => Weather.fromJson(v)).toList(),
      dtTxt: json['dt_txt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (main != null)
        'main': main!.toJson(),
      if (weather != null)
        'weather': weather!.map((v) => v.toJson()).toList(),
      'dt_txt': dtTxt,
    };
  }
}
