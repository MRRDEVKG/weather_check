import 'package:flutter/material.dart';

class WeatherFailure extends StatelessWidget {
  const WeatherFailure({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('🙈', style: TextStyle(fontSize: 64)),
          Text(
            'Something went wrong!',
            style: TextStyle(
              color: Colors.grey, fontSize: 20, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}