part of 'location_user_bloc.dart';

class LocationUserState extends Equatable {

  final bool followingUser;
  final LatLng? newLocation;


  const LocationUserState({
    this.followingUser = false,
    this.newLocation
  });

  LocationUserState copiWith({
    bool? followingUser,
    LatLng? newLocation
  }) => LocationUserState(
    followingUser: followingUser ?? this.followingUser,
    newLocation: newLocation ?? this.newLocation
  );

  @override
  List<Object> get props => [];
}

