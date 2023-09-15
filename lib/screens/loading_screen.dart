import 'package:climat_flutter/model/temperature.dart';
import 'package:climat_flutter/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:climat_flutter/services/weather.dart';
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}



class LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }
  void getLocationData() async {
    WeatherModel weather =  WeatherModel();
   Temperature weatherData = await weather.getLocationWeather();

    if(context.mounted){
      Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return  LocationScreen(
              locationWeather: weatherData,
            );
          })
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWaveSpinner(
          color: Colors.green.shade300,
          trackColor: Colors.green.shade700,
          waveColor: Colors.green.shade200,
          size: 100.0,
          duration: const Duration(seconds: 4),
        ),
      ),
    );
  }
}
