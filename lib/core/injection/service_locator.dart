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

import '../../features/products/data/data_source/data_source.dart';
import '../../features/products/data/repo/products_repo.dart';
import '../../features/products/domain/repo/products_repo.dart';
import '../../features/products/domain/usecases/fetch_images_on_pexels_usecase.dart';
import '../../features/products/domain/usecases/search_app_products.dart';

import '../../features/cart/data/data_source/firestore_cart_data_source.dart';
import '../../features/cart/data/data_source/local_cart_data_source.dart';
import '../../features/cart/data/repo/cart_repo_impl.dart';
import '../../features/cart/domain/repo/cart_repo.dart';
import '../../features/cart/domain/usecases/add_item_to_cart_usecase.dart';
import '../../features/cart/domain/usecases/clear_cart_usecase.dart';
import '../../features/cart/domain/usecases/remove_item_from_cart.dart';
import '../../features/cart/domain/usecases/update_cart_quantity_usecase.dart';
import '../../features/cart/domain/usecases/watch_cart_usecase.dart';

final getIt = GetIt.instance;

/// ==================== AUTH ====================
void setupAuthDependencies() {
  // Infra singletons — نسخة واحدة بس من GoogleSignIn في التطبيق كله.
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

  // Repo
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

/// ==================== PRODUCTS ====================
void setupProductsDependencies() {
  getIt.registerLazySingleton<PexelsDataSource>(() => const PexelsDataSource());

  getIt.registerLazySingleton<ProductsRepo>(() => ProductRepositoryImpl());

  getIt.registerLazySingleton(
    () => FetchImagesOnPexelsUsecase(getIt<ProductsRepo>()),
  );

  getIt.registerLazySingleton(() => SearchAppProductsUsecase());
}

/// ==================== CART ====================
void setupCartDependencies() {
  getIt.registerLazySingleton<LocalCartDataSource>(() => LocalCartDataSource());
  getIt.registerLazySingleton<FirestoreCartDataSource>(
    () => FirestoreCartDataSource(getIt<FirebaseFirestore>()),
  );

  getIt.registerLazySingleton<CartRepo>(
    () => CartRepoImpl(
      getIt<LocalCartDataSource>(),
      getIt<FirestoreCartDataSource>(),
      getIt<FirebaseAuthDataSource>(),
    ),
  );

  getIt.registerLazySingleton(() => WatchCartUsecase(getIt<CartRepo>()));
  getIt.registerLazySingleton(() => AddItemToCartUsecase(getIt<CartRepo>()));
  getIt.registerLazySingleton(
    () => RemoveItemFromCartUsecase(getIt<CartRepo>()),
  );
  getIt.registerLazySingleton(
    () => UpdateCartQuantityUsecase(getIt<CartRepo>()),
  );
  getIt.registerLazySingleton(() => ClearCartUsecase(getIt<CartRepo>()));
}
