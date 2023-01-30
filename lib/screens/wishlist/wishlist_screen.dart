import 'package:analytical_ecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  static const String routeName = '/wishlist';
  const WishlistScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const WishlistScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Wishlist'),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
