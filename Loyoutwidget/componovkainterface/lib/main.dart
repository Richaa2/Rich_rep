import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Weather',
            style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
          iconTheme: IconThemeData(color: Colors.black54),
          brightness: Brightness.light,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings),
            ),
          ],
        ),
        body: _buildBody(),
      ),
    );
  }
}

Widget _buildBody() {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        _headerImage(),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _weatherDescription(),
                Divider(),
                _temperature(),
                Divider(),
                _tempetureForecast(),
                Divider(),
                _footersRatings(),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Image _headerImage() {
  return Image(
    width: 500,
    alignment: Alignment.center,
    image: NetworkImage(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqhImnN1KCxe8k8DDt0pCl01uqmq6yZDPm3w&usqp=CAU'),
    fit: BoxFit.cover,
  );
}

Column _weatherDescription() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text(
        'Tuesday - May 22',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      Divider(),
      Text(
        'це довгий опис погоди яка може бути 22 травня у вівторок не понятно якого року',
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      )
    ],
  );
}

Row _temperature() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        children: <Widget>[
          Icon(
            Icons.wb_sunny,
            color: Colors.orange,
          )
        ],
      ),
      SizedBox(width: 16),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '15*C Clear',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(
            top: 5,
          )),
          Row(
            children: [
              Text(
                'Lviv,lvivska oblast,Ukraine',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ],
      ),
    ],
  );
}

Wrap _tempetureForecast() {
  return Wrap(
    spacing: 10.0,
    children: List.generate(
      8,
      (int index) {
        return Chip(
          label: Text(
            '${index + 20}°С',
            style: TextStyle(fontSize: 15.0),
          ),
          avatar: Icon(
            Icons.wb_cloudy,
            color: Colors.blue.shade300,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          side: BorderSide(color: Colors.grey),
          backgroundColor: Colors.grey[100],
        );
      },
    ),
  );
}

Row _footersRatings() {
  var stars = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.star,
        color: Colors.yellow,
        size: 15,
      ),
      Icon(
        Icons.star,
        color: Colors.yellow,
        size: 15,
      ),
      Icon(
        Icons.star,
        color: Colors.yellow,
        size: 15,
      ),
      Icon(
        Icons.star,
        color: Colors.black,
        size: 15,
      ),
      Icon(
        Icons.star,
        color: Colors.black,
        size: 15,
      ),
    ],
  );

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(
        'info with weather.com',
        style: TextStyle(fontSize: 15),
      ),
      stars,
    ],
  );
}
