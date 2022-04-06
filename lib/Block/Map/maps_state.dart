part of 'maps_bloc.dart';

class MapsState extends Equatable {

  final bool isMapInicial;
  final bool followUser;

  const MapsState({
    this.isMapInicial = false,
    this.followUser = false
  });

  MapsState copyWith({
    bool? isMapInicial,
    bool? followUser,
  }) => MapsState(
    isMapInicial: isMapInicial ?? this.isMapInicial,
    followUser: followUser ?? this.followUser,
  );

  @override
  List<Object> get props => [];
}


