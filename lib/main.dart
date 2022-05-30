import 'package:easy_economy/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MobileAds.instance.initialize();

  await Hive.initFlutter();
  await Hive.openBox("gain");
  await Hive.openBox("spent");
  await Hive.openBox("goal");
  await Hive.openBox("valueSaved");

  runApp(const MaterialApp(
    home: MySplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
