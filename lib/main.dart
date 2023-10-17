import 'package:flutter/material.dart';
import 'package:flutter_application_2/layout/home_layout.dart';
// import 'package:flutter_application_2/modules/counter_screen/counter_screen.dart';
import 'package:flutter_application_2/shared/bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 8, 0, 122),
      ),
    );
  }
}

