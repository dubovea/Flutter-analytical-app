import 'package:analytical_ecommerce/bloc_observer.dart';
import 'package:analytical_ecommerce/blocs/cart/cart_bloc.dart';
import 'package:analytical_ecommerce/blocs/category/category_bloc.dart';
import 'package:analytical_ecommerce/blocs/checkout/checkout_bloc.dart';
import 'package:analytical_ecommerce/blocs/payment/payment_bloc.dart';
import 'package:analytical_ecommerce/blocs/product/product_bloc.dart';
import 'package:analytical_ecommerce/blocs/wishlist/wishlist_bloc.dart';
import 'package:analytical_ecommerce/config/app_router.dart';
import 'package:analytical_ecommerce/config/theme.dart';
import 'package:analytical_ecommerce/models/models.dart';
import 'package:analytical_ecommerce/repositories/category/category_repo.dart';
import 'package:analytical_ecommerce/repositories/checkout/checkout_repo.dart';
import 'package:analytical_ecommerce/repositories/local_storage/local_storage_repo.dart';
import 'package:analytical_ecommerce/repositories/product/product_repo.dart';
import 'package:analytical_ecommerce/screens/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Bloc.observer = Observer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              WishlistBloc(localStorageRepo: LocalStorageRepo())
                ..add(StartWishlist()),
        ),
        BlocProvider(
          create: (context) => CartBloc()..add(LoadCart()),
        ),
        BlocProvider(
          create: (context) => PaymentBloc()..add(LoadPaymentMethod()),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(
            categoryRepo: CategoryRepo(),
          )..add(LoadCategory()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(
            productRepo: ProductRepo(),
          )..add(LoadProduct()),
        ),
        BlocProvider(
            create: (context) => CheckoutBloc(
                cartBloc: context.read<CartBloc>(),
                paymentBloc: context.read<PaymentBloc>(),
                checkoutRepo: CheckoutRepo()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: StartScreen.routeName,
      ),
    );
  }
}
