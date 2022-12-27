import 'package:flutter/material.dart';

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('⛅', style: TextStyle(fontSize: 64)),
          Text(
            'Loading Weather',
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontStyle: FontStyle.italic),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}