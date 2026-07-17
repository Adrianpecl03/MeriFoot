import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/player.dart';
import 'models/player_position.dart';
import 'screens/home/home_screen.dart';
import 'models/callup.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(PlayerAdapter());
  Hive.registerAdapter(PlayerPositionAdapter());
  Hive.registerAdapter(CallupAdapter());

  await Hive.openBox<Player>("players");
  await Hive.openBox<Callup>("callups");

  runApp(const LineUp11App());
}

class LineUp11App extends StatelessWidget {
  const LineUp11App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LineUp11',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: const HomeScreen(),
    );
  }
}