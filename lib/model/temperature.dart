class Temperature{
  late double temp;
  late String main;
  late String name;
  late int id;

  Temperature( Map map){

    List weather =  map["weather"];
    Map weatherMap = weather.first;
    main = weatherMap ["main"];
    id= weatherMap ['id'];
    name = map['name'];
    Map mainMap = map ['main'];
    temp = mainMap['temp'];



  }
}