part of 'maps_bloc.dart';

abstract class MapsEvent extends Equatable {
  const MapsEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class onMapInit extends MapsEvent{
final GoogleMapController controller;

  const onMapInit(this.controller);

}
