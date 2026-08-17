import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/player.dart';
import 'models/player_position.dart';
import 'screens/home/home_screen.dart';
import 'models/callup.dart';
import 'models/fine.dart';
import 'models/tactic.dart';
import 'models/tactic_object.dart';
import 'models/tactic_arrow.dart';
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(PlayerAdapter());
  Hive.registerAdapter(PlayerPositionAdapter());
  Hive.registerAdapter(CallupAdapter());
  Hive.registerAdapter(FineAdapter());
  Hive.registerAdapter(TacticObjectAdapter());
  Hive.registerAdapter(TacticAdapter());
  Hive.registerAdapter(TacticArrowAdapter());

  await Hive.openBox<Player>("players");
  await Hive.openBox<Callup>("callups");
  await Hive.openBox<Fine>("fines");
  await Hive.openBox<Tactic>("tactics_v2");

  runApp(const MeriFootApp());
}

class MeriFootApp extends StatelessWidget {
  const MeriFootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MeriFoot',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: const HomeScreen(),
    );
  }
}