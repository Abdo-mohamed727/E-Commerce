part of 'favourite_cubit.dart';

sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

final class FavouriteLooding extends FavouriteState {}

final class FavouriteLooded extends FavouriteState {
  final List<ProductItemModel> favouriteproduct;
  FavouriteLooded(this.favouriteproduct);
}

final class FavouriteError extends FavouriteState {
  final String errormessage;
  FavouriteError(this.errormessage);
}

final class Removingfavourite extends FavouriteState {
  final String productId;
  Removingfavourite(this.productId);
}

final class FavouriteRemoved extends FavouriteState {
  final String productId;
  FavouriteRemoved(this.productId);
}

final class FavouriteremoveError extends FavouriteState {
  final String error;
  String ProductId;
  FavouriteremoveError(this.error, this.ProductId);
}
