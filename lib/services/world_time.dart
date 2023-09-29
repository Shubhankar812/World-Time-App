import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location;
  late String time;
  late String flag;
  late String url;
  late bool isDayTime;

  WorldTime({ required this.location, required this.flag, required this.url});


  Future<void> getTime() async {
    try {
      var uri = Uri.parse(
          "https://worldtimeapi.org/api/timezone/$url"); // actual URL....
      Response response = await get(uri);
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // print('$datetime ---- $offset');
      // print(datetime);
      // print(offset);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now); // set time property
    }
    // modification done here
    catch(e) {
      print("caught an error $e");
      time = "could not get the time";
    }
  }

}

WorldTime instance = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
