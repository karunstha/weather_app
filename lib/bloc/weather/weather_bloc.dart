import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/repository/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  Weather? weather;

  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      if (event is FetchWeather) {
        emit(WeatherLoading());
        weather = await weatherRepository.fetchWeather(event.cityName);
        if (weather != null) {
          emit(WeatherLoaded(weather: weather!));
        } else {
          emit(WeatherLoading());
        }
      }
    });
  }
}
