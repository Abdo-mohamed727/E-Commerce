import 'package:ecommerce_new/utils/app_router.dart';
import 'package:ecommerce_new/utils/app_routes.dart';
import 'package:ecommerce_new/utils/app_theme.dart';
import 'package:ecommerce_new/cubit/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_new/cubit/favourite_cubit/favourite_cubit.dart';
import 'package:ecommerce_new/cubit/home_cubit/home_cubit.dart';
import 'package:ecommerce_new/cubit/theme_cubit/theme_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = AuthCubit();
            cubit.Checkauth();
            return cubit;
          },
        ),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(
          create: (context) {
            final cubit = FavouriteCubit();
            cubit.getFavouriteProduct();
            return cubit;
          },
        ),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: Builder(
        builder: (context) {
          final cubit = BlocProvider.of<AuthCubit>(context);
          final themecubit = BlocProvider.of<ThemeCubit>(context);
          return BlocBuilder<ThemeCubit, ThemeState>(
            bloc: themecubit,
            builder: (context, themestate) {
              return BlocBuilder<AuthCubit, AuthState>(
                bloc: cubit,
                buildWhen: (previous, current) =>
                    current is AuthDone || current is AuthInitial,
                builder: (context, state) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'E-Commerce',
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                    themeMode: themestate is ThemeModeChanges
                        ? themestate.themeMode
                        : ThemeMode.system,
                    initialRoute: state is AuthDone
                        ? AppRouts.homeroute
                        : AppRouts.Loginroute,
                    onGenerateRoute: AppRouter.OnGenerateRoute,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
