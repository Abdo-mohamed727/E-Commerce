import 'package:ecommerce_new/utils/app_colors.dart';
import 'package:ecommerce_new/view_models/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_new/widgets/Socialmedia_button.dart';
import 'package:ecommerce_new/widgets/label_with_textfield_new_card.dart';
import 'package:ecommerce_new/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/app_routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final usernamecontroller = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    usernamecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * .05),
                Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Please, register with your details!',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Appcolors.grey),
                ),
                SizedBox(height: size.height * .04),
                LabelWithTextfield(
                  label: 'Username',
                  controler: usernamecontroller,
                  prefixicon: Icons.person,
                  hinttext: 'Enter your username',
                ),
                SizedBox(height: size.height * .03),
                LabelWithTextfield(
                  label: 'Email',
                  controler: emailcontroller,
                  prefixicon: Icons.email,
                  hinttext: 'Enter your Email',
                ),
                SizedBox(height: size.height * .03),
                LabelWithTextfield(
                  label: 'Password',
                  controler: passwordcontroller,
                  prefixicon: Icons.lock,
                  obscureText: !_isPasswordVisible,
                  suffixicon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                  hinttext: 'Enter your password',
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text('Forget Password!'),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: size.height * .04),
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
                  },
                  buildWhen: (previous, current) =>
                      current is AuthDone ||
                      current is AuthError ||
                      current is Authlooding,
                  builder: (context, state) {
                    if (state is Authlooding) {
                      return MainButton(islooding: true);
                    }
                    return MainButton(
                      title: 'Create Account',
                      ontap: () async {
                        await cubit.registrwithemailandpassword(
                          emailcontroller.text,
                          passwordcontroller.text,
                          usernamecontroller.text,
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: size.height * .02),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRouts.Loginroute);
                        },
                        child: const Text("Already have an account? Login"),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Or using other method',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Appcolors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * .02),
                BlocConsumer<AuthCubit, AuthState>(
                  bloc: cubit,
                  listenWhen: (previous, current) =>
                      current is GoogleAuthDone || current is GoogleAuthError,
                  listener: (context, state) {
                    if (state is GoogleAuthDone) {
                      Navigator.of(context).pushNamed(AppRouts.homeroute);
                    } else if (state is GoogleAuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is GoogleAuthDone ||
                      current is GoogleAuthError ||
                      current is GoogleAuthenticating,
                  builder: (context, state) {
                    if (state is GoogleAuthenticating) {
                      return SocialmediaButton(islooding: true);
                    }
                    return SocialmediaButton(
                      text: 'Sign in with Google',
                      imgurl:
                          'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                      ontap: () async => await cubit.authenticatewithgoogle(),
                    );
                  },
                ),
                SizedBox(height: size.height * .02),
                SocialmediaButton(
                  text: 'Sign up with Facebook',
                  imgurl:
                      'https://www.pixsector.com/cache/c2d6c2a1/av580aef89b415365fb9c.png',
                  ontap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
