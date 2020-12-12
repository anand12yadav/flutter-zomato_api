
import 'package:flutter/material.dart';
import 'search_screen.dart';
import './search_filters_screen.dart';

class RestaurantSearchApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: SearchPage(title: 'Flutter Demo Home Page',),
      initialRoute: 'home',
      routes: {
        'home':(context)=>SearchPage(title: 'Restaurant App',),
        'filters':(context)=>SearchFilters(),
      },
    );
  }
}

