import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/models/weatherinfo.dart';

class RowInfo extends StatelessWidget {
  final WeatherInfo weatherInfo;

  const RowInfo({Key? key, required this.weatherInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 16),
          SvgPicture.asset(
            weatherInfo.icon,
            height: 40,
            width: 40,
          ),
          const SizedBox(width: 12),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weatherInfo.title,
                  style: GoogleFonts.jost(
                      fontSize: 16, color: Colors.grey.shade600),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: weatherInfo.value.toString(),
                        style: GoogleFonts.jost(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      TextSpan(
                        text: " ${weatherInfo.unit}",
                        style: GoogleFonts.jost(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
