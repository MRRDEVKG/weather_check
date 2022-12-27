import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_check/search/search.dart';
import 'package:weather_check/theme/cubit/theme_cubit.dart';
import 'package:weather_check/weather/view/weather_page.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherCheckApp extends StatelessWidget {
  const WeatherCheckApp(
      {super.key, required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository;

  final WeatherRepository _weatherRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _weatherRepository,
      child: BlocProvider(
        create: (context) => ThemeCubit(),
        child: const WeatherCheckAppView(),
      ),
    );
  }
}

class WeatherCheckAppView extends StatelessWidget {
  const WeatherCheckAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, Color>(builder: (context, state) {
      return MaterialApp(
        title: 'Weather Check',
        theme: ThemeData(primaryColor: state),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const WeatherPage(),
          WeatherPage.routeName: (context) => const WeatherPage(),
          SearchPage.routeName: (context) => const SearchPage()
        },
      );
    });
  }
}
