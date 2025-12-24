import 'dart:developer';

import 'package:ecommerce_new/models/carsoul_item_model.dart';
import 'package:ecommerce_new/models/category_Tab_model.dart';
import 'package:ecommerce_new/models/peoduct_item_model.dart';
import 'package:ecommerce_new/services/firestore_services.dart';
import 'package:ecommerce_new/utils/api_pathes.dart';
import 'package:flutter/foundation.dart';

abstract class Homeservices {
  Future<List<ProductItemModel>> fetchproducts();
  Future<List<HomeCarouselItemModel>> fetchcarsoulitem();
  Future<List<CategoryModel>> fetchcategories();
  Future<List<ProductItemModel>> fetchProductsByCategory(String category);
}

class Homeservicesimp implements Homeservices {
  final firestoreservices = FirestoreServices.instance;

  @override
  Future<List<ProductItemModel>> fetchproducts() async {
    final result = await firestoreservices.getCollection<ProductItemModel>(
      path: ApiPathes.products(),
      builder: (data, documentId) {
        data['id'] = documentId;
        return ProductItemModel.fromMap(data);
      },
    );

    return result;
  }

  @override
  Future<List<HomeCarouselItemModel>> fetchcarsoulitem() async {
    final result = await firestoreservices.getCollection<HomeCarouselItemModel>(
      path: ApiPathes.carsoul(),
      builder: (data, documentId) {
        data['id'] = documentId;
        return HomeCarouselItemModel.fromMap(data);
      },
    );

    return result;
  }

  @override
  Future<List<CategoryModel>> fetchcategories() async {
    final result = await firestoreservices.getCollection<CategoryModel>(
      path: ApiPathes.categories(),
      builder: (data, documentId) {
        data['id'] = documentId;
        return CategoryModel.fromMap(data);
      },
    );

    return result;
  }

  @override
  Future<List<ProductItemModel>> fetchProductsByCategory(
      String category) async {
    final result = await firestoreservices.getCollection<ProductItemModel>(
      path: ApiPathes.products(),
      queryBuilder: (query) {
        debugPrint('category $category');
        return query.where('category', isEqualTo: category);
      },
      builder: (data, documentId) {
        data['id'] = documentId;
        return ProductItemModel.fromMap(data);
      },
    );

    return result;
  }
}
