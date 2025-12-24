import 'package:ecommerce_new/cubit/AddNewCard_cubit/Paymentmethod_cubit.dart';
import 'package:ecommerce_new/cubit/home_cubit/home_cubit.dart';
import 'package:ecommerce_new/cubit/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_new/cubit/chosen_location/chosen_location_cubit.dart';
import 'package:ecommerce_new/cubit/product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_new/cubit/search_cubit/search_cubit.dart';
import 'package:ecommerce_new/views/pages/Add_new_card_page.dart';
import 'package:ecommerce_new/views/pages/Checkout_page.dart';
import 'package:ecommerce_new/views/pages/Register_page.dart';
import 'package:ecommerce_new/views/pages/category_products_page.dart';
import 'package:ecommerce_new/views/pages/chosen_address.dart';
import 'package:ecommerce_new/views/pages/coustom_buttom_navbar.dart';
import 'package:ecommerce_new/views/pages/login_page.dart';
import 'package:ecommerce_new/views/pages/product_details_page.dart';
import 'package:ecommerce_new/views/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_new/utils/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> OnGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouts.homeroute:
        return MaterialPageRoute(
          builder: (_) => const CoustomButtomNavbar(),
          settings: settings,
        );
      case AppRouts.Search:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SearchCubit(),
            child: SearchPage(),
          ),
          settings: settings,
        );
      case AppRouts.Checkoutroute:
        return MaterialPageRoute(
          builder: (_) => const CheckoutPage(),
          settings: settings,
        );
      case AppRouts.Loginroute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: LoginPage(),
          ),
          settings: settings,
        );
      case AppRouts.Registerroute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: RegisterPage(),
          ),
          settings: settings,
        );

      case AppRouts.AddNewCardRoute:
        final paymentcubit = settings.arguments as PaymentmethodCubit;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: paymentcubit,
            child: AddNewCardPage(),
          ),
          settings: settings,
        );
      case AppRouts.ChosenaddressRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = ChosenLocationCubit();
              cubit.fetchlocation();
              return cubit;
            },
            child: ChosenAddressPage(),
          ),
          settings: settings,
        );

      case AppRouts.ProductDetailsroute:
        final String productId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) {
              final cubit = ProductDetailsCubit();
              cubit.GetproductDetails(productId);

              return cubit;
            },
            child: ProductDetailsPage(productId: productId),
          ),
          settings: settings,
        );
      case AppRouts.CategoryProductsRoute:
        final cubit = settings.arguments as HomeCubit;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: cubit,
            child: CategoryProductsPage(),
          ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'no route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}
