import 'package:fi_player/functions/all_functions.dart';
import 'package:fi_player/model/model.dart';
import 'package:fi_player/screens/splash/screen_splash.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(LikedVideoAdapter().typeId)) {
    Hive.registerAdapter(LikedVideoAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayListAdapter().typeId)) {
    Hive.registerAdapter(PlayListAdapter());
  }
  if (!Hive.isAdapterRegistered(LastPlayedAdapter().typeId)) {
    Hive.registerAdapter(LastPlayedAdapter());
  }

  await Hive.openBox<LikedVideo>('liked_video');
  await Hive.openBox<PlayList>('playlist_video');
  await Hive.openBox<LastPlayed>('last_played');
  getEverthing();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
