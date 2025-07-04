import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'utils/device_id.dart';
import 'package:provider/provider.dart';


import 'studypage.dart';
import 'coffeeplaces.dart';
import 'taskspage.dart';
import 'musicpage.dart';
import 'settingspage.dart';
import 'profilepage.dart';
import 'homepage.dart';

import 'utils/time_provider.dart';
import 'utils/timer_provider_break.dart';
import 'utils/points_counter.dart';





void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String deviceId = await DeviceUtils.getDeviceId();

  bool doesExist = await DeviceUtils.doesDeviceExist(deviceId);
  if (!doesExist) {
    await DeviceUtils.addDeviceIfNotExists(deviceId);
    print('Device ID added to Firestore: $deviceId');
  }
  print('Device ID: $deviceId');

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(
    //   create: (context) => TimerProvider(10),
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TimerProvider>(
          create: (context) => TimerProvider(0),
        ),
        ChangeNotifierProvider<TimerProviderBreak>(
          create: (context) => TimerProviderBreak(0),
        ),
        ChangeNotifierProvider<PointsCounter>(
          create: (context) => PointsCounter(0),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // Define the routes
        routes: {
          '/': (context) => const MyHomePage(),
          '/studypage': (context) => const PlacesPage(),
          '/coffeeplaces': (context) => const StudyPage(),
          '/taskspage': (context) => const TasksPage(),
          '/musicpage': (context) => MusicPage(),
          '/settingspage': (context) => const SettingsPage(),
          '/profilepage': (context) => const ProfilePage(),
        },
      ),
    );
  }
}


