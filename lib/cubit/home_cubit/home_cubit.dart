import 'package:ecommerce_new/services/auth_services.dart';
import 'package:ecommerce_new/services/favourite_services.dart';
import 'package:ecommerce_new/services/home_data_services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_new/models/carsoul_item_model.dart';
import 'package:ecommerce_new/models/peoduct_item_model.dart';
import 'package:ecommerce_new/models/category_Tab_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final homeservices = Homeservicesimp();
  final authservices = Authservicesimp();
  final favouriteservices = Favouriteservicesimp();

  Future<void> getproducts() async {
    emit(Homeloading());
    try {
      final currentUser = authservices.currentuser();
      final products = await homeservices.fetchproducts();
      final caurselitems = await homeservices.fetchcarsoulitem();
      final categories = await homeservices.fetchcategories();
      final favouriteproducts =
          await favouriteservices.GetFavourites(currentUser!.uid);

      final List<ProductItemModel> finalproducts = products.map((product) {
        final isfavourite =
            favouriteproducts.any((item) => item.id == product.id);
        return product.copyWith(isFavorite: isfavourite);
      }).toList();

      emit(Homeloaded(
          carouselItem: caurselitems,
          productItem: finalproducts,
          categoryitems: categories));
    } catch (e) {
      emit(HomeError(Message: e.toString()));
    }
  }

  Future<void> setfavourite(ProductItemModel product) async {
    emit(setfavouritelooding(ProductId: product.id));
    try {
      final currentuser = authservices.currentuser();
      final favouriteproducts =
          await favouriteservices.GetFavourites(currentuser!.uid);
      final isfavourite =
          favouriteproducts.any((item) => item.id == product.id);

      if (isfavourite) {
        await favouriteservices.Removefavourite(currentuser.uid, product.id);
      } else {
        await favouriteservices.Addfavourite(currentuser.uid, product);
      }
      emit(setfavouritesuccess(
          isfavourite: !isfavourite, ProductId: product.id));
    } catch (e) {
      emit(setfavouritefailure(e.toString(), product.id));
    }
  }

  Future<void> getproductsbycategory(String category) async {
    emit(getproductsbycategoryloading());
    try {
      final currentUser = authservices.currentuser();
      final products =
          await homeservices.fetchProductsByCategory(category.trim());
      final favouriteproducts =
          await favouriteservices.GetFavourites(currentUser!.uid);

      final List<ProductItemModel> finalproducts = products.map((product) {
        final isfavourite =
            favouriteproducts.any((item) => item.id == product.id);
        return product.copyWith(isFavorite: isfavourite);
      }).toList();

      emit(getproductsbycategorysuccess(productItem: finalproducts));
    } catch (e) {
      emit(getproductsbycategoryfailure(e.toString()));
    }
  }
}
