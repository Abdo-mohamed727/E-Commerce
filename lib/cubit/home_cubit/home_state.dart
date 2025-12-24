part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class Homeloading extends HomeState {}

final class Homeloaded extends HomeState {
  Homeloaded(
      {required this.carouselItem,
      required this.productItem,
      required this.categoryitems});

  List<HomeCarouselItemModel> carouselItem;
  List<ProductItemModel> productItem;
  List<CategoryModel> categoryitems;
}

final class HomeError extends HomeState {
  HomeError({required this.Message});
  final String Message;
}

final class getproductsbycategoryloading extends HomeState {}

final class getproductsbycategorysuccess extends HomeState {
  final List<ProductItemModel> productItem;

  getproductsbycategorysuccess({required this.productItem});
}

final class getproductsbycategoryfailure extends HomeState {
  final String message;

  getproductsbycategoryfailure(this.message);
}

final class setfavouritelooding extends HomeState {
  final String ProductId;

  setfavouritelooding({required this.ProductId});
}

final class setfavouritesuccess extends HomeState {
  final bool isfavourite;
  final String ProductId;

  setfavouritesuccess({required this.isfavourite, required this.ProductId});
}

final class setfavouritefailure extends HomeState {
  final String message;
  final String ProductId;

  setfavouritefailure(this.message, this.ProductId);
}
