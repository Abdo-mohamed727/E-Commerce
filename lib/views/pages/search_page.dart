import 'package:ecommerce_new/utils/app_colors.dart';
import 'package:ecommerce_new/utils/app_routes.dart';
import 'package:ecommerce_new/view_models/search_cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bool issearshing = false;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SearchCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            cubit.Search(value);
          },
          decoration: InputDecoration(
              hintText: 'Search',
              suffixIcon: InkWell(
                child: Icon(Icons.clear),
                onTap: () {
                  cubit.Search("");
                },
              )),
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
          bloc: cubit,
          buildWhen: (previous, current) =>
              current is SearchFailed ||
              current is SearchLooded ||
              current is SearchLoooding,
          builder: (context, state) {
            if (state is SearchLoooding) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is SearchLooded) {
              final product = state.product;
              if (product.isEmpty) {
                return Center(child: Text('no result found'));
              }
              return ListView.builder(
                  itemCount: product.length,
                  itemBuilder: (_, index) {
                    final products = product[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            border: Border.all(color: Appcolors.grey),
                            borderRadius: BorderRadius.circular(16)),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                AppRouts.ProductDetailsroute,
                                arguments: products.id);
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(products.imgurl),
                          ),
                          title: Text(
                            products.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          subtitle: Text(
                            products.price.toString(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    );
                  });
            } else if (state is SearchFailed) {
              return Center(
                child: Text('something error'),
              );
            } else {
              return SizedBox();
            }
          }),
    );
  }
}
