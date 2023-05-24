import 'package:analytical_ecommerce/models/models.dart';
import 'package:analytical_ecommerce/screens/widgets.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    // ignore: avoid_print
    print('The current Route is: ${settings.name}');
    switch (settings.name) {
      case StartScreen.routeName:
        return StartScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);
      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);
      case WishlistScreen.routeName:
        return WishlistScreen.route();
      case CheckoutScreen.routeName:
        return CheckoutScreen.route();
      case OrderConfirmation.routeName:
        return OrderConfirmation.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Not Found')),
      ),
      settings: const RouteSettings(name: 'notFound'),
    );
  }
}
