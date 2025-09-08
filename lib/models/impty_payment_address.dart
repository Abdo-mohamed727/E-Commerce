import 'package:ecommerce_new/utils/app_colors.dart';
import 'package:ecommerce_new/utils/app_routes.dart';
import 'package:ecommerce_new/view_models/AddNewCard_cubit/Paymentmethod_cubit.dart';
import 'package:ecommerce_new/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImptyPaymentAddress extends StatelessWidget {
  final String title;
  final bool ispayment;

  const ImptyPaymentAddress({
    super.key,
    required this.title,
    required this.ispayment,
  });

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    final paymentCubit = BlocProvider.of<PaymentmethodCubit>(context);
    final size = MediaQuery.of(context).size;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        if (ispayment) {
          Navigator.of(context)
              .pushNamed(AppRouts.AddNewCardRoute, arguments: paymentCubit)
              .then((value) async => await checkoutCubit.getcartitems());
        } else {
          Navigator.of(context).pushNamed(AppRouts.ChosenaddressRoute);
        }
      },
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Appcolors.grey,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * .02, vertical: size.height * .01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Appcolors.primary,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
