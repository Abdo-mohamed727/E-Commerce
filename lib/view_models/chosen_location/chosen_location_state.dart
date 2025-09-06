part of 'chosen_location_cubit.dart';

sealed class ChosenLocationState {}

final class ChosenLocationInitial extends ChosenLocationState {}

final class Fetchinglocation extends ChosenLocationState {}

final class Fetchedlocation extends ChosenLocationState {
  final List<LocationItemModel> locations;
  Fetchedlocation(this.locations);
}

final class FetchinglocationFailure extends ChosenLocationState {
  final String errormessage;
  FetchinglocationFailure(this.errormessage);
}

final class AddingLocation extends ChosenLocationState {}

final class AddedLocation extends ChosenLocationState {}

final class AddingLocayionfailure extends ChosenLocationState {
  final String errormessage;
  AddingLocayionfailure(this.errormessage);
}

final class Locationchosen extends ChosenLocationState {
  final LocationItemModel location;
  Locationchosen(this.location);
}

final class ConfirmlocationLooding extends ChosenLocationState {}

final class ConfirmlocationSuccess extends ChosenLocationState {}

final class Confirmlocationfailure extends ChosenLocationState {
  final String message;
  Confirmlocationfailure(this.message);
}
