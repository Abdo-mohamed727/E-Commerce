import 'package:ecommerce_new/utils/app_colors.dart';
import 'package:ecommerce_new/utils/app_routes.dart';
import 'package:ecommerce_new/view_models/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_new/widgets/Socialmedia_button.dart';
import 'package:ecommerce_new/widgets/label_with_textfield_new_card.dart';
import 'package:ecommerce_new/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final emailcontroller = TextEditingController();
final passwordlcontroller = TextEditingController();
final formkey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Login Account',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Please, login with registered account!',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Appcolors.grey),
                ),
                SizedBox(
                  height: 24,
                ),
                LabelWithTextfield(
                  label: 'Email',
                  controler: emailcontroller,
                  prefixicon: Icons.email,
                  hinttext: 'Enter your Email',
                ),
                const SizedBox(
                  height: 24,
                ),
                LabelWithTextfield(
                    label: 'Password',
                    controler: passwordlcontroller,
                    prefixicon: Icons.password,
                    suffixicon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.visibility,
                      ),
                    ),
                    hinttext: 'Enter your password'),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      'Forget Password!',
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  bloc: cubit,
                  listenWhen: (previous, current) =>
                      current is AuthDone || current is AuthError,
                  listener: (context, state) {
                    if (state is AuthDone) {
                      Navigator.of(context).pushNamed(AppRouts.homeroute);
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errormessage)),
                      );
                    }
                    // TODO: implement listener
                  },
                  buildWhen: (previous, current) =>
                      current is AuthDone ||
                      current is AuthError ||
                      current is Authlooding,
                  builder: (context, state) {
                    if (state is Authlooding) {
                      return MainButton(
                        islooding: true,
                      );
                    }
                    return MainButton(
                      title: 'Sign In',
                      ontap: () async {
                        if (formkey.currentState!.validate()) {
                          await cubit.loginwithemailandpassword(
                              emailcontroller.text, passwordlcontroller.text);
                        }
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AppRouts.Registerroute);
                        },
                        child: Text('Don\'t have an account? Register'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Or using other method',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Appcolors.grey,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  bloc: cubit,
                  listenWhen: (previous, current) =>
                      current is GoogleAuthDone || current is GoogleAuthError,
                  listener: (context, state) {
                    if (state is GoogleAuthDone) {
                      Navigator.of(context).pushNamed(AppRouts.homeroute);
                    } else if (state is GoogleAuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is GoogleAuthDone ||
                      current is GoogleAuthError ||
                      current is GoogleAuthenticating,
                  builder: (context, state) {
                    if (state is GoogleAuthenticating) {
                      return SocialmediaButton(
                        islooding: true,
                      );
                    }
                    return SocialmediaButton(
                      text: 'Sign in with google',
                      imgurl:
                          'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                      ontap: () async => await cubit.authenticatewithgoogle(),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  bloc: cubit,
                  listenWhen: (previous, current) =>
                      current is FacebookAuthError ||
                      current is FacebookAuthDone,
                  listener: (context, state) {
                    if (state is FacebookAuthDone) {
                      Navigator.of(context).pushNamed(AppRouts.homeroute);
                    } else if (state is FacebookAuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                    // TODO: implement listener
                  },
                  buildWhen: (previous, current) =>
                      current is FacebookAuthError ||
                      current is FacebookAuthDone ||
                      current is FacebookAuthenticating,
                  builder: (context, state) {
                    if (state is FacebookAuthError) {
                      return SocialmediaButton(
                        islooding: true,
                      );
                    }
                    return SocialmediaButton(
                      text: 'sign in with Facebook',
                      imgurl:
                          'https://www.pixsector.com/cache/c2d6c2a1/av580aef89b415365fb9c.png',
                      ontap: () async => await cubit.authenticatewithfacebook(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
