import 'package:flutter/material.dart';
import 'package:test_clima_flutter/utilities/constants.dart';
import 'dart:convert';
import 'package:test_clima_flutter/services/weather.dart';
import 'package:test_clima_flutter/screens/city_screen.dart';
import 'package:test_clima_flutter/services/networking.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.data, {super.key});
  final String data;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double temp = 0;
  String city = '', info = '', weathericon = '', weathermessage = '';
  int id = 0;

  @override
  void initState() {
    super.initState();
    info = widget.data;
    updateUI();
  }

  void updateUI(){
    //print(info);
    temp = jsonDecode(info)['main']['temp'];
    city = jsonDecode(info)['name'];
    id = jsonDecode(info)['weather'][0]['id'];
    print(city);
    print(temp);
    print(id);

    WeatherModel weatherModel = new WeatherModel();
    weathericon = weatherModel.getWeatherIcon(id);
    weathermessage = weatherModel.getMessage(temp.toInt());
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      String newData = await Networking().getLoc();
                      setState(() {
                        info = newData;
                        updateUI();
                      });
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      navigateToCityScreen();
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temp.toStringAsFixed(0) + '°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathericon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weathermessage in $city!",
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
  void navigateToCityScreen() async {
    String newCity = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return CityScreen();
      }),
    );

    if (newCity != null) {
      String newData = await Networking().getCity(newCity);
      setState(() {
        info = newData;
        updateUI();
      });
    }
  }
}


