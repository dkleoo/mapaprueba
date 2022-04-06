part of 'location_user_bloc.dart';

abstract class LocationUserEvent extends Equatable {

  const LocationUserEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class newLocation extends LocationUserEvent {

  final LatLng newLocationEvent;
  const newLocation(this.newLocationEvent);
}

class followingUserStart extends LocationUserEvent{}
class followingUserStop extends LocationUserEvent{}