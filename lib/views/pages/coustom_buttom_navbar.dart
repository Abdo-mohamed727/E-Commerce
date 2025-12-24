import 'package:ecommerce_new/utils/app_colors.dart';
import 'package:ecommerce_new/utils/app_routes.dart';
import 'package:ecommerce_new/cubit/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_new/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_new/cubit/favourite_cubit/favourite_cubit.dart';
import 'package:ecommerce_new/cubit/home_cubit/home_cubit.dart';
import 'package:ecommerce_new/views/pages/cart_page.dart';
import 'package:ecommerce_new/views/pages/favourite_page.dart';
import 'package:ecommerce_new/views/pages/home_page.dart';
import 'package:ecommerce_new/views/pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CoustomButtomNavbar extends StatefulWidget {
  const CoustomButtomNavbar({
    super.key,
  });

  @override
  State<CoustomButtomNavbar> createState() => _CoustomButtomNavbarState();
}

class _CoustomButtomNavbarState extends State<CoustomButtomNavbar> {
  late final PersistentTabController _controller;
  int currentindex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
  }

  List<Widget> _buildScreens() {
    return [
      BlocProvider(
        create: (context) {
          final Cubit = HomeCubit();
          Cubit.getproducts();
          return Cubit;
        },
        child: HomePage(),
      ),
      BlocProvider(
        create: (context) {
          final cubit = CartCubit();
          cubit.AddToCart();
          return cubit;
        },
        child: CartPage(),
      ),
      FavouritePage(),
      ProfilePage(),
    ];
  }

  List<ItemConfig> _navBarsItems() {
    return [
      ItemConfig(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeForegroundColor: Appcolors.primary,
        inactiveForegroundColor: Appcolors.grey,
      ),
      ItemConfig(
        icon: Icon(CupertinoIcons.cart),
        title: ("Cart"),
        activeForegroundColor: Appcolors.primary,
        inactiveForegroundColor: Appcolors.grey,
      ),
      ItemConfig(
        icon: Icon(CupertinoIcons.heart),
        title: ("Favourite"),
        activeForegroundColor: Appcolors.primary,
        inactiveForegroundColor: Appcolors.grey,
      ),
      ItemConfig(
        icon: Icon(CupertinoIcons.person),
        title: ("Profile"),
        activeForegroundColor: Appcolors.primary,
        inactiveForegroundColor: Appcolors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      appBar: (currentindex == 3)
          ? null
          : AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Abdo Mhmd',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text('let\'s go shopping',
                      style: Theme.of(context).textTheme.bodySmall!),
                ],
              ),
              actions: [
                if (currentindex == 0) ...[
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRouts.Search);
                    },
                    icon: Icon(Icons.search),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications),
                  ),
                ] else if (currentindex == 1) ...[
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.shopping_bag_outlined))
                ]
              ],
            ),
      body: BlocConsumer<AuthCubit, AuthState>(
          bloc: cubit,
          listenWhen: (previous, current) => current is AuthLogedout,
          listener: (context, state) {
            if (state is AuthLogedout) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouts.Loginroute, (route) => false);
            }
          },
          buildWhen: (previous, current) =>
              current is AuthLogedout || current is AuthLogingout,
          builder: (context, state) {
            if (state is AuthLogingout) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return PersistentTabView(
              controller: _controller,
              tabs: [
                PersistentTabConfig(
                  screen: _buildScreens()[0],
                  item: _navBarsItems()[0],
                ),
                PersistentTabConfig(
                  screen: _buildScreens()[1],
                  item: _navBarsItems()[1],
                ),
                PersistentTabConfig(
                  screen: _buildScreens()[2],
                  item: _navBarsItems()[2],
                ),
                PersistentTabConfig(
                  screen: _buildScreens()[3],
                  item: _navBarsItems()[3],
                )
              ],
              navBarBuilder: (navbarconfig) =>
                  Style6BottomNavBar(navBarConfig: navbarconfig),
              onTabChanged: (index) {
                setState(() {
                  currentindex = index;
                });
                // Reload favourites when switching to favourite tab (index 2)
                if (index == 2) {
                  final favouriteCubit =
                      BlocProvider.of<FavouriteCubit>(context);
                  favouriteCubit.getFavouriteProduct();
                }
              },

              backgroundColor: Appcolors.white,
              // Default is Colors.white.
              handleAndroidBackButtonPress: true,
              // Default is true.
              resizeToAvoidBottomInset: true,
              // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
              stateManagement: true,
              // Default is true.

              screenTransitionAnimation: ScreenTransitionAnimation(
                  // Screen transition animation on change of selected tab.
                  // Choose the nav bar style with this property.
                  ),
            );
          }),
    );
  }
}
