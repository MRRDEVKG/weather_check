import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather_check/weather/models/models.dart';

class WeatherSuccess extends StatelessWidget {
  const WeatherSuccess({
    super.key,
    required this.weather,
    required this.onRefresh,
  });

  final Weather weather;
  final ValueGetter<Future<void>> onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          height: 1000,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 8.0),
                child: SizedBox(
                  height: 220,
                  child: Stack(children: [
                    Positioned(
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 180,
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              stops: [0, 0.8],
                              colors: [Colors.greenAccent, Colors.lightBlue]),
                          boxShadow: const [
                            BoxShadow(color: Colors.grey, blurRadius: 30)
                          ],
                          borderRadius: BorderRadius.circular(40),
                          // color: Colors.indigoAccent,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${weather.currentWeather.temperature}°',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 50),
                                ),
                                /*  const Icon(
                                  Icons.circle_outlined,
                                  color: Colors.white,
                                  size: 15,
                                )*/
                              ],
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        weather.currentWeather.condition,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      Text(
                                        '${weather.location.name} | ${weather.currentWeather.date}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.wind_power_outlined,
                                    color: Colors.lightBlueAccent,
                                    size: 40,
                                  )
                                ]),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SizedBox(
                        height: 140,
                        width: 140,
                        child: CachedNetworkImage(
                          imageUrl:
                              'https:${weather.currentWeather.conditionImage}',
                          fit: BoxFit.fill,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) {
                            return CircularProgressIndicator(
                              value: downloadProgress.progress,
                            );
                          },
                          errorWidget: (context, url, error) => const Icon(
                            Icons.image_outlined,
                            color: Colors.redAccent,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ]),
                  // color: Colors.orangeAccent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: const [
                      BoxShadow(color: Colors.grey, blurRadius: 30)
                    ],
                  ),
                  height: 250,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'TODAY',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Container()),
                          IconButton(
                              onPressed: onRefresh,
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.grey,
                                size: 20,
                              ))
                        ],
                      ),
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blue.shade50, blurRadius: 30)
                          ],
                        ),
                        child: Table(
                          children: [
                            TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.wind_power_outlined,
                                          color: Colors.blueAccent,
                                          size: 20,
                                        ),
                                        const Text(
                                          'HAZE',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${weather.currentWeather.wind}km/h',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.water_drop_outlined,
                                          color: Colors.blueAccent,
                                          size: 20,
                                        ),
                                        const Text(
                                          'DROP',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${weather.currentWeather.humidity}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.cloud_outlined,
                                          color: Colors.blueAccent,
                                          size: 20,
                                        ),
                                        const Text(
                                          'CLOUD',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${weather.currentWeather.cloud}%',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.sunny,
                                        color: Colors.blueAccent,
                                        size: 20,
                                      ),
                                      const Text(
                                        'SUNRISE',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        weather.currentWeather.sunrise,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.device_thermostat_outlined,
                                        color: Colors.blueAccent,
                                        size: 20,
                                      ),
                                      const Text(
                                        'TEMP',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        '${weather.currentWeather.temperature}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.mode_night_outlined,
                                        color: Colors.blueAccent,
                                        size: 20,
                                      ),
                                      const Text(
                                        'SUNSET',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        weather.currentWeather.sunset,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                child: CustomScrollView(
                  scrollDirection: Axis.horizontal,
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  width: 50,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: [
                                            0,
                                            0.8
                                          ],
                                          colors: [
                                            Colors.greenAccent,
                                            Colors.lightBlue
                                          ]),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        [
                                          'UNK',
                                          'MON',
                                          'TUE',
                                          'WED',
                                          'THU',
                                          'FRI',
                                          'SAT',
                                          'SUN'
                                        ][DateTime.parse(weather
                                                .forecastWeatherList[index]
                                                .date)
                                            .weekday],
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '${DateTime.parse(weather.forecastWeatherList[index].date).month}/${DateTime.parse(weather.forecastWeatherList[index].date).day}',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https:${weather.forecastWeatherList[index].conditionImage}',
                                          fit: BoxFit.fill,
                                          progressIndicatorBuilder:
                                              (context, url, downloadProgress) {
                                            return CircularProgressIndicator(
                                              value: downloadProgress.progress,
                                            );
                                          },
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.image_outlined,
                                            color: Colors.redAccent,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${weather.forecastWeatherList[index].temperature}',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          childCount: weather.forecastWeatherList.length),
                    )
                  ],
                ),
              ),
              SfRadialGauge(axes: <RadialAxis>[
                RadialAxis(
                    minimum: 0,
                    maximum: 500,
                    labelOffset: 30,
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: 0,
                        endValue: 50,
                        startWidth: 30,
                        endWidth: 30,
                        color: Colors.greenAccent,
                        label: 'Good',
                      ),
                      GaugeRange(
                        startValue: 51,
                        endValue: 100,
                        startWidth: 30,
                        endWidth: 30,
                        color: Colors.yellowAccent,
                        label: 'Moderate',
                      ),
                      GaugeRange(
                        startValue: 101,
                        endValue: 150,
                        startWidth: 30,
                        endWidth: 30,
                        color: Colors.orangeAccent,
                        label: '''USG''',
                      ),
                      GaugeRange(
                        startValue: 151,
                        endValue: 200,
                        startWidth: 30,
                        endWidth: 30,
                        color: Colors.redAccent,
                        label: 'Unhealthy',
                      ),
                      GaugeRange(
                        startValue: 201,
                        endValue: 300,
                        startWidth: 30,
                        endWidth: 30,
                        color: Colors.purpleAccent,
                        label: 'Very Unhealthy',
                      ),
                      GaugeRange(
                        startValue: 301,
                        endValue: 500,
                        startWidth: 30,
                        endWidth: 30,
                        color: Colors.pinkAccent,
                        label: 'Hazardous',
                        labelStyle: const GaugeTextStyle(color: Colors.white),
                      )
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                          value: [
                        0,
                        25,
                        75,
                        125,
                        175,
                        250,
                        400
                      ][weather.currentWeather.aqi]
                              .toDouble())
                    ],
                    annotations: const <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Text('AQI',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          angle: 90,
                          positionFactor: 0.5)
                    ])
              ])
            ],
          ),
        ),
      ),
    );
  }
}
