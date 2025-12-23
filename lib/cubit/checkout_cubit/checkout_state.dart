part of 'checkout_cubit.dart';

sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class Checkoutlooding extends CheckoutState {}

final class Checkoutlooded extends CheckoutState {
  final List<AddToCartModel> cartitems;
  final double totalamount;
  final int numsofproducts;
  final PaymentCardModel? ChosenPaymentCard;
  final LocationItemModel? chosenlocation;
  Checkoutlooded({
    required this.cartitems,
    required this.totalamount,
    required this.numsofproducts,
    this.ChosenPaymentCard,
    this.chosenlocation,
  });
}

final class CheckoutError extends CheckoutState {
  final String Message;
  CheckoutError({required this.Message});
}
