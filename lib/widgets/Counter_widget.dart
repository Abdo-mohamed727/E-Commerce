import 'package:ecommerce_new/models/add_tocart_model.dart';
import 'package:ecommerce_new/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final dynamic cubit;
  final String? ProductId;
  final int value;
  final int? initialvaue;
  final AddToCartModel? cartItem;
  const CounterWidget({
    super.key,
    required this.value,
    required this.cubit,
    this.ProductId,
    this.cartItem,
    this.initialvaue,
  }) : assert(ProductId != null || cartItem != null);

  Future<void> decrementcounter(dynamic param) async {
    if (initialvaue != null) {
      await cubit.DecrementCounter(param, initialvaue);
    } else {
      await cubit.DecrementCounter(param);
    }
  }

  Future<void> incrementcounter(dynamic param) async {
    if (initialvaue != null) {
      await cubit.IncrementCounter(param, initialvaue);
    } else {
      await cubit.IncrementCounter(param);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * .01, vertical: size.height * .01),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Appcolors.grey2,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () => cartItem != null
                  ? decrementcounter(cartItem)
                  : decrementcounter(ProductId),
              icon: const Icon(Icons.remove),
              color: Theme.of(context).colorScheme.onSurface, // لون الأيقونة
            ),
            Text(
              value.toString(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface, // لون النص
                  ),
            ),
            IconButton(
              onPressed: () => cartItem != null
                  ? incrementcounter(cartItem)
                  : incrementcounter(ProductId),
              icon: const Icon(Icons.add),
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}
