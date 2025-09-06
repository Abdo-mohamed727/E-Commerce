import 'package:ecommerce_new/models/location_item_model.dart';
import 'package:ecommerce_new/services/firestore_services.dart';
import 'package:ecommerce_new/utils/api_pathes.dart';

abstract class LocationServices {
  Future<List<LocationItemModel>> FetchlocationItem(String userId,
      [bool chosen = false]);
  Future<LocationItemModel> Fetchlocation(String userId, String LocationId);
  Future<void> AddLocation(String Userid, LocationItemModel location);
}

final class LocationServicesImp implements LocationServices {
  final firestoreservices = FirestoreServices.instance;

  @override
  Future<void> AddLocation(String Userid, LocationItemModel location) async =>
      await firestoreservices.setData(
          path: ApiPathes.Location(Userid, location.id),
          data: location.toMap());
  @override
  Future<List<LocationItemModel>> FetchlocationItem(String userId,
      [bool chosen = false]) async {
    final result = await firestoreservices.getCollection(
        path: ApiPathes.Locations(userId),
        builder: (data, documentId) => LocationItemModel.fromMap(data),
        queryBuilder: (chosen
            ? (query) => query.where('ischosen', isEqualTo: true)
            : null));
    print("Fetched locations from Firestore: $result");
    return result;
  }

  @override
  Future<LocationItemModel> Fetchlocation(
          String userId, String LocationId) async =>
      await firestoreservices.getDocument(
          path: ApiPathes.Location(userId, LocationId),
          builder: (data, documentId) => LocationItemModel.fromMap(data));
}
