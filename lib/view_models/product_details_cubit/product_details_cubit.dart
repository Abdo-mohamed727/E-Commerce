import 'package:bloc/bloc.dart';
import 'package:ecommerce_new/models/add_tocart_model.dart';
import 'package:ecommerce_new/models/peoduct_item_model.dart';
import 'package:ecommerce_new/services/auth_services.dart';

import 'package:ecommerce_new/services/product_details_services.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  int quantity = 1;
  ProductSize? selectedsize;
  final productdetailservices = Productdetailsservicesimpl();
  final authservices = Authservicesimp();

  void GetproductDetails(String id) async {
    emit(productDetailsLooding());
    try {
      final selectedproduct =
          await productdetailservices.fetchproductdetails(id);
      emit(ProductDetailsLooded(product: selectedproduct));
    } catch (e) {
      emit(ProductDetailsError(message: e.toString()));
    }
  }

  void SelectedSize(ProductSize size) {
    selectedsize = size;
    emit(sizeselected(size: size));
  }

  void IncrementCounter(String ProductId) {
    quantity++;

    emit(QuantityCounterlooded(
      value: quantity,
    ));
  }

  void DecrementCounter(String ProductId) {
    emit(QuantityCounterlooded(
      value: quantity,
    ));
  }

  Future<void> AddToCart(String ProductId) async {
    emit(ProductAddingtoCart());
    try {
      final selectedproduct =
          await productdetailservices.fetchproductdetails(ProductId);
      final currentuser = authservices.currentuser();
      final CartItem = AddToCartModel(
        id: DateTime.now().toIso8601String(),
        Product: selectedproduct, // مهم جدا
        size: selectedsize!,
        quantity: quantity,
      );
      await productdetailservices.addtocart(CartItem, currentuser!.uid);

      emit(ProductAddedTocart(ProductId: ProductId));
    } catch (e) {
      emit(ProductAddtoCartError(e.toString()));
    }
  }
}
