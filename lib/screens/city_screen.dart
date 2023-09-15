import 'package:flutter/material.dart';
import 'package:climat_flutter/utils/constants.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  CityScreenState createState() => CityScreenState();
}

class CityScreenState extends State<CityScreen> {
  /*
    variables
   */
  late String cityName ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  style: kIconButtonStyle,
                  onPressed: () =>  Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),

              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration:  const BoxDecoration(
            
                ),
                child: TextField(
                  style: const TextStyle(
                    color: Colors.black
                  ),
                 decoration:  kTextFieldInputDecoration,
                  autocorrect: true,
                  onChanged: (value) {
                    setState(() {
                      cityName = value;
                    });
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(
                      context,
                    cityName
                  );
                },

                child:  TextButton(
                  child: const Text(
                    'Get Weather',
                    style: kButtonTextStyle
                  ),
                  onPressed: () {
                    Navigator.pop(context,cityName);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}