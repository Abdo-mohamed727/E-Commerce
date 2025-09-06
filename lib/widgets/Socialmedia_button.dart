import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SocialmediaButton extends StatelessWidget {
  final String? text;
  final String? imgurl;
  final VoidCallback? ontap;
  final bool islooding;

  const SocialmediaButton({
    super.key,
    this.text,
    this.imgurl,
    this.ontap,
    this.islooding = false,
  }) : assert((text != null && imgurl != null) || islooding == true);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: ontap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.colorScheme.outline, // بدل Appcolors.grey2
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: islooding
              ? const CircularProgressIndicator.adaptive()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: imgurl!,
                      height: 50,
                      width: 50,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      text!,
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
