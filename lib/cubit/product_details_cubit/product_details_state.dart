part of 'product_details_cubit.dart';

sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class productDetailsLooding extends ProductDetailsState {}

final class ProductDetailsLooded extends ProductDetailsState {
  final ProductItemModel product;
  ProductDetailsLooded({required this.product});
}

final class QuantityCounterlooded extends ProductDetailsState {
  final int value;

  QuantityCounterlooded({
    required this.value,
  });
}

final class sizeselected extends ProductDetailsState {
  final ProductSize size;
  sizeselected({required this.size});
}

final class ProductAddingtoCart extends ProductDetailsState {}

final class ProductAddtoCartError extends ProductDetailsState {
  final String message;
  ProductAddtoCartError(this.message);
}

final class ProductAddedTocart extends ProductDetailsState {
  final String ProductId;
  ProductAddedTocart({required this.ProductId});
}

final class ProductDetailsError extends ProductDetailsState {
  final String message;
  ProductDetailsError({required this.message});
}
