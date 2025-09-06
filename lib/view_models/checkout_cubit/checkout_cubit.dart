import 'package:bloc/bloc.dart';
import 'package:ecommerce_new/models/Add_payment_method.dart';
import 'package:ecommerce_new/models/add_tocart_model.dart';
import 'package:ecommerce_new/models/location_item_model.dart';
import 'package:ecommerce_new/services/auth_services.dart';
import 'package:ecommerce_new/services/cart_services.dart';
import 'package:ecommerce_new/services/location_services.dart';
import 'package:ecommerce_new/services/paymentcard_services.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  final checkoutservices = CheckoutServicesimp();
  final authservices = Authservicesimp();
  final cartservices = Cartservicesimp();
  final locationservices = LocationServicesImp();

  Future<void> getcartitems() async {
    emit(Checkoutlooding());
    try {
      final currentuser = authservices.currentuser();
      final cartitems = await cartservices.fetchcartitems(currentuser!.uid);
      final subtotal = cartitems.fold<double>(
          0,
          (previousvalue, element) =>
              previousvalue + (element.Product.price * element.quantity));
      final numofproducts = cartitems.fold<int>(
          0, (prevoiusvalue, element) => prevoiusvalue + element.quantity);
      // final chosenpaymentcard =
      //     (await checkoutservices.fetchpaymentcards(currentuser.uid, true))
      //         .first;
      // print(" Payment Cards List: $chosenpaymentcard");

      // final chosenlocation =
      //     (await locationservices.FetchlocationItem(currentuser.uid, true))
      //         .first;
      // print("Location List: $chosenlocation");
      final paymentCards =
      await checkoutservices.fetchpaymentcards(currentuser.uid, true);
      final chosenpaymentcard =
      paymentCards.isNotEmpty ? paymentCards.first : null;

// 🛡️ تحقق من المواقع
      final locations =
      await locationservices.FetchlocationItem(currentuser.uid, true);
      final chosenlocation = locations.isNotEmpty ? locations.first : null;

// إذا أحدهم مفقود، أظهر خطأ
      if (chosenpaymentcard == null || chosenlocation == null) {
        emit(CheckoutError(
            Message: "Please select a payment method and location."));

      }

      emit(Checkoutlooded(
        cartitems: cartitems,
        totalamount: subtotal + 10,
        numsofproducts: numofproducts,
        ChosenPaymentCard: chosenpaymentcard,
        chosenlocation: chosenlocation,
      ));
    } catch (e) {
      emit(CheckoutError(Message: e.toString()));
    }
  }
}
