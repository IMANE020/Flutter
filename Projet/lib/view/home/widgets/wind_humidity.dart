import 'package:flutter/material.dart';
import 'package:weather_app/view/core/constants.dart';

class WindAndHumidityContainer extends StatelessWidget {
  final String windSpeed;
  final String humidity;
  final String visibility;
  final String pressure;

  const WindAndHumidityContainer({
    Key? key,
    required this.windSpeed,
    required this.humidity,
    this.visibility = "10",
    this.pressure = "1013",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildItem(Icons.air, 'Vent', '$windSpeed km/h'),
        _buildItem(Icons.water_drop_outlined, 'Humidité', '$humidity%'),
        _buildItem(Icons.visibility_outlined, 'Visibilité', '${visibility} km'),
        _buildItem(Icons.speed, 'Pression', '$pressure mb'),
      ],
    );
  }

  Widget _buildItem(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: cardDecoration, // Use white card style
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: lightBgColor, // Light blue circle bg
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.blue, size: 20),
            ),
            const SizedBox(height: 10),
            Text(label, style: greyTxt14.copyWith(fontSize: 12)),
            const SizedBox(height: 5),
            Text(value, style: darkTxt16.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
