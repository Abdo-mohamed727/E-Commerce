import 'package:ecommerce_new/models/user_data.dart';
import 'package:ecommerce_new/services/auth_services.dart';
import 'package:ecommerce_new/services/firestore_services.dart';
import 'package:ecommerce_new/utils/api_pathes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final Authservices authservices = Authservicesimp();
  final firestoreservices = FirestoreServices.instance;

  Future<void> loginwithemailandpassword(String email, String password) async {
    emit(Authlooding());
    try {
      final result =
          await authservices.LoginWithEmailandPassword(email, password);
      if (result) {
        emit(AuthDone());
      } else {
        emit(AuthError('Loginfail'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> registrwithemailandpassword(
      String email, String password, String username) async {
    emit(Authlooding());
    try {
      final result =
          await authservices.RegisterWithEmailandPassword(email, password);
      if (result) {
        await _saveuserdata(email, username);
        emit(AuthDone());
      } else {
        emit(AuthError('Loginfail'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _saveuserdata(String email, String username) async {
    final currentuser = authservices.currentuser();
    final userdata = UserData(
        id: currentuser!.uid,
        username: username,
        email: email,
        createdAt: DateTime.now().toIso8601String());
    await firestoreservices.setData(
        path: ApiPathes.user(userdata.id), data: userdata.toMap());
  }

  void Checkauth() {
    final user = authservices.currentuser();
    if (user != null) {
      emit(AuthDone());
    }
  }

  Future<void> Logout() async {
    emit(AuthLogingout());
    try {
      await authservices.Logout();
      emit(AuthLogedout());
    } catch (e) {
      emit(AuthLogoutfail(e.toString()));
    }
  }

  Future<void> authenticatewithgoogle() async {
    emit(GoogleAuthenticating());
    try {
      final result = await authservices.authenticatewithgoogle();
      if (result) {
        emit(GoogleAuthDone());
      } else {
        emit(GoogleAuthError('Google authentication failed'));
      }
    } catch (e) {
      emit(GoogleAuthError(e.toString()));
    }
  }

  Future<void> authenticatewithfacebook() async {
    emit(FacebookAuthenticating());
    try {
      final result = await authservices.authenticatewithfacebook();
      if (result) {
        emit(FacebookAuthDone());
      } else {
        emit(FacebookAuthError('facebook authentication failed'));
      }
    } catch (e) {
      emit(FacebookAuthError(e.toString()));
    }
  }
}
