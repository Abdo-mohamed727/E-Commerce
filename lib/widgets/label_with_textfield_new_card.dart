import 'package:flutter/material.dart';

class LabelWithTextfield extends StatefulWidget {
  final String label;
  final TextEditingController controler;
  final IconData prefixicon;
  final String hinttext;
  final Widget? suffixicon;
  final bool obscureText;

  const LabelWithTextfield({
    super.key,
    required this.label,
    required this.controler,
    required this.prefixicon,
    required this.hinttext,
    this.suffixicon,
    this.obscureText = false,
  });

  @override
  State<LabelWithTextfield> createState() => _LabelWithTextfieldState();
}

class _LabelWithTextfieldState extends State<LabelWithTextfield> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: theme.textTheme.titleMedium!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        TextFormField(
          obscureText: widget.obscureText,
          validator: (value) => value == null || value.isEmpty
              ? '${widget.label} cannot be empty'
              : null,
          controller: widget.controler,
          decoration: InputDecoration(
            suffixIcon: widget.suffixicon,
            prefixIcon: Icon(widget.prefixicon,
                color: theme.colorScheme.onSurfaceVariant),
            fillColor: theme.colorScheme.surfaceVariant, // بدل grey2
            filled: true,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: theme.colorScheme.error), // بدل red
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            hintText: widget.hinttext,
            hintStyle: theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
