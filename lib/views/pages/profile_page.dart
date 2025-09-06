import 'package:ecommerce_new/utils/app_routes.dart';
import 'package:ecommerce_new/view_models/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_new/widgets/main_button.dart';
import 'package:ecommerce_new/widgets/properitesofprofilepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_models/theme_cubit/theme_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _check = false;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    final themecubit = BlocProvider.of<ThemeCubit>(context);
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.only(top: 24, right: 8, left: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Abdo Mhmd',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 32,
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
                    height: 24,
                  ),
                  Properitesofprofilepage(
                      sufexicon: Icons.chevron_right,
                      preicon: Icons.notifications,
                      title: 'Notifications',
                      ontap: () {}),
                  SizedBox(
                    height: 24,
                  ),
                  Properitesofprofilepage(
                      sufexicon: Icons.arrow_drop_down_outlined,
                      // sufexicon: _check ? Icons.toggle_on : Icons.toggle_off,
                      preicon: Icons.chevron_right,
                      title: 'Dark Theme',
                      ontap: () {
                        _check
                            ? themecubit.selectTheme(ThemeModeState.light)
                            : themecubit.selectTheme(ThemeModeState.dark);
                      }),
                  SizedBox(
                    height: 24,
                  ),
                  Properitesofprofilepage(
                      sufexicon: Icons.chevron_right,
                      preicon: Icons.lock,
                      title: 'Change password',
                      ontap: () {}),
                ],
              ),
              SizedBox(
                height: 16,
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
                  // TODO: implement listener
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
