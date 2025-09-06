import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_new/models/location_item_model.dart';
import 'package:flutter/material.dart';

class LocationItemWidget extends StatelessWidget {
  final VoidCallback ontap;
  final Color? bordercolor;
  final LocationItemModel location;

  const LocationItemWidget({
    super.key,
    required this.ontap,
    this.bordercolor,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: ontap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: bordercolor ?? colors.outline,
          ),
          borderRadius: BorderRadius.circular(16),
          color: colors.surface, // ✅ علشان يندمج مع الثيم
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ✅ النصوص
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.city,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${location.city}, ${location.country}",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),

              // ✅ الصورة الدائرية مع Placeholder
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: bordercolor ?? colors.outlineVariant,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: colors.surfaceVariant,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: location.imgUrl,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colors.primary,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.broken_image,
                          color: colors.error,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
