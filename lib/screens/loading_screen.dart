import 'package:flutter/material.dart';
import 'package:test_clima_flutter/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_clima_flutter/screens/location_screen.dart';

  class LoadingScreen extends StatefulWidget {
    const LoadingScreen({super.key});

    @override
    State<LoadingScreen> createState() => _LoadingScreenState();
  }

  class _LoadingScreenState extends State<LoadingScreen> {

    @override
  void initState() {
    super.initState();
    getWeatherData();
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: SpinKitFadingFour(
              size : 100.0,
              color: Colors.indigo
            ),
          ),
        );
    }

    void getWeatherData() async{
      Networking networking = new Networking();
      String data = await networking.getLoc();

      Navigator.push(context, MaterialPageRoute(builder: (context){
        return LocationScreen(data);
      }));
    }
  }
