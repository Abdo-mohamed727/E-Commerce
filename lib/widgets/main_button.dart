import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class MainButton extends StatelessWidget {
  final double height;
  final String? title;
  final VoidCallback? ontap;
  final Color Backgroundcolor;
  final Color Forgroundcolor;
  final bool islooding;
  MainButton({
    super.key,
    this.height = 60,
    this.Backgroundcolor = Appcolors.primary,
    this.Forgroundcolor = Appcolors.white,
    this.ontap,
    this.title,
    this.islooding = false,
  }) {
    assert(title != null || islooding == true);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: ontap,
        child: islooding
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Text(title!),
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolors.blue,
          foregroundColor: Forgroundcolor,
        ),
      ),
    );
  }
}
