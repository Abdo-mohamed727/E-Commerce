import 'package:ecommerce_new/services/auth_services.dart';
import 'package:ecommerce_new/services/cart_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_new/models/add_tocart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  final cartservices = Cartservicesimp();
  final authservices = Authservicesimp();
  int quantity = 1;
  Future<void> AddToCart() async {
    emit(Cartlooding());
    try {
      final currentuser = authservices.currentuser();
      final cartitems = await cartservices.fetchcartitems(currentuser!.uid);

      emit(CartLooded(cartitems, _subtotal(cartitems)));
    } catch (e) {
      emit(CartError(Message: e.toString()));
    }
  }

  Future<void> IncrementCounter(AddToCartModel cartItem,
      [int? initialvalue]) async {
    if (initialvalue != null) {
      quantity = initialvalue;
    }
    quantity++;
    try {
      emit(QuantityCounterlooding());

      final currentuser = authservices.currentuser();
      final updatedcartItem = cartItem.copyWith(quantity: quantity);
      await cartservices.SetcartItem(updatedcartItem, currentuser!.uid);

      emit(QuantityCounterlooded(
          value: quantity, ProductId: updatedcartItem.id));
      final cartItems = await cartservices.fetchcartitems(currentuser.uid);
      emit(CartLooded(cartItems, _subtotal(cartItems)));

      emit(Updatedsubtotal(_subtotal(cartItems)));
    } catch (e) {
      emit(QuantityCounterError(e.toString()));
    }
  }

  Future<void> DecrementCounter(AddToCartModel cartItem,
      [int? initialvalue]) async {
    if (initialvalue != null) {
      quantity = initialvalue;
    }
    quantity--;
    try {
      emit(QuantityCounterlooding());

      final currentuser = authservices.currentuser();
      final updatedcartItem = cartItem.copyWith(quantity: quantity);
      await cartservices.SetcartItem(updatedcartItem, currentuser!.uid);
      emit(QuantityCounterlooded(
        value: quantity,
        ProductId: updatedcartItem.id,
      ));

      final cartItems = await cartservices.fetchcartitems(currentuser.uid);
      emit(CartLooded(cartItems, _subtotal(cartItems)));

      emit(Updatedsubtotal(_subtotal(cartItems)));
    } catch (e) {
      emit(QuantityCounterError(e.toString()));
    }
  }

  double _subtotal(List<AddToCartModel> cartItems) => cartItems.fold<double>(
      0,
      (previousvalue, item) =>
          previousvalue + (item.Product.price * item.quantity));
}
