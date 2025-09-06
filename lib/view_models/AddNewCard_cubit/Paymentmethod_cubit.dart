import 'package:ecommerce_new/models/Add_payment_method.dart';
import 'package:ecommerce_new/services/auth_services.dart';
import 'package:ecommerce_new/services/paymentcard_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'Paymentmethod_state.dart';

class PaymentmethodCubit extends Cubit<PaymentMethodState> {
  PaymentmethodCubit() : super(PaymentmethodInitial());
  String? SelectedId;
  final checkoutcervices = CheckoutServicesimp();
  final authservices = Authservicesimp();
  PaymentCardModel? selectedpayment;

  Future<void> Setcard(String CardNumber, String cardHolderName,
      String expirydate, String cvv) async {
    emit(Addnewcardlodding());
    try {
      final newcard = PaymentCardModel(
        id: DateTime.now().toIso8601String(),
        cardNumber: CardNumber,
        cardHolderName: cardHolderName,
        expiryDate: expirydate,
        cvv: cvv,
      );
      final currentuser = authservices.currentuser();

      await checkoutcervices.addNewCard(currentuser!.uid, newcard);
      emit(AddNewCardSuccess());
    } catch (e) {
      emit(AddNewCardFailure(message: e.toString()));
    }
  }

  Future<void> fetchpaymentmethod() async {
    emit(Fetchingpaymentmethods());
    try {
      final currentuser = authservices.currentuser();
      final paymentcards =
          await checkoutcervices.fetchpaymentcards(currentuser!.uid);
      emit(Fetchedpaymentmethods(paymentcards: paymentcards));
      if (paymentcards.isNotEmpty) {
        final chosenpayment = paymentcards.firstWhere(
            (element) => element.isChosen,
            orElse: () => paymentcards.first);
        SelectedId = chosenpayment.id;
        selectedpayment=chosenpayment;

        emit(PaymentMethodChosen(chosenpayment));
      }
    } catch (e) {
      emit(Fetchpaymentmethodserror(e.toString()));
    }
  }

  Future<void> ChangePaymentMethod(String id) async {
    SelectedId = id;
    try {
      final currentuser = authservices.currentuser();
      final chosenpaymentmethod = await checkoutcervices
          .fetchSinglepaymentcards(currentuser!.uid, SelectedId!);
      emit(PaymentMethodChosen(chosenpaymentmethod));
    } catch (e) {
      emit(Fetchpaymentmethodserror(e.toString()));
    }
  }

  Future<void> confirmpaymentmethod() async {
    emit(ConfirmpaymentLooding());
    try {
      final currentuser = authservices.currentuser();
      final previouspaymentmethod =
          await checkoutcervices.fetchpaymentcards(currentuser!.uid, true);
      final previouschosenpayment =
          previouspaymentmethod.first.copyWith(isChosen: false);
      var chosenpaymentmethod = await checkoutcervices.fetchSinglepaymentcards(
          currentuser.uid, SelectedId!);
      chosenpaymentmethod = chosenpaymentmethod.copyWith(isChosen: true);
      await checkoutcervices.addNewCard(currentuser.uid, previouschosenpayment);
      await checkoutcervices.addNewCard(currentuser.uid, chosenpaymentmethod);
      emit(ConfirmpaymentSuccess());
    } catch (e) {
      emit(Confirmpaymentfailure(e.toString()));
    }
  }
}
