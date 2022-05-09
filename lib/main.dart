import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:crimespy/view/pages/firstpage.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseApp.configure(
    name: "crimespy",
    options: FirebaseOptions(
      projectID: "crimespy-9e551",
      apiKey: "AIzaSyAsu89EHF11Mj0IsPRkZvAvKLSjBpFMyRI",
      googleAppID: "1:921416786140:android:2205308e213fd6ccd51419",
      gcmSenderID: "921416786140",
      storageBucket: "gs://crimespy-9e551.appspot.com",
    ),
  ) ;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'CrimeSpy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirstPage(),
    );
  }
}
