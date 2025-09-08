import 'package:ecommerce_new/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Properitesofprofilepage extends StatelessWidget {
  final IconData preicon;
  final IconData sufexicon;
  final String title;
  final VoidCallback ontap;
  const Properitesofprofilepage(
      {super.key,
      required this.preicon,
      required this.sufexicon,
      required this.title,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: ontap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          // color: Appcolors.grey2,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Appcolors.grey2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(preicon),
                  SizedBox(
                    width: size.width * .03,
                  ),
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Icon(
                sufexicon,
                size: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
