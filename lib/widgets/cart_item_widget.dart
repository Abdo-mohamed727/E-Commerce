import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_new/models/add_tocart_model.dart';
import 'package:ecommerce_new/utils/app_colors.dart';
import 'package:ecommerce_new/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_new/widgets/Counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemWidget extends StatelessWidget {
  final AddToCartModel cartItem;
  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CartCubit>(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * .02, vertical: size.height * .01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: cartItem.Product.imgurl,
              height: size.height * .15,
              width: size.width * .3,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 100,
                width: 100,
                color: Appcolors.grey,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                height: 100,
                width: 100,
                color: Appcolors.grey,
                child: Icon(Icons.broken_image, color: colors.error),
              ),
            ),
          ),
          SizedBox(width: size.width * .02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product name
                Text(
                  cartItem.Product.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Appcolors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: size.height * .02),

                Text.rich(
                  TextSpan(
                    text: 'Size: ',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                    children: [
                      TextSpan(
                        text: cartItem.size.name,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: colors.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * .01),

                // ✅ Quantity + Price
                BlocBuilder<CartCubit, CartState>(
                  buildWhen: (previous, current) =>
                      current is QuantityCounterlooded &&
                      current.ProductId == cartItem.Product.id,
                  bloc: cubit,
                  builder: (context, state) {
                    final price = state is QuantityCounterlooded
                        ? state.value * cartItem.Product.price
                        : cartItem.totalprice;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CounterWidget(
                          value: cartItem.quantity,
                          cartItem: cartItem,
                          cubit: cubit,
                          initialvaue: cartItem.quantity,
                        ),
                        Text(
                          '\$${price.toStringAsFixed(2)}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.primary,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
