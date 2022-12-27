import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_check/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import '../../helpers/hydrated_bloc.dart';

void main() {
  initHydratedStorage();

  group('ThemeCubit', () {
    test('initial state is correct',
        () => expect(ThemeCubit().state, ThemeCubit.defaultColor));

    group('toJson/fromJson', () {
      final themeCubit = ThemeCubit();
      test(
          'work properly',
          () => expect(themeCubit.fromJson(themeCubit.toJson(themeCubit.state)),
              themeCubit.state));
    });

    group('updateTheme', () {
      blocTest('emits correct color for Clear weather condition',
          build: () => ThemeCubit(),
          act: (bloc) => bloc.updateTheme('Clear'),
          expect: () => <Color>[Colors.orangeAccent]);

      blocTest('emits correct color for Rainy weather condition',
          build: () => ThemeCubit(),
          act: (bloc) => bloc.updateTheme('Rainy'),
          expect: () => <Color>[Colors.indigoAccent]);
    });
  });
}
