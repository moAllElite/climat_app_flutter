import 'package:climat_flutter/services/location.dart';
import 'package:climat_flutter/services/networking.dart';

import '../model/temperature.dart';
/*  variables
 */
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const apiKey = 'c1f88475d5f10a9f6d0a83ba038472ca';
const units = 'metric';
late double latitude;
late Temperature temperature;
late double longitude;


class WeatherModel {
  Future<Temperature> getCityName(String cityName) async{

    String url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=$units';
    NetworkHelper networkHelper = NetworkHelper(url);
    Temperature? weatherData =  await   networkHelper.getData();
    return weatherData!;
  }

  Future<Temperature> getLocationWeather() async{
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    String url = '$openWeatherMapURL?lat=$latitude&lon=$longitude&appid=$apiKey&units=$units';

    NetworkHelper networkHelper = NetworkHelper(url);
    Temperature? weatherData = await networkHelper.getData() ;
    return  weatherData!;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}