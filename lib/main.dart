import 'package:analytical_ecommerce/bloc_observer.dart';
import 'package:analytical_ecommerce/blocs/cart/cart_bloc.dart';
import 'package:analytical_ecommerce/blocs/wishlist/wishlist_bloc.dart';
import 'package:analytical_ecommerce/config/app_router.dart';
import 'package:analytical_ecommerce/config/theme.dart';
import 'package:analytical_ecommerce/screens/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
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
          create: (context) => WishlistBloc()..add(StartWishlist()),
        ),
        BlocProvider(
          create: (context) => CartBloc()..add(LoadCart()),
        )
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
