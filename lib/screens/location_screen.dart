import 'package:climat_flutter/model/temperature.dart';
import 'package:climat_flutter/screens/city_screen.dart';
import 'package:climat_flutter/services/weather.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class LocationScreen extends StatefulWidget {
   const LocationScreen({super.key, required this.locationWeather});
  final Temperature   locationWeather;
  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  /*
    variables
   */
  WeatherModel weather = WeatherModel();

  int tempValue = 0;
  String cityName = '';
  late String weatherIcon = '';
  late String weatherMessage ;


  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }
  void updateUI(Temperature? weatherData){
   setState(() {
     if (weatherData == null){
       tempValue = 0;
       weatherIcon = 'Error';
       weatherMessage = 'Unable to get weather data';
       cityName = '';
       return;
     }
     tempValue =   weatherData.temp.toInt();
      int  condition = weatherData.id;
      weatherIcon =  weather.getWeatherIcon(condition);
      cityName = weatherData.name;
      weatherMessage = weather.getMessage(tempValue);
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          bottom: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      Temperature? weatherData = await   weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    style: kIconButtonStyle,
                    icon: const Icon(
                      Icons.near_me,
                    ),
                  ),
                  IconButton(
                    onPressed: ()  async{
                      var typedName = await Navigator.push(
                          context,
                        MaterialPageRoute(builder: (context) => const CityScreen(),)
                      );
                      if ( typedName != null ){
                        Temperature weatherData = await weather.getCityName(typedName);
                        print(weatherData);
                        updateUI(weatherData);
                      }
                    },
                    style: kIconButtonStyle,
                    icon: const Icon(
                      Icons.location_city,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$tempValueº',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage $cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
