import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify_app/core/config/themes/app_theme.dart';
import 'package:spotify_app/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:spotify_app/presentation/pages/splash.dart';
import 'package:device_preview/device_preview.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/service_located.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyA1uLd8E1x4QPU38-dJjvg47obgeeH_09g",
      appId: "1:856243836026:web:1ab1559d9a2a394ccd17c3",
      messagingSenderId: "856243836026",
      authDomain: "spotify-2b5b6.firebaseapp.com",
      projectId: "spotify-2b5b6",
      storageBucket: "spotify-2b5b6.appspot.com",
    ));
  } else if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyDFq3ChqeoCTbR1Sz2LZhVr_C__hNyF23o",
      appId: "1:856243836026:android:4b6914e02a5daac4cd17c3",
      messagingSenderId: "",
      projectId: "spotify-2b5b6",
      storageBucket: "spotify-2b5b6.appspot.com",
    ));
  } else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyCiFIH0mIFmMrcJvPq-p16rypJ_lpWwJO4",
      appId: "1:856243836026:ios:60fb197899349978cd17c3",
      messagingSenderId: "",
      projectId: "spotify-2b5b6",
    ));
  }

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await initializeDependecies();
  runApp(
     MyApp(), // Wrap your app
    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => ThemeCubit())],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (BuildContext context, ThemeMode mode) => MaterialApp(
          
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          home: const SplashPage(),
        ),
      ),
    );
  }
}
