
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {

  GoogleMapController? mapController;

  MapsBloc() : super( const MapsState()) {

    on<onMapInit>((event, emit) {
      emit( state.copyWith(isMapInicial: true));
    });
  }
}
