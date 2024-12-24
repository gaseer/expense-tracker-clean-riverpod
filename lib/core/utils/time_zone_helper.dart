import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeZoneHelper {
  static Future<void> initializeTimeZone() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation('America/Detroit')); // Change location as needed
  }
}
