import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_user_event.dart';
part 'location_user_state.dart';

class LocationUserBloc extends Bloc<LocationUserEvent, LocationUserState> {

  StreamSubscription? posotionStrem;

  LocationUserBloc() : super(  LocationUserState() ) {

    on<newLocation>((event, emit) {
      emit(state.copiWith(followingUser: false,newLocation: event.newLocationEvent));
    });
    
    on<followingUserStart>((event, emit) => state.copiWith(followingUser: true));
    on<followingUserStop>((event, emit) => state.copiWith(followingUser: false));

  }

  Future getCurrentPosition() async{
    final position = await Geolocator.getCurrentPosition();
    add( newLocation( LatLng( position.latitude , position.longitude )));
  }

  void startFollowingUser(){
    add(followingUserStart());
    posotionStrem = Geolocator.getPositionStream().listen((event) {
      final position = event;
      add( newLocation( LatLng( position.latitude , position.longitude )));
    });
  }

  void stopFollowingUser(){
    posotionStrem?.cancel();
    add(followingUserStop());
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
