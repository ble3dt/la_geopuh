import 'package:flutter/material.dart';
import 'package:la_geopuh/assets/themes.dart';
import 'package:la_geopuh/views/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBxaM60OErS-G2vrwn-cYTngn16i-TE_MQ",
          appId: "1:523486171018:android:25797bfe25ae76fff70273",
          messagingSenderId: "523486171018",
          projectId: "la-geopuh",
          storageBucket: "la-geopuh.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
