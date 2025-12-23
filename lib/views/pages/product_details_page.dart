import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_new/models/peoduct_item_model.dart';
import 'package:ecommerce_new/utils/app_colors.dart';
import 'package:ecommerce_new/cubit/favourite_cubit/favourite_cubit.dart';
import 'package:ecommerce_new/cubit/home_cubit/home_cubit.dart';
import 'package:ecommerce_new/cubit/product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_new/widgets/Counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProductDetailsCubit>(context);
    final homecubit = BlocProvider.of<HomeCubit>(context);
    final favouritecubit = BlocProvider.of<FavouriteCubit>(context);
    final Size = MediaQuery.of(context).size;
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is ProductDetailsLooded ||
          current is productDetailsLooding ||
          current is ProductDetailsError,
      builder: (context, state) {
        if (state is productDetailsLooding) {
          return CircularProgressIndicator.adaptive();
        } else if (state is ProductDetailsError) {
          return Scaffold(
            body: Center(
              child: Text(state.message),
            ),
          );
        } else if (state is ProductDetailsLooded) {
          final Product = state.product;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Center(
                child: const Text(
                  'Produt details',
                ),
              ),
              actions: [
                BlocConsumer<HomeCubit, HomeState>(
                    listener: (context, state) {
                      if (state is setfavouritesuccess) {
                        favouritecubit.getFavouriteProduct();
                      }
                    },
                    bloc: homecubit,
                    buildWhen: (previous, current) =>
                        (current is setfavouritesuccess &&
                            current.ProductId == productId) ||
                        (current is setfavouritefailure &&
                            current.ProductId == productId) ||
                        (current is setfavouritelooding &&
                            current.ProductId == productId) ||
                        current is FavouriteRemoved,
                    builder: (context, state) {
                      if (state is setfavouritelooding) {
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (state is setfavouritesuccess) {
                        return state.isfavourite
                            ? InkWell(
                                onTap: () async =>
                                    await homecubit.setfavourite(Product),
                                child: Icon(
                                  Icons.favorite,
                                  color: Appcolors.red,
                                ),
                              )
                            : InkWell(
                                onTap: () async =>
                                    await homecubit.setfavourite(Product),
                                child: Icon(
                                  Icons.favorite_outline,
                                ),
                              );
                      } else if (state is FavouriteRemoved) {
                        return InkWell(
                          onTap: () async => null,
                          child: Icon(
                            Icons.favorite_outline,
                          ),
                        );
                      }
                      return InkWell(
                        onTap: () async =>
                            await homecubit.setfavourite(Product),
                        child: Product.isFavorite
                            ? Icon(
                                Icons.favorite,
                                color: Appcolors.red,
                              )
                            : Icon(
                                Icons.favorite_border,
                              ),
                      );
                    })
              ],
            ),
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Appcolors.grey2,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      CachedNetworkImage(imageUrl: Product.imgurl),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Size.height * .47),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Appcolors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Product.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Appcolors.yellow,
                                      ),
                                      Text(
                                        Product.averageRate.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              BlocBuilder<ProductDetailsCubit,
                                  ProductDetailsState>(
                                bloc: cubit,
                                buildWhen: (previous, current) =>
                                    current is QuantityCounterlooded ||
                                    current is ProductDetailsLooded,
                                builder: (context, state) {
                                  if (state is QuantityCounterlooded) {
                                    return CounterWidget(
                                      value: state.value,
                                      ProductId: Product.id,
                                      cubit: cubit,
                                    );
                                  } else if (state is ProductDetailsLooded) {
                                    return CounterWidget(
                                      value: 1,
                                      ProductId: Product.id,
                                      cubit: cubit,
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Size',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                            bloc: cubit,
                            buildWhen: (previous, current) =>
                                current is sizeselected ||
                                current is ProductDetailsLooded,
                            builder: (context, state) {
                              return Row(
                                children: ProductSize.values
                                    .map(
                                      (size) => Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4.0, right: 8),
                                        child: InkWell(
                                          onTap: () {
                                            cubit.SelectedSize(size);
                                          },
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: state is sizeselected &&
                                                      state.size == size
                                                  ? Appcolors.primary
                                                  : Appcolors.grey2,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                size.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge!
                                                    .copyWith(
                                                      color:
                                                          state is sizeselected &&
                                                                  state.size ==
                                                                      size
                                                              ? Appcolors.white
                                                              : Appcolors.black,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            Product.description,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: Appcolors.grey),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$ ${Product.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              BlocBuilder<ProductDetailsCubit,
                                  ProductDetailsState>(
                                bloc: cubit,
                                buildWhen: (previous, current) =>
                                    current is ProductAddedTocart ||
                                    current is ProductAddingtoCart,
                                builder: (context, state) {
                                  if (state is ProductAddingtoCart) {
                                    return ElevatedButton(
                                      onPressed: null,
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Appcolors.primary,
                                          foregroundColor: Appcolors.white),
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    );
                                  } else if (state is ProductAddedTocart) {
                                    return ElevatedButton(
                                      onPressed: null,
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Appcolors.primary,
                                          foregroundColor: Appcolors.white),
                                      child: Text('Added To Cart'),
                                    );
                                  } else {
                                    return ElevatedButton.icon(
                                      onPressed: () {
                                        if (cubit.selectedsize != null) {
                                          cubit.AddToCart(productId);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text('please Select Size'),
                                          ));
                                        }
                                      },
                                      label: Text('Add to Cart'),
                                      icon: Icon(
                                        Icons.shopping_bag_outlined,
                                        color: Appcolors.white,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Appcolors.primary,
                                          foregroundColor: Appcolors.white),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text('Something was error'),
            ),
          );
        }
      },
    );
  }
}
