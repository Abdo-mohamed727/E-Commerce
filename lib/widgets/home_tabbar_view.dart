import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_new/models/peoduct_item_model.dart';

import 'package:ecommerce_new/cubit/home_cubit/home_cubit.dart';
import 'package:ecommerce_new/cubit/product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_new/views/pages/product_details_page.dart';
import 'package:ecommerce_new/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class HomeTabview extends StatelessWidget {
  const HomeTabview({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    final size = MediaQuery.of(context).size;

    return BlocBuilder<HomeCubit, HomeState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is Homeloaded ||
          current is Homeloading ||
          current is HomeError,
      builder: (context, state) {
        if (state is Homeloading) {
          return const Center(
            child: Center(child: CircularProgressIndicator.adaptive()),
          );
        } else if (state is Homeloaded) {
          return RefreshIndicator(
            onRefresh: () async => await cubit.getproducts(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FlutterCarousel.builder(
                    itemCount: state.carouselItem.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Padding(
                      padding:
                          EdgeInsetsDirectional.only(end: size.height * .01),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: state.carouselItem[itemIndex].imgUrl,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator.adaptive(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    options: FlutterCarouselOptions(
                      height: size.height * .2,
                      autoPlay: true,
                      showIndicator: true,
                      slideIndicator: CircularWaveSlideIndicator(),
                    ),
                  ),
                  SizedBox(height: size.height * .02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'New Arrivals',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          "See all",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * .02),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.productItem.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 25,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final product = state.productItem[index];
                      return InkWell(
                        onTap: () => pushScreen(
                          context,
                          screen: BlocProvider(
                            create: (_) {
                              final cubit = ProductDetailsCubit();
                              cubit.GetproductDetails(product.id);
                              return cubit;
                            },
                            child: ProductDetailsPage(productId: product.id),
                          ),
                          withNavBar: false,
                        ),
                        child: ProductItem(
                          prodectitem: product,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else if (state is HomeError) {
          return Center(
            child: Text(
              state.Message,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
