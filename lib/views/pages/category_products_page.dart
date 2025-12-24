import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_new/cubit/favourite_cubit/favourite_cubit.dart';
import 'package:ecommerce_new/cubit/home_cubit/home_cubit.dart';
import 'package:ecommerce_new/cubit/product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_new/utils/app_colors.dart';

import 'package:ecommerce_new/views/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CategoryProductsPage extends StatelessWidget {
  const CategoryProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homecubit = context.read<HomeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Products'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            current is getproductsbycategoryloading ||
            current is getproductsbycategorysuccess ||
            current is getproductsbycategoryfailure,
        builder: (context, state) {
          if (state is getproductsbycategoryloading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is getproductsbycategorysuccess) {
            final products = state.productItem;
            return GridView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final category = products[index];
                return InkWell(
                  onTap: () {
                    pushScreen(
                      context,
                      screen: BlocProvider(
                        create: (_) {
                          final cubit = ProductDetailsCubit();
                          cubit.GetproductDetails(category.id);
                          return cubit;
                        },
                        child: ProductDetailsPage(productId: category.id),
                      ),
                      withNavBar: false,
                    );
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade100),
                      color: Colors.grey.shade100,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: CachedNetworkImage(
                                imageUrl: category.imgurl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${category.price} \$',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Appcolors.primary,
                                  ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: BlocConsumer<HomeCubit, HomeState>(
                              listener: (context, state) {
                                if (state is setfavouritesuccess) {
                                  homecubit.getproducts();
                                }
                              },
                              bloc: homecubit,
                              buildWhen: (previous, current) =>
                                  (current is setfavouritesuccess &&
                                      current.ProductId == category.id) ||
                                  (current is setfavouritefailure &&
                                      current.ProductId == category.id) ||
                                  (current is setfavouritelooding &&
                                      current.ProductId == category.id) ||
                                  current is FavouriteRemoved,
                              builder: (context, state) {
                                if (state is setfavouritelooding) {
                                  return const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator.adaptive(
                                      strokeWidth: 2,
                                    ),
                                  );
                                } else if (state is setfavouritesuccess) {
                                  return state.isfavourite
                                      ? InkWell(
                                          onTap: () async => await homecubit
                                              .setfavourite(category),
                                          child: Icon(
                                            Icons.favorite,
                                            color: Appcolors.red,
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () async => await homecubit
                                              .setfavourite(category),
                                          child: const Icon(
                                            Icons.favorite_outline,
                                          ),
                                        );
                                } else if (state is FavouriteRemoved) {
                                  return InkWell(
                                    onTap: () async => null,
                                    child: const Icon(
                                      Icons.favorite_outline,
                                    ),
                                  );
                                }
                                return InkWell(
                                  onTap: () async =>
                                      await homecubit.setfavourite(category),
                                  child: category.isFavorite
                                      ? Icon(
                                          Icons.favorite,
                                          color: Appcolors.red,
                                        )
                                      : const Icon(
                                          Icons.favorite_border,
                                        ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
            );
          } else if (state is getproductsbycategoryfailure) {
            return Center(
              child: Text(state.message),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
