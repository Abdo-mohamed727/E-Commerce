import 'package:ecommerce_new/utils/app_routes.dart';
import 'package:ecommerce_new/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_new/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final size = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      final cubit = BlocProvider.of<CartCubit>(context);
      return BlocBuilder<CartCubit, CartState>(
        buildWhen: (previous, current) =>
            current is Cartlooding ||
            current is CartLooded ||
            current is CartError,
        bloc: cubit,
        builder: (context, state) {
          if (state is Cartlooding) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          } else if (state is CartLooded) {
            final cartitems = state.CartItem;

            if (cartitems.isEmpty) {
              return Scaffold(
                body: Center(
                  child: Text(
                    'No items in your Cart',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
              );
            }

            return Scaffold(
              body: RefreshIndicator(
                onRefresh: () async => await cubit.AddToCart(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartitems.length,
                        itemBuilder: (context, index) {
                          return CartItemWidget(cartItem: cartitems[index]);
                        },
                        separatorBuilder: (context, index) => Divider(
                          color: theme.dividerColor,
                        ),
                      ),
                      Divider(color: theme.dividerColor),
                      BlocBuilder<CartCubit, CartState>(
                        bloc: cubit,
                        buildWhen: (previous, current) =>
                            current is Updatedsubtotal,
                        builder: (context, subtotalstate) {
                          double subtotal = state.subtotal;
                          if (subtotalstate is Updatedsubtotal) {
                            subtotal = subtotalstate.subtotal;
                          }
                          return Column(
                            children: [
                              _totalAndSubtotalWidget(
                                context,
                                title: 'Subtotal',
                                amount: subtotal,
                              ),
                              _totalAndSubtotalWidget(
                                context,
                                title: 'Shipping',
                                amount: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * .02),
                                child: Dash(
                                  dashColor: theme.dividerColor,
                                  length: size.width * 0.8,
                                ),
                              ),
                              _totalAndSubtotalWidget(
                                context,
                                title: 'Total Amount',
                                amount: subtotal + 10,
                                isBold: true,
                              ),
                            ],
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.primary,
                              foregroundColor: colors.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(AppRouts.Checkoutroute);
                            },
                            child: const Text('Checkout'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is CartError) {
            return Scaffold(
              body: Center(
                child: Text(
                  state.Message,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colors.error,
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Text(
                  'Something went wrong',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colors.error,
                  ),
                ),
              ),
            );
          }
        },
      );
    });
  }

  /// ✅ Widget for Subtotal / Total
  Widget _totalAndSubtotalWidget(
    BuildContext context, {
    required String title,
    required double amount,
    bool isBold = false,
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: isBold
                ? theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  )
                : theme.textTheme.titleMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
          ),
          Text(
            '\$ ${amount.toStringAsFixed(2)}',
            style: isBold
                ? theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  )
                : theme.textTheme.labelLarge?.copyWith(
                    color: colors.onSurface,
                  ),
          ),
        ],
      ),
    );
  }
}
