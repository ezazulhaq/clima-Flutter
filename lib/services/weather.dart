import 'networking.dart';
import 'location.dart';

const apiKey = "8dde491279dbef8b8221b7ebbe9776ee";
const openWeatherURL = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  Future<dynamic> getCityLocation(dynamic cityName) async {
    print(cityName);
    var url = '$openWeatherURL?q=$cityName&appid=$apiKey&units=metric';
    print(url);
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getDate();
    print(weatherData);
    return weatherData;
  }

  Future<dynamic> getCurrentLocation() async {
    Location location = Location();
    await location.getCurrentPosition();

    var url =
        "$openWeatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric";
    print(url);
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getDate();
    print(weatherData);
    return weatherData;
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

  String getMessage(dynamic temp) {
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
