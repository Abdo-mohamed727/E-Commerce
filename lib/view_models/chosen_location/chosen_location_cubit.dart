import 'package:ecommerce_new/models/location_item_model.dart';
import 'package:ecommerce_new/services/auth_services.dart';
import 'package:ecommerce_new/services/location_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chosen_location_state.dart';

class ChosenLocationCubit extends Cubit<ChosenLocationState> {
  ChosenLocationCubit() : super(ChosenLocationInitial());
  String? selsctedLocationId;
  LocationItemModel? selectedLocation;
  final locationservices = LocationServicesImp();
  final authservices = Authservicesimp();

  Future<void> fetchlocation() async {
    emit(Fetchinglocation());
    try {
      final currentuser = authservices.currentuser();
      final locations =
          await locationservices.FetchlocationItem(currentuser!.uid);
     // emit(Fetchedlocation(locations));

      if (locations.isNotEmpty) {
        final chosenlocation = locations.firstWhere(
            (element) => element.ischosen,
            orElse: () => locations.first);
        selsctedLocationId = chosenlocation.id;
        selectedLocation = chosenlocation;
        emit(Fetchedlocation(locations));
        emit(Locationchosen(chosenlocation));
      } else {
        emit(FetchinglocationFailure('there is no location'));
      }

      // for (var Location in locations) {
      //   if (Location.ischosen) {
      //     selsctedLocationId = Location.id;
      //     selectedLocation = Location;
      //   }
      // }
      // selsctedLocationId ??= locations.first.id;
      // selectedLocation ??= locations.first;
      // emit(Fetchedlocation(locations));
      // emit(Locationchosen(selectedLocation!));
    } catch (e) {
      emit(FetchinglocationFailure(e.toString()));
    }
  }

  Future<void> addlocation(String location) async {
    try {
      final currentuser = authservices.currentuser();
      final Splittedloction = location.split('-');
      final locationitem = LocationItemModel(
          id: DateTime.now().toIso8601String(),
          city: Splittedloction[0],
          country: Splittedloction[1]);
      dummyLocations.add(locationitem);

      await locationservices.AddLocation(currentuser!.uid, locationitem);
      emit(AddedLocation());
      final locations =
          await locationservices.FetchlocationItem(currentuser.uid);

      emit(Fetchedlocation(locations));
    } catch (e) {
      emit(AddingLocayionfailure(e.toString()));
    }
  }

  Future<void> Selectedocation(String id) async {
    selsctedLocationId = id;
    final currentuser = authservices.currentuser();
    final ChosenLocation =
        await locationservices.Fetchlocation(currentuser!.uid, id);
    selectedLocation = ChosenLocation;
    emit(Locationchosen(ChosenLocation));
  }

  Future<void> confirmlocation() async {
    emit(ConfirmlocationLooding());
    try {
      final currentuser = authservices.currentuser();
      var previouschosenlocation =
          await locationservices.FetchlocationItem(currentuser!.uid, true);
      if (previouschosenlocation.isNotEmpty) {
        var previouslocation = previouschosenlocation.first;
        previouslocation = previouslocation.copywith(ischosen: false);
        await locationservices.AddLocation(currentuser.uid, previouslocation);
        await locationservices.AddLocation(currentuser.uid, selectedLocation!);
      }
      selectedLocation = selectedLocation!.copywith(ischosen: true);
      await locationservices.AddLocation(currentuser.uid, selectedLocation!);
      emit(ConfirmlocationSuccess());
    } catch (e) {
      emit(Confirmlocationfailure(e.toString()));
    }
  }
}
