import 'package:ecommerce_new/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CheckoutHeadlinesItems extends StatelessWidget {
  final String title;
  final int? numofproducts;
  final VoidCallback? ontap;

  const CheckoutHeadlinesItems({
    super.key,
    required this.title,
    this.numofproducts,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * .01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium,
              ),
              if (numofproducts != null)
                Padding(
                  padding: EdgeInsets.only(left: size.width * .01),
                  child: Text(
                    '($numofproducts)',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: Appcolors.grey,
                    ),
                  ),
                ),
            ],
          ),
          if (ontap != null)
            TextButton(
              onPressed: ontap,
              child: Text(
                'Edit',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Appcolors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
