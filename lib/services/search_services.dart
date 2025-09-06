import 'package:ecommerce_new/models/peoduct_item_model.dart';
import 'package:ecommerce_new/services/firestore_services.dart';
import 'package:ecommerce_new/utils/api_pathes.dart';

abstract class SearchServices {
  Future<List<ProductItemModel>> searchProducts(String query);
}

class SearchServicesImpl implements SearchServices {
  final firestoreservices = FirestoreServices.instance;

  @override
  Future<List<ProductItemModel>> searchProducts(String query) async {
    final result = await firestoreservices.getCollection<ProductItemModel>(
      path: ApiPathes.products(),
      builder: (data, documentId) => ProductItemModel.fromMap(data),
      queryBuilder: (q) => q
          .where("searchKey", isGreaterThanOrEqualTo: query.toLowerCase())
          .where("searchKey",
              isLessThanOrEqualTo: query.toLowerCase() + '\uf8ff'),
    );
    return result;
  }
}
