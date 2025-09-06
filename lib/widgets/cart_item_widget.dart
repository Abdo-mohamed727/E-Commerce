import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_new/models/add_tocart_model.dart';
import 'package:ecommerce_new/view_models/cart_cubit/cart_cubit.dart';
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Product Image Box
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: cartItem.Product.imgurl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 100,
                width: 100,
                color: colors.surfaceVariant.withOpacity(0.2),
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                height: 100,
                width: 100,
                color: colors.error.withOpacity(0.2),
                child: Icon(Icons.broken_image, color: colors.error),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // ✅ Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product name
                Text(
                  cartItem.Product.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.onBackground,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                // Product size
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

                const SizedBox(height: 12),

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
