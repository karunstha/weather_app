import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:weatherapp/bloc/weather/weather_bloc.dart';
import 'package:weatherapp/repository/weather.dart';
import 'package:weatherapp/routes.dart';

import 'services/appstate.dart';

final serviceLocator = GetIt.instance;

void main() async {
  await dotenv.load(fileName: ".env");
  await setUp();
  runApp(const MyApp());
}

Future setUp() async {
  serviceLocator.registerSingleton<AppState>(AppState());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(),
      child: BlocProvider(
        create: (context) =>
            WeatherBloc(RepositoryProvider.of<WeatherRepository>(context)),
        child: MaterialApp(
          title: 'Weather App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          onGenerateRoute: Routes.generateRoute,
        ),
      ),
    );
  }
}
