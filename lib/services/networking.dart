import 'dart:convert';

import 'package:climat_flutter/model/temperature.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future<Temperature?> getData() async {
     await Geolocator.requestPermission();
     var uri = Uri.tryParse(url);
    Response response = await get(uri!);
    if (response.statusCode == 200) {
      String data = response.body;
      Map<String, dynamic> map = jsonDecode(data);
      Temperature temperature = Temperature(map);
      print(temperature.temp.toInt());
      print(temperature.name);
      return temperature;
    } else if (response.statusCode == 400) {
      Future.error("Bad request ${response.statusCode}");
    } else if (response.statusCode == 500) {
      Future.error("Error Server ${response.statusCode}");
    } else {
      Future.error("Error ${response.statusCode}");
    }
    return null;
  }
}
