import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  StreamSubscription? getServiceStatusStream;

  GpsBloc() : super( const GpsState( isGpsEnabled: false, isGpsPermissionGranted: false )) {

    on<GpsPermissionEvent>((event, emit) => emit( state.copyWith(
       isGpsEnabled: event.isGpsEnabled,
       isGpsPermissionGranted: event.isGpsPerssionGranted
      ))
    );
    _init();
    askGpsAcces();
  }

  Future <void> _init() async{

    final isEnabled = await _chechkGpsStatus();

    add(GpsPermissionEvent(
        isGpsEnabled: isEnabled,
        isGpsPerssionGranted: state.isGpsPermissionGranted
    ));
    print("isGpsEnabled:$isEnabled");
  }

  Future <bool> _chechkGpsStatus() async{

    final isEnabled = await Geolocator.isLocationServiceEnabled();
    Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = ( event.index == 1 ) ? true : false;
      print("isGpsEnabled:$isEnabled");
    });

    return isEnabled;
  }

  Future<void> askGpsAcces () async{

    final status = await Permission.location.request();

    switch ( status ) {

      case PermissionStatus.granted:
        add(GpsPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPerssionGranted: true));
        break;

      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      add(GpsPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPerssionGranted: false));
    }

  }
  @override
  Future<void> close() {
    getServiceStatusStream?.cancel();
    return super.close();
  }

}
