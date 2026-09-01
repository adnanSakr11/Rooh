import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../features/auth/data/data_source/fire_store_user_data_soruce.dart';
import '../../features/auth/data/data_source/firebase_auth_data_source.dart';
import '../../features/auth/data/repo/auth_repo_impl.dart';
import '../../features/auth/domain/repo/auth_repo.dart';
import '../../features/auth/domain/usecases/sign_out_usecasse.dart';
import '../../features/auth/domain/usecases/signin_with_google.dart';
import '../../features/auth/domain/usecases/signin_with_phone_and_pass.dart';
import '../../features/auth/domain/usecases/update_user_name.dart';
import '../../features/auth/domain/usecases/watch_auth_state_usecase.dart';

final getIt = GetIt.instance;

/// بيتسجل مرة واحدة بس في main() قبل runApp.
/// نطاقه Auth بس دلوقتي — Products وأي feature تانية لسه هيا هيا.
void setupAuthDependencies() {
  // Infra singletons — نسخة واحدة بس من GoogleSignIn في التطبيق كله،
  // ده اللي بيحل مشكلة التكرار اللي كانت بين main.dart و LoginScreen.
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  // Data sources
  getIt.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSource(getIt<FirebaseAuth>(), getIt<GoogleSignIn>()),
  );
  getIt.registerLazySingleton<FireStoreUserDataSoruce>(
    () => FireStoreUserDataSoruce(getIt<FirebaseFirestore>()),
  );

  // Repo — واحد بس، نفس الـ instance في كل التطبيق
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      getIt<FirebaseAuthDataSource>(),
      getIt<FireStoreUserDataSoruce>(),
    ),
  );

  // Usecases
  getIt.registerLazySingleton(
    () => WatchAuthStateUsecase(authRepo: getIt<AuthRepo>()),
  );
  getIt.registerLazySingleton(
    () => SigninWithGoogleUsecase(authRepo: getIt<AuthRepo>()),
  );
  getIt.registerLazySingleton(
    () => SigninWithPhoneAndPassUsecase(authRepo: getIt<AuthRepo>()),
  );
  getIt.registerLazySingleton(
    () => UpdateUserNameUsecase(authRepo: getIt<AuthRepo>()),
  );
  getIt.registerLazySingleton(() => SignOutUsecasse(getIt<AuthRepo>()));
}