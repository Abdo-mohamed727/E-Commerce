import 'package:ecommerce_new/models/add_tocart_model.dart';
import 'package:ecommerce_new/models/peoduct_item_model.dart';
import 'package:ecommerce_new/services/firestore_services.dart';
import 'package:ecommerce_new/utils/api_pathes.dart';

abstract class cartservices {
  Future<List<AddToCartModel>> fetchcartitems(String userId);
  Future<void> SetcartItem(AddToCartModel cartitem, String userId);
}

class Cartservicesimp implements cartservices {
  final firestoreservices = FirestoreServices.instance;

  @override
  Future<List<AddToCartModel>> fetchcartitems(String userId) async =>
      await firestoreservices.getCollection<AddToCartModel>(
          path: ApiPathes.cartitems(userId),
          builder: (data, DocumentId) => AddToCartModel.fromMap(data));

  @override
  Future<void> SetcartItem(AddToCartModel cartitem, String userId) async =>
      await firestoreservices.setData(
          path: ApiPathes.cartitem(userId, cartitem.id),
          data: cartitem.toMap());
}
