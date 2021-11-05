import 'dart:convert';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class WorldTime {
  String location;
  String time = "";
  String flag;
  String url;
  late bool isDayTime = true;

  WorldTime({required this.location, required this.flag, required this.url});


  Future<void> getTime() async {

    try {

      // Get the response
      http.Response response = await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));

      Map data = jsonDecode(response.body);   // Store the data in a Map (response.body is a string)

      // Datetime and offset is stored as string
      String datetime = data['datetime'];
      String offset = data['utc_offset'];

      // Convert Datetime string into JSON for easy manipulation
      DateTime currentTime = DateTime.parse(datetime);
      currentTime = currentTime.add(Duration(hours: int.parse(offset.substring(1,3))));

      isDayTime = currentTime.hour > 6 && currentTime.hour < 20;

      // Convert Datetime to string to display on UI
      time = DateFormat.jm().format(currentTime);

    }
    catch (e) {
      time = 'Could Not Fetch The Data';
    }

  }
}