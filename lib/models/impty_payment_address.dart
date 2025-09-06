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
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        if (ispayment) {
          Navigator.of(context)
              .pushNamed(AppRouts.AddNewCardRoute, arguments: paymentCubit)
              .then((_) async => await checkoutCubit.getcartitems());
        } else {
          Navigator.of(context).pushNamed(AppRouts.ChosenaddressRoute);
        }
      },
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
