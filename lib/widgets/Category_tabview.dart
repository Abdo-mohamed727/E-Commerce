import 'package:ecommerce_new/view_models/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTabview extends StatelessWidget {
  const CategoryTabview({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return Builder(builder: (context) {
      return BlocBuilder<HomeCubit, HomeState>(
          bloc: cubit,
          buildWhen: (previous, current) =>
              current is Homeloaded ||
              current is Homeloading ||
              current is HomeError,
          builder: (context, state) {
            if (state is HomeError) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is Homeloaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final category = state.categoryitems[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: category.bgColor ??
                            Theme.of(context).colorScheme.surface,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 32),
                        child: Column(
                          children: [
                            Text(
                              category.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: category.textColor ??
                                        Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              '${category.productsCount.toString()} product',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: category.textColor ??
                                        Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: state.categoryitems.length,
              );
            } else {
              return const SizedBox();
            }
          });
    });
  }
}
