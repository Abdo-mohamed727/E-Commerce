import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_new/models/Add_payment_method.dart';

import 'package:ecommerce_new/services/firestore_services.dart';
import 'package:ecommerce_new/utils/api_pathes.dart';

abstract class CheckouServices {
  Future<void> addNewCard(String userId, PaymentCardModel paymentcard);
  Future<void> updateCard(String userId, PaymentCardModel paymentCard);
  Future<List<PaymentCardModel>> fetchpaymentcards(String userId,
      [bool chosen = false]);
  Future<PaymentCardModel> fetchSinglepaymentcards(
      String userId, String paymentId);
}

class CheckoutServicesimp implements CheckouServices {
  final firestoreservices = FirestoreServices.instance;

  @override
  Future<void> addNewCard(String userId, PaymentCardModel paymentcard) async =>
      await firestoreservices.setData(
          path: ApiPathes.paymentcard(userId, paymentcard.id),
          data: paymentcard.toMap());

  @override
  Future<List<PaymentCardModel>> fetchpaymentcards(String userId,
          [bool chosen = false]) async =>
      await firestoreservices.getCollection(
          path: ApiPathes.paymentcards(userId),
          builder: (data, documentId) => PaymentCardModel.fromMap(data),
          queryBuilder: (chosen
              ? (query) => query.where('isChosen', isEqualTo: true)
              : null));

  @override
  Future<PaymentCardModel> fetchSinglepaymentcards(
          String userId, String paymentId) async =>
      await firestoreservices.getDocument(
          path: ApiPathes.paymentcard(userId, paymentId),
          builder: (data, documentId) => PaymentCardModel.fromMap(data));

  @override
  Future<void> updateCard(String userId, PaymentCardModel paymentCard) async {
    await FirebaseFirestore.instance
        .doc(ApiPathes.paymentcard(userId, paymentCard.id))
        .update(paymentCard.toMap());
  }
}
