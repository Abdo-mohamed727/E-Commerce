import 'package:ecommerce_new/models/peoduct_item_model.dart';
import 'package:ecommerce_new/services/firestore_services.dart';

import '../utils/api_pathes.dart';

abstract class FavouriteServices {
  Future<void> Addfavourite(String userId, ProductItemModel product);
  Future<void> Removefavourite(String userId, String productId);
  Future<List<ProductItemModel>> GetFavourites(
    String userId,
  );
}

class Favouriteservicesimp implements FavouriteServices {
  final firestoreservices = FirestoreServices.instance;

  @override
  Future<void> Addfavourite(String userId, ProductItemModel product) async =>
      await firestoreservices.setData(
          path: ApiPathes.Favouriteproduct(userId, product.id),
          data: product.toMap());

  @override
  Future<List<ProductItemModel>> GetFavourites(
    String userId,
  ) async {
    final result = await firestoreservices.getCollection<ProductItemModel>(
        path: ApiPathes.Favouriteproducts(userId),
        builder: (data, documentId) => ProductItemModel.fromMap(data));
    return result;
  }

  @override
  Future<void> Removefavourite(String userId, String productId) async {
    final result = await firestoreservices.deleteData(
        path: ApiPathes.Favouriteproduct(userId, productId));
    return result;
  }
}
