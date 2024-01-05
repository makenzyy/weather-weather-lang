import 'package:http/http.dart';
import 'package:test_clima_flutter/services/location.dart';

class Networking{
  String appID = "62cfac07befbf3a5ee9296067b94681a";
  String data = '';

  Future<String> getLoc() async {
    Location location = new Location();
    await location.getLocation();

    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.lon}&appid=$appID&units=metric");
    Response response = await get(url);
    data = response.body;

    if (response.statusCode == 200){
      return data;
    }else{
      return "Error";
    }
  }

  Future<String> getCity(String nc) async {
    Location location = new Location();
    await location.getLocation();

    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$nc&appid=$appID&units=metric");
    Response response = await get(url);
    data = response.body;

    if (response.statusCode == 200){
      return data;
    }else{
      return "No city";
    }
  }
}