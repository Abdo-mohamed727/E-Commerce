part of 'Paymentmethod_cubit.dart';

sealed class PaymentMethodState {}

final class PaymentmethodInitial extends PaymentMethodState {}

final class Addnewcardlodding extends PaymentMethodState {}

final class AddNewCardSuccess extends PaymentMethodState {}

final class AddNewCardFailure extends PaymentMethodState {
  final String message;
  AddNewCardFailure({required this.message});
}

final class Fetchingpaymentmethods extends PaymentMethodState {}

final class Fetchedpaymentmethods extends PaymentMethodState {
  final List<PaymentCardModel> paymentcards;
  Fetchedpaymentmethods({required this.paymentcards});
}

final class Fetchpaymentmethodserror extends PaymentMethodState {
  final String message;
  Fetchpaymentmethodserror(this.message);
}

final class PaymentMethodChosen extends PaymentMethodState {
  final PaymentCardModel chosenpayment;

  PaymentMethodChosen(this.chosenpayment);
}

final class ConfirmpaymentLooding extends PaymentMethodState {}

final class ConfirmpaymentSuccess extends PaymentMethodState {}

final class Confirmpaymentfailure extends PaymentMethodState {
  final String message;
  Confirmpaymentfailure(this.message);
}
