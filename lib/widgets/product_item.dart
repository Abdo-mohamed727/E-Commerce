import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_new/models/peoduct_item_model.dart';
import 'package:ecommerce_new/utils/app_colors.dart';
import 'package:ecommerce_new/view_models/favourite_cubit/favourite_cubit.dart';
import 'package:ecommerce_new/view_models/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel prodectitem;
  const ProductItem({super.key, required this.prodectitem});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: size.height * .15,
              width: size.width * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: theme.colorScheme.surfaceVariant,
              ),
              child: CachedNetworkImage(
                imageUrl: prodectitem.imgurl,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator.adaptive()),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: theme.colorScheme.error),
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: DecoratedBox(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: BlocBuilder<HomeCubit, HomeState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      (current is setfavouritesuccess &&
                          current.ProductId == prodectitem.id) ||
                      (current is setfavouritefailure &&
                          current.ProductId == prodectitem.id) ||
                      (current is setfavouritelooding &&
                          current.ProductId == prodectitem.id) ||
                      current is FavouriteRemoved,
                  builder: (context, state) {
                    if (state is setfavouritelooding) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (state is setfavouritesuccess) {
                      return InkWell(
                        onTap: () async =>
                            await cubit.setfavourite(prodectitem),
                        child: Icon(
                          state.isfavourite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: state.isfavourite
                              ? theme.colorScheme.error
                              : theme.iconTheme.color,
                        ),
                      );
                    } else if (state is FavouriteRemoved) {
                      return InkWell(
                        onTap: () => null,
                        child: Icon(Icons.favorite_outline,
                            color: theme.iconTheme.color),
                      );
                    }
                    return InkWell(
                      onTap: () async => await cubit.setfavourite(prodectitem),
                      child: Icon(
                        prodectitem.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: prodectitem.isFavorite
                            ? theme.colorScheme.error
                            : theme.iconTheme.color,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.02),
        Expanded(
          child: Column(
            children: [
              Text(
                prodectitem.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium,
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * .1),
                child: Row(
                  children: [
                    Text(
                      prodectitem.category,
                      style: theme.textTheme.labelMedium!
                          .copyWith(color: theme.hintColor),
                    ),
                    SizedBox(width: size.width * .08),
                    Text(
                      prodectitem.averageRate.toString(),
                      style: theme.textTheme.labelLarge!
                          .copyWith(color: theme.colorScheme.primary),
                    ),
                    Icon(
                      Icons.star,
                      color: theme.colorScheme.secondary,
                      size: 15,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  '\$${prodectitem.price}',
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
