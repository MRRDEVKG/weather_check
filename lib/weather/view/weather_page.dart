import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_check/search/search.dart';
import 'package:weather_check/weather/bloc/weather_bloc.dart';
import 'package:weather_check/weather/bloc/weather_state.dart';
import 'package:weather_check/weather/widgets/widgets.dart';
import 'package:weather_repository/weather_repository.dart';

import '../../theme/cubit/theme_cubit.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  static const routeName = 'weather_page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => WeatherBloc(WeatherRepository()),
        child: const WeatherView());
  }
}

class WeatherView extends StatefulWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //  centerTitle: true,
        title: Text(
          'WeatherCheck',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: <Color>[Colors.greenAccent, Colors.lightBlue],
              ).createShader(
                const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
              ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final city = await Navigator.of(context)
                  .pushNamed(SearchPage.routeName).then((value) => value) ?? '';
              if (!mounted) return;
              return context.read<WeatherBloc>().fetchWeather(city.toString());
            },
            icon: const Icon(
              Icons.search_outlined,
              semanticLabel: 'Search',
            ),
            color: Colors.blue,
          )
        ],
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: BlocConsumer<WeatherBloc, WeatherState>(listener: (context, state) {
        if (state.status.isSuccess) {
          context
              .read<ThemeCubit>()
              .updateTheme(state.weather.currentWeather.condition);
        }
      }, builder: (context, state) {
        switch (state.status) {
          case WeatherStatus.initial:
            return const WeatherEmpty();
          case WeatherStatus.loading:
            return const WeatherLoading();
          case WeatherStatus.failure:
            return const WeatherFailure();
          case WeatherStatus.success:
            return WeatherSuccess(
                weather: state.weather,
                onRefresh: () async {
                  return context.read<WeatherBloc>().add(WeatherRefreshEvent());
                });
        }
      }),
    );
  }
}
