import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_new/models/Add_payment_method.dart';
import 'package:ecommerce_new/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PaymentMethodItem extends StatelessWidget {
  final PaymentCardModel PaymentCard;
  final VoidCallback onTapped;
  const PaymentMethodItem(
      {super.key, required this.PaymentCard, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapped,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Appcolors.grey),
        ),
        child: ListTile(
          leading: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Appcolors.grey2,
            ),
            child: CachedNetworkImage(
                height: 50,
                width: 50,
                imageUrl:
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/MasterCard_Logo.svg/1200px-MasterCard_Logo.svg.png'),
          ),
          title: Text('Master Card'),
          subtitle: Text(PaymentCard.cardNumber),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
