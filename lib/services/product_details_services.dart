import 'package:ecommerce_new/models/add_tocart_model.dart';
import 'package:ecommerce_new/models/peoduct_item_model.dart';
import 'package:ecommerce_new/services/firestore_services.dart';
import 'package:ecommerce_new/utils/api_pathes.dart';

abstract class ProductdetailsServices {
  Future<void> fetchproductdetails(String productId);
  Future<void> addtocart(AddToCartModel cartitem, String userid);
}

class Productdetailsservicesimpl implements ProductdetailsServices {
  final firestoreservices = FirestoreServices.instance;

  @override
  Future<ProductItemModel> fetchproductdetails(String productId) async {
    final result = await firestoreservices.getDocument(
        path: ApiPathes.product(productId),
        builder: (data, documentId) => ProductItemModel.fromMap(
              data,
            ));
    return result;
  }

  @override
  Future<void> addtocart(AddToCartModel cartitem, String userid) async =>
      firestoreservices.setData(
          path: ApiPathes.cartitem(userid, cartitem.id),
          data: cartitem.toMap());
}
