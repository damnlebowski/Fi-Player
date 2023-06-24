import 'package:fi_player/bloc/liked_video/liked_video_bloc.dart';
import 'package:fi_player/bloc/playlist/playlist_bloc.dart';
import 'package:fi_player/bloc/playlist_inner_video/playlist_inner_videos_bloc.dart';
import 'package:fi_player/bloc/search_page/search_page_bloc.dart';
import 'package:fi_player/functions/all_functions.dart';
import 'package:fi_player/model/model.dart';
import 'package:fi_player/screens/splash/screen_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  if (!Hive.isAdapterRegistered(PlayedHistoryAdapter().typeId)) {
    Hive.registerAdapter(PlayedHistoryAdapter());
  }

  await Hive.openBox<LikedVideo>('liked_video');
  await Hive.openBox<PlayList>('playlist_video');
  await Hive.openBox<LastPlayed>('last_played');
  await Hive.openBox<PlayedHistory>('played_history');
  getEverthing();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LikedVideoBloc()),
        BlocProvider(create: (context) => PlaylistBloc()),
        BlocProvider(create: (context) => PlaylistInnerVideosBloc()),
        BlocProvider(create: (context) => SearchPageBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.purple),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
