import 'package:flutter/material.dart';
import 'package:weather_example/models/weather_forecast_daily.dart';

class CityView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  const CityView({required this.snapshot});
  @override
  Widget build(BuildContext context) {
    var city = snapshot.data!.city?.name;
    var coutry = snapshot.data!.city?.country;
    return Container(
      child: Column(
        children: [
          Text(
            '$city $coutry',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                color: Colors.black87),
          ),
          Text(
            'Tue, May 5, 2020',
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
