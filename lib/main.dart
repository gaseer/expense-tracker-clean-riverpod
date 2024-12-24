import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/database/db_helper.dart';
import 'core/notification/notification_service.dart';
import 'core/theme/theme.dart';
import 'core/utils/time_zone_helper.dart';
import 'features/expenses/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await TimeZoneHelper.initializeTimeZone();

  await NotificationService().initialize();
  await NotificationService().scheduleMinuteNotifications();

  final database = await DBHelper.initDB();

  runApp(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(database)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme(),
      home: const HomePage(),
    );
  }
}
