import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';

const apiKey = "8dde491279dbef8b8221b7ebbe9776ee";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getCurrentLocationData();
  }

  void getCurrentLocationData() async {
    Location location = Location();
    await location.getCurrentPosition();
    latitude = location.latitude;
    longitude = location.longitude;

    var url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey";

    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getDate();

    //double temperature = weatherData['main']['temp']; // path - main.temp
    //int condition = weatherData['weather'][0]['id']; // path - weather[0].id
    //String country = weatherData['name']; // path - name
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //Get the current location
            setState(() {
              getCurrentLocationData();
            });
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
