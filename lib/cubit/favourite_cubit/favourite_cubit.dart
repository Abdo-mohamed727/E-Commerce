import 'package:ecommerce_new/models/peoduct_item_model.dart';
import 'package:ecommerce_new/services/auth_services.dart';
import 'package:ecommerce_new/services/favourite_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());
  final favouriteservice = Favouriteservicesimp();
  final authservices = Authservicesimp();

  Future<void> getFavouriteProduct() async {
    emit(FavouriteLooding());
    try {
      final currentuser = authservices.currentuser();
      final favouriteproducts =
          await favouriteservice.GetFavourites(currentuser!.uid);
      emit(FavouriteLooded(favouriteproducts));
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  Future<void> removefavourite(String productId) async {
    emit(Removingfavourite(productId));
    try {
      final currentuser = authservices.currentuser();
      await favouriteservice.Removefavourite(currentuser!.uid, productId);
      emit(FavouriteRemoved(productId));
      final favouriteproducts =
          await favouriteservice.GetFavourites(currentuser.uid);
      emit(FavouriteLooded(favouriteproducts));
    } catch (e) {
      emit(FavouriteremoveError(e.toString(), productId));
    }
  }
}
