import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapaprueba/Block/GPS/gps_bloc.dart';
import 'package:mapaprueba/Block/Map/maps_bloc.dart';
import 'package:mapaprueba/home.dart';

import 'Block/Location/location_user_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<GpsBloc>(create: (_) => GpsBloc()),
        BlocProvider(create: (_) => LocationUserBloc()),
        BlocProvider(create: (_) => MapsBloc())
      ],
      child: MyApp()
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home(),
    );
  }
}
