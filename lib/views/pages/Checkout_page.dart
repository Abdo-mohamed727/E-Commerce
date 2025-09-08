import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_new/models/Add_payment_method.dart';
import 'package:ecommerce_new/models/impty_payment_address.dart';
import 'package:ecommerce_new/models/location_item_model.dart';
import 'package:ecommerce_new/utils/app_routes.dart';
import 'package:ecommerce_new/view_models/AddNewCard_cubit/Paymentmethod_cubit.dart';
import 'package:ecommerce_new/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:ecommerce_new/widgets/checkout_headlines_items.dart';
import 'package:ecommerce_new/widgets/payment_Method_item.dart';
import 'package:ecommerce_new/widgets/payment_method_buttom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/app_colors.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  Widget _buildPaymentMethodItem(
      PaymentCardModel? chosenCard, BuildContext context) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);

    if (chosenCard != null) {
      return PaymentMethodItem(
        PaymentCard: chosenCard,
        onTapped: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Appcolors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                width: double.infinity,
                child: BlocProvider(
                  create: (context) {
                    final cubit = PaymentmethodCubit();
                    cubit.fetchpaymentmethod();
                    return cubit;
                  },
                  child: PaymentMethodButtomSheet(),
                ),
              );
            },
          ).then((value) async {
            await checkoutCubit.getcartitems();
          });
        },
      );
    } else {
      return ImptyPaymentAddress(
        title: 'Add Payment Method',
        ispayment: true,
      );
    }
  }

  Widget _buildLocationItem(
      LocationItemModel? chosenLocation, BuildContext context) {
    if (chosenLocation != null) {
      return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: chosenLocation.imgUrl,
              height: 100,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chosenLocation.city,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '${chosenLocation.city}, ${chosenLocation.country}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
              ),
            ],
          )
        ],
      );
    } else {
      return ImptyPaymentAddress(
        title: 'Add Shipping Address',
        ispayment: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = CheckoutCubit();
            cubit.getcartitems();
            return cubit;
          },
        ),
        BlocProvider(create: (context) => PaymentmethodCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Checkout'),
        ),
        body: Builder(
          builder: (context) {
            final cubit = BlocProvider.of<CheckoutCubit>(context);
            return BlocBuilder<CheckoutCubit, CheckoutState>(
              bloc: cubit,
              buildWhen: (previous, current) =>
                  current is Checkoutlooded ||
                  current is Checkoutlooding ||
                  current is CheckoutError,
              builder: (context, state) {
                if (state is Checkoutlooding) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (state is CheckoutError) {
                  return Center(child: Text(state.Message));
                }
                if (state is Checkoutlooded) {
                  final cartItems = state.cartitems;
                  final chosenPaymentCard = state.ChosenPaymentCard;
                  final chosenLocation = state.chosenlocation;

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .03),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckoutHeadlinesItems(
                            title: 'Address',
                            ontap: () {
                              Navigator.of(context)
                                  .pushNamed(AppRouts.ChosenaddressRoute)
                                  .then((_) => cubit.getcartitems());
                            },
                          ),
                          _buildLocationItem(chosenLocation, context),
                          SizedBox(height: size.height * .02),
                          CheckoutHeadlinesItems(
                            title: 'Products',
                            numofproducts: state.numsofproducts,
                            ontap: () {},
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: cartItems.length,
                            separatorBuilder: (context, index) => Divider(
                              color: Theme.of(context).dividerColor,
                            ),
                            itemBuilder: (context, index) {
                              final cartItem = cartItems[index];
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Appcolors.grey2,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: cartItem.Product.imgurl,
                                      height: size.height * .13,
                                      width: size.width * .3,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: size.width * .03),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartItem.Product.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        SizedBox(height: size.height * .01),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                text: 'Size: ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                    ),
                                                children: [
                                                  TextSpan(
                                                    text: cartItem.size.name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              '\$${cartItem.totalprice.toStringAsFixed(1)}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: size.height * .02),
                          CheckoutHeadlinesItems(title: 'Payment'),
                          _buildPaymentMethodItem(chosenPaymentCard, context),
                          Divider(color: Appcolors.grey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Amount',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                '\$${state.totalamount}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * .02),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text('Proceed to Buy'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const Center(child: Text('Something went wrong'));
              },
            );
          },
        ),
      ),
    );
  }
}
