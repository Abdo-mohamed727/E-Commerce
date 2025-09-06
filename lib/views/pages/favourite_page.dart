import 'package:ecommerce_new/utils/app_colors.dart';
import 'package:ecommerce_new/view_models/favourite_cubit/favourite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final favoritecubit = BlocProvider.of<FavouriteCubit>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: BlocBuilder<FavouriteCubit, FavouriteState>(
        bloc: favoritecubit,
        buildWhen: (previous, current) =>
            current is FavouriteLooded || current is FavouriteError,
        builder: (context, state) {
          if (state is FavouriteError) {
            return Center(
              child: Text(
                'Failed to load favourites: ${state.errormessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is FavouriteLooded) {
            final favouriteproducts = state.favouriteproduct;
            if (favouriteproducts.isEmpty) {
              return const Center(
                child: Text('No Favourite Items'),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                await favoritecubit.Getfavouriteproduct();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 16,
                  ),
                  itemCount: favouriteproducts.length,
                  itemBuilder: (context, index) {
                    final product = favouriteproducts[index];
                    return DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Appcolors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(product.imgurl),
                            radius: 30,
                          ),
                          title: Text(product.name),
                          trailing:
                              BlocConsumer<FavouriteCubit, FavouriteState>(
                            bloc: favoritecubit,
                            listenWhen: (previous, current) =>
                                current is FavouriteremoveError,
                            listener: (context, state) {
                              if (state is FavouriteremoveError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.error)),
                                );
                              }
                            },
                            buildWhen: (previous, current) =>
                                (current is FavouriteremoveError &&
                                    current.ProductId == product.id) ||
                                (current is FavouriteRemoved &&
                                    current.productId == product.id) ||
                                (current is Removingfavourite &&
                                    current.productId == product.id),
                            builder: (context, state) {
                              if (state is Removingfavourite) {
                                return const CircularProgressIndicator
                                    .adaptive();
                              }
                              return IconButton(
                                onPressed: () async {
                                  await favoritecubit
                                      .removefavourite(product.id);
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Appcolors.red,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
