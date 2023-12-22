
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'models/weather_model.dart';
import 'services/http_services.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true
      ),
      home:const MyHomePage(title: 'Weather App'),
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

   void getWeatherData() async {
    Response response =  await httpServices.getRequest();
    WeatherModel weatherdata = WeatherModel.fromJson(response.data);

    requiredData = weatherdata.main!;

    setState(() {});
   }
   
     @override
     Widget build(BuildContext context) {
    
    throw UnimplementedError();
     }
   }

   @override
   void initState() {
  
     
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Text('Cancel'),
        actions: const [Text("")],
      ),
      body: Column(children: [
        Container(
          height: 200,
          color: Colors.white,
          width: double.infinity,
          child: const Row(
            children: [
              Column(
                children: [
                  Text("december 22, 2023"),
                  Text(
                    "",
                    style:TextStyle(fontSize: 20),
                  ),
                  Text("clear"),
                  Text("It feels like 18°C")
                ],
              )
            ],
          ),
        )
      ],),
    );
  }
