import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapaprueba/Block/GPS/gps_bloc.dart';
import 'package:mapaprueba/Block/Location/location_user_bloc.dart';
import 'package:mapaprueba/Block/Map/maps_bloc.dart';


class home extends StatefulWidget {

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  late LocationUserBloc locationUserBloc;
  late GoogleMapController controller;

  var lat = 0.0;
  var log = 0.0;

  @override
  void initState() {
    super.initState();
    final location = BlocProvider.of<LocationUserBloc>(context);
    location.getCurrentPosition();
    /*location.startFollowingUser();*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return buildMapboxMap();
        },
      ),
    );
  }

  buildMapboxMap() {
    return BlocBuilder<LocationUserBloc, LocationUserState>(
      builder: (context, state) {

        if(state.newLocation == null) return Text("Espere por favor");

        lat = state.newLocation!.latitude;
        log = state.newLocation!.longitude;

        final CameraPosition inicialcameraposition = CameraPosition(
        target: LatLng (state.newLocation!.latitude, state.newLocation!.longitude),
        zoom: 18);

          return Stack(
              children: [
                GoogleMaps(inicialcameraposition: inicialcameraposition),
                Positioned(child: Text(""),)
          ]
        );
      },
    );
  }

}

class GoogleMaps extends StatelessWidget {

  final CameraPosition inicialcameraposition;

  GoogleMaps({required this.inicialcameraposition});

  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapsBloc>(context);

    return GoogleMap(
      compassEnabled: false,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      initialCameraPosition: inicialcameraposition,
      onMapCreated: ( controller ) => mapBloc.add( onMapInit(controller)),
    );
  }
}
