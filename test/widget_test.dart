import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_check/search/search.dart';
import 'package:weather_check/theme/cubit/theme_cubit.dart';
import 'package:weather_check/weather/bloc/weather_bloc.dart';
import 'package:weather_check/weather/bloc/weather_state.dart';
import 'package:weather_check/weather/view/weather_page.dart';
import 'package:weather_check/weather/widgets/widgets.dart';
import 'package:weather_check/weather_check_app.dart';
import 'package:weather_repository/weather_repository.dart';

import 'helpers/hydrated_bloc.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockThemeCubit extends MockCubit<Color> implements ThemeCubit {}

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  initHydratedStorage();
  group('Weather Page', () {
    late WeatherRepository weatherRepository;

    setUp(() => weatherRepository = MockWeatherRepository());

    testWidgets('renders WeatherView', (widgetTester) async {
      await widgetTester
          .pumpWidget(WeatherCheckApp(weatherRepository: weatherRepository));

      expect(find.byType(WeatherView), findsOneWidget);
      expect(find.byType(WeatherPage), findsOneWidget);
      expect(find.byType(WeatherEmpty), findsOneWidget);
      expect(find.byType(WeatherFailure), findsNothing);
    });

    group('WeatherView', () {
      late MockWeatherBloc weatherBloc;

      setUp(() => weatherBloc = MockWeatherBloc());

      testWidgets('renders WeatherEmpty', (widgetTester) async {
        when(() => weatherBloc.state).thenReturn(const WeatherState());

        await widgetTester.pumpWidget(MaterialApp(
            home: BlocProvider<WeatherBloc>(
          create: (context) => weatherBloc,
          child: const WeatherView(),
        )));

        expect(find.byType(WeatherEmpty), findsOneWidget);
      });

      testWidgets('renders WeatherSuccess', (widgetTester) async {
        when(() => weatherBloc.state)
            .thenReturn(const WeatherState(status: WeatherStatus.success));

        await widgetTester.pumpWidget(MaterialApp(
          home: BlocProvider<WeatherBloc>.value(
            value: weatherBloc,
            child: WeatherView(),
          ),
        ));

        expect(find.byType(WeatherSuccess), findsOneWidget);
      });

      testWidgets('renders WeatherFailure', (widgetTester) async {
        when(() => weatherBloc.state)
            .thenReturn(const WeatherState(status: WeatherStatus.failure));

        await widgetTester.pumpWidget(MaterialApp(
            home: BlocProvider<WeatherBloc>(
          create: (context) => weatherBloc,
          child: const WeatherView(),
        )));

        expect(find.byType(WeatherFailure), findsOneWidget);
      });

      testWidgets('renders WeatherLoading', (widgetTester) async {
        when(() => weatherBloc.state)
            .thenReturn(const WeatherState(status: WeatherStatus.loading));

        await widgetTester.pumpWidget(BlocProvider<WeatherBloc>.value(
          value: weatherBloc,
          child: const MaterialApp(
            home: WeatherView(),
          ),
        ));

        expect(find.byType(WeatherLoading), findsOneWidget);
      });

      testWidgets('navigates to SearchPage when search icon is tapped', (widgetTester) async{
        await widgetTester.pumpWidget(WeatherCheckApp(weatherRepository: weatherRepository));
        await widgetTester.tap(find.byType(IconButton));
        await widgetTester.pumpAndSettle();

        expect(find.byType(SearchPage), findsOneWidget);
      });
    });
    

  });
}
