import 'package:ecommerce_new/utils/app_routes.dart';
import 'package:ecommerce_new/cubit/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_new/widgets/main_button.dart';
import 'package:ecommerce_new/widgets/properitesofprofilepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/theme_cubit/theme_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AuthCubit>(context);
    final themecubit = BlocProvider.of<ThemeCubit>(context);
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.only(
            top: size.height * .02,
            right: size.width * .01,
            left: size.width * .01),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              Text(
                'Abdo Mhmd',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: size.height * .02,
              ),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Properitesofprofilepage(
                    sufexicon: Icons.chevron_right,
                    preicon: Icons.edit,
                    title: 'EditProfile',
                    ontap: () {},
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Properitesofprofilepage(
                      sufexicon: Icons.chevron_right,
                      preicon: Icons.notifications,
                      title: 'Notifications',
                      ontap: () {}),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, themeState) {
                      final currentTheme = themecubit.currentThemeMode;
                      String themeLabel;
                      switch (currentTheme) {
                        case ThemeModeState.light:
                          themeLabel = 'Light';
                          break;
                        case ThemeModeState.dark:
                          themeLabel = 'Dark';
                          break;
                        case ThemeModeState.system:
                          themeLabel = 'System';
                          break;
                      }

                      return Properitesofprofilepage(
                        sufexicon: Icons.chevron_right,
                        preicon: Icons.brightness_6,
                        title: 'Theme: $themeLabel',
                        ontap: () {
                          showDialog(
                            context: context,
                            builder: (dialogContext) => AlertDialog(
                              title: Text('Select Theme'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RadioListTile<ThemeModeState>(
                                    title: Text('Light'),
                                    value: ThemeModeState.light,
                                    groupValue: currentTheme,
                                    onChanged: (value) {
                                      if (value != null) {
                                        themecubit.selectTheme(value);
                                        Navigator.pop(dialogContext);
                                      }
                                    },
                                  ),
                                  RadioListTile<ThemeModeState>(
                                    title: Text('Dark'),
                                    value: ThemeModeState.dark,
                                    groupValue: currentTheme,
                                    onChanged: (value) {
                                      if (value != null) {
                                        themecubit.selectTheme(value);
                                        Navigator.pop(dialogContext);
                                      }
                                    },
                                  ),
                                  RadioListTile<ThemeModeState>(
                                    title: Text('System'),
                                    value: ThemeModeState.system,
                                    groupValue: currentTheme,
                                    onChanged: (value) {
                                      if (value != null) {
                                        themecubit.selectTheme(value);
                                        Navigator.pop(dialogContext);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Properitesofprofilepage(
                      sufexicon: Icons.chevron_right,
                      preicon: Icons.lock,
                      title: 'Change password',
                      ontap: () {}),
                ],
              ),
              SizedBox(
                height: size.height * .02,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                bloc: cubit,
                listenWhen: (previous, current) =>
                    current is AuthLogoutfail || current is AuthLogedout,
                listener: (context, state) {
                  if (state is AuthLogedout) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRouts.Loginroute, (route) => false);
                  } else if (state is AuthLogoutfail) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                buildWhen: (previous, current) => current is AuthLogingout,
                builder: (context, state) {
                  if (state is AuthLogingout) {
                    return MainButton(
                      islooding: true,
                    );
                  }
                  return MainButton(
                    title: 'Sign out',
                    ontap: () async {
                      await cubit.Logout();
                    },
                  );
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
