import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/bloc/weather/weather_bloc.dart';
import 'package:weatherapp/models/weatherinfo.dart';
import 'package:weatherapp/ui/dialogs/search.dart';
import 'package:weatherapp/ui/widgets/row_info.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  late WeatherBloc _weatherBloc;

  String currentCity = "Kathmandu";

  @override
  void initState() {
    super.initState();
    _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    _weatherBloc.add(FetchWeather(currentCity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        if (state is WeatherLoaded) {
          List<WeatherInfo> weatherInfos = [];
          weatherInfos.add(WeatherInfo(
              value: state.weather.windSpeed,
              title: "wind",
              unit: "km/h",
              icon: "assets/icons/wind.svg"));
          weatherInfos.add(WeatherInfo(
              value: state.weather.uvIndex,
              title: "index uv",
              unit: "",
              icon: "assets/icons/sun.svg"));
          weatherInfos.add(WeatherInfo(
              value: state.weather.feelsLike,
              title: "feels like",
              unit: "°",
              icon: "assets/icons/temperature.svg"));
          weatherInfos.add(WeatherInfo(
              value: state.weather.humidity,
              title: "humidity",
              unit: "%",
              icon: "assets/icons/humidity.svg"));

          DateTime now = DateTime.now();
          String date = DateFormat('E, d MMM').format(now);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () async {
                      String? city = await showDialog(
                        context: context,
                        builder: (context) => const DialogSearch(),
                      );
                      if (city != null) {
                        currentCity = city;
                        _weatherBloc.add(FetchWeather(currentCity));
                      }
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${state.weather.city}, ",
                            style: GoogleFonts.jost(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          TextSpan(
                            text: state.weather.country,
                            style: GoogleFonts.jost(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    date,
                    style: GoogleFonts.jost(),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.translate(
                        offset: const Offset(15, 20),
                        child: Text(
                          "${state.weather.temperature}°",
                          style: GoogleFonts.jost(
                            fontSize: 96,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        state.weather.weatherType.toUpperCase(),
                        style: GoogleFonts.jost(
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    childAspectRatio: 1.75,
                    mainAxisSpacing: 12.0),
                padding: const EdgeInsets.all(12.0),
                itemCount: weatherInfos.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return RowInfo(weatherInfo: weatherInfos[index]);
                },
              ),
              Text(
                "Data based on openweathermap.org",
                style: GoogleFonts.jost(
                  color: Colors.black38,
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    ));
  }
}
