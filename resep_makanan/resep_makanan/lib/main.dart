import 'package:flutter/material.dart';
import 'package:resep_makanan/views/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "", // Your apiKey
    appId: "1:119893453267:android:9e9d24acc249c80994a726", // Your appId
    messagingSenderId: "119893453267", // Your messagingSenderId
    projectId: "cool-drive-317308", // Your projectId
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resep Makanan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.white,
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white))),
      home: HomePage(),
    );
  }
}
