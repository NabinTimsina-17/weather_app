import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'models/current_weather_model.dart';
import 'services/http_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Weather App'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late HttpService httpServices;
  late Main requiredData;
  late List<Weather> weatherStatus;

  void getWeatherData() async{
    Response response = await httpServices.getRequest("/weather");


    CurrentWeatherModel weatherdata = CurrentWeatherModel.fromJson(response.data);

    requiredData = weatherdata.main!;
    weatherStatus = weatherdata.weather!;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    httpServices = HttpService();
    getWeatherData();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Text('Cancel'),
        actions: const [Text("Weather")],
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            color: Colors.white,
            width: double.infinity,
            child: Row(
              children: [
                Column(
                  children: [
                    const Text("December 22, 2023"),
                    Text(
                      "${requiredData.temp}°C",
                      style: const TextStyle(fontSize: 30),
                    ),
                    Text(weatherStatus.first.main!),
                    Text("It feels like ${requiredData.feelsLike}°C"),
                  ],
                ),
                const SizedBox(
                      width: 90,
                    ),
                SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.network(
                        'http://openweathermap.org/img/wn/${weatherStatus.first.icon}@4x.png',
                        scale: 0.5,
                      ),
            ),
            ],

            ),
          ),
        ],
      ),
    );
  }
}