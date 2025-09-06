part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class Cartlooding extends CartState {}

final class CartLooded extends CartState {
  final List<AddToCartModel> CartItem;
  final double subtotal;
  CartLooded(this.CartItem, this.subtotal);
}

final class CartError extends CartState {
  final String Message;
  CartError({required this.Message});
}

final class QuantityCounterlooding extends CartState {}

final class QuantityCounterlooded extends CartState {
  final int value;
  final String ProductId;
  QuantityCounterlooded({required this.value, required this.ProductId});
}

final class Updatedsubtotal extends CartState {
  final double subtotal;
  Updatedsubtotal(this.subtotal);
}

final class QuantityCounterError extends CartState {
  final String errormessage;
  QuantityCounterError(this.errormessage);
}
