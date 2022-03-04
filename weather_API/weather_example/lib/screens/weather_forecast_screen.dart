import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_example/api/weather_api.dart';
import 'package:weather_example/models/weather_forecast_daily.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({Key? key}) : super(key: key);

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecastObject;
  final String _cityName = 'London';

  @override
  void initState() {
    super.initState();

    forecastObject =
        WeatherApi().fetchWeatherForecastWithCity(cityName: _cityName);

    forecastObject.then((weather) {
      print(weather.list![0].weather![0].main);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('openweathermap.org'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.my_location),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.location_city))
        ],
      ),
      body: ListView(
        children: [
          Container(
            child: FutureBuilder<WeatherForecast>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('All Good',
                      style: Theme.of(context).textTheme.headline2);
                } else {
                  return Center(
                      child: SpinKitDoubleBounce(
                    color: Colors.black,
                    size: 100,
                    duration: Duration(seconds: 5),
                  ));
                }
              },
              future: forecastObject,
            ),
          )
        ],
      ),
    );
  }
}
