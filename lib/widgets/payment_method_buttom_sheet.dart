import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_new/utils/app_colors.dart';

import 'package:ecommerce_new/utils/app_routes.dart';
import 'package:ecommerce_new/view_models/AddNewCard_cubit/Paymentmethod_cubit.dart';
import 'package:ecommerce_new/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodButtomSheet extends StatelessWidget {
  const PaymentMethodButtomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentcubit = BlocProvider.of<PaymentmethodCubit>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Method',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            BlocBuilder(
                bloc: paymentcubit,
                buildWhen: (previous, current) =>
                    current is Fetchedpaymentmethods ||
                    current is Fetchingpaymentmethods ||
                    current is Fetchpaymentmethodserror,
                builder: (_, state) {
                  if (state is Fetchingpaymentmethods) {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is Fetchedpaymentmethods) {
                    final paymentcards = state.paymentcards;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: paymentcards.length,
                        itemBuilder: (context, index) {
                          final paymentcard = paymentcards[index];
                          return Card(
                            elevation: 0,
                            child: ListTile(
                              onTap: () {
                                paymentcubit.ChangePaymentMethod(
                                    paymentcard.id);
                              },
                              leading: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Appcolors.grey2,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: CachedNetworkImage(
                                    height: 50,
                                    width: 50,
                                    imageUrl:
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/MasterCard_Logo.svg/1200px-MasterCard_Logo.svg.png'),
                              ),
                              title: Text(paymentcard.cardHolderName),
                              subtitle: Text(paymentcard.cardNumber),
                              trailing: BlocBuilder<PaymentmethodCubit,
                                  PaymentMethodState>(
                                bloc: paymentcubit,
                                buildWhen: (previous, current) =>
                                    current is PaymentMethodChosen,
                                builder: (context, state) {
                                  if (state is PaymentMethodChosen) {
                                    final chosenpaymentmethod =
                                        state.chosenpayment;
                                    return Radio<String>(
                                        value: paymentcard.id,
                                        groupValue: chosenpaymentmethod.id,
                                        onChanged: (id) {
                                          paymentcubit.ChangePaymentMethod(id!);
                                        });
                                  } else {
                                    return SizedBox();
                                  }
                                },
                              ),
                            ),
                          );
                        });
                  } else if (state is Fetchpaymentmethodserror) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return SizedBox();
                  }
                }),
            SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(AppRouts.AddNewCardRoute,
                        arguments: paymentcubit)
                    .then((value) async =>
                        await paymentcubit.fetchpaymentmethod());
              },
              child: Card(
                child: ListTile(
                  title: Text('Add New Card'),
                  trailing: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Appcolors.grey2),
                      child: Icon(Icons.add)),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            BlocConsumer<PaymentmethodCubit, PaymentMethodState>(
              listenWhen: (previous, current) =>
                  current is ConfirmpaymentSuccess,
              bloc: paymentcubit,
              buildWhen: (previous, current) =>
                  current is ConfirmpaymentLooding ||
                  current is ConfirmpaymentSuccess ||
                  current is Confirmpaymentfailure,
              listener: (context, state) {
                if (state is ConfirmpaymentSuccess) {
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                if (state is ConfirmpaymentLooding) {
                  return MainButton(
                    islooding: true,
                    ontap: null,
                  );
                }
                return MainButton(
                  title: 'Confirm Payment',
                  ontap: () {
                    paymentcubit.confirmPaymentMethod();
                  },
                );
              },
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
