import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationData});

  final locationData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var temperature;
  int condition;
  String country;
  String weatherIcon;
  String message;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationData);
  }

  WeatherModel weatherModel = WeatherModel();

  void updateUI(dynamic weatherData) {
    setState(() {
//      if (weatherData == null) {
//        temperature = '0';
//        condition = 0;
//        weatherIcon = weatherModel.getWeatherIcon(condition);
//        country = "NULL";
//        message = 'Unable to get Data';
//        return;
//      }
      dynamic temp = weatherData['main']['temp']; // path - main.temp
      temperature = temp.toStringAsFixed(1);
      condition = weatherData['weather'][0]['id']; // path - weather[0].id
      weatherIcon = weatherModel.getWeatherIcon(condition);
      country = weatherData['name']; // path - name
      message = weatherModel.getMessage(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getCurrentLocation();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typeName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                      print(typeName);
                      if (typeName != null) {
                        var weatherData =
                            await weatherModel.getCityLocation(typeName);
                        updateUI(weatherData);
                      } else {
                        updateUI(weatherModel.getCurrentLocation());
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '$weatherIcon',
                        style: kConditionTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $country',
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
