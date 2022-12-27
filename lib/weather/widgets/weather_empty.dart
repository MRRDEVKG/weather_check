import 'package:flutter/material.dart';

class WeatherEmpty extends StatelessWidget {
  const WeatherEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('🏙️', style: TextStyle(fontSize: 64)),
          Text(
            'Please Select a City!',
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
