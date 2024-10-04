import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  Main? requiredData;
  List<Weather>? weatherStatus;
  bool isLoading = true;
  String? errorMessage;

  void getWeatherData() async {
    try {
      Response response = await httpServices.getRequest("/weather?q=Biratnagar&appid=39857143a14a6e99b22ede2ca6b07b13");

      if (response.statusCode == 200) {
        CurrentWeatherModel weatherData = CurrentWeatherModel.fromJson(response.data);
        setState(() {
          requiredData = weatherData.main;
          weatherStatus = weatherData.weather;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "Error: ${response.statusCode}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Failed to fetch weather data: $e";
        isLoading = false;
      });
    }
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
        title: const Text("Weather App"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : requiredData == null || weatherStatus == null
                  ? const Center(child: Text("No data available"))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            color: Colors.white,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        DateFormat('MMMM d, yyyy').format(DateTime.now()),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        "${requiredData!.temp}°C",
                                        style: const TextStyle(fontSize: 30),
                                      ),
                                      Text(weatherStatus!.first.main ?? 'N/A'),
                                      Text("Feels like ${requiredData!.feelsLike}°C"),
                                    ],
                                  ),
                                ),
                                if (weatherStatus != null && weatherStatus!.isNotEmpty)
                                  Image.network(
                                    'http://openweathermap.org/img/wn/${weatherStatus!.first.icon}@4x.png',
                                    width: 100,  // Set a width to control the image size
                                    height: 100, // Set a height to control the image size
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }
}
