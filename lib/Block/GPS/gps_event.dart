part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}


class GpsPermissionEvent extends GpsEvent {
  final bool isGpsEnabled;
  final bool isGpsPerssionGranted;

  const GpsPermissionEvent({
      required this.isGpsEnabled,
      required this.isGpsPerssionGranted
    });

}