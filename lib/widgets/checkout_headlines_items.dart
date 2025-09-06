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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    '($numofproducts)',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
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
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
