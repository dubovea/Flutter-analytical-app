import 'package:analytical_ecommerce/blocs/wishlist/wishlist_bloc.dart';
import 'package:analytical_ecommerce/models/models.dart';
import 'package:analytical_ecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      appBar: CustomAppBar(title: 'Wishlist'),
      bottomNavigationBar: CustomBottomBar(),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is WishlistLoaded) {
            return GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, childAspectRatio: 2.5),
                itemCount: state.wishlist.products.length,
                itemBuilder: (BuildContext context, int index) => Center(
                      child: ProductCard(
                        widthFactor: 1.1,
                        leftPosition: 100,
                        isWishlist: true,
                        product: state.wishlist.products[index],
                      ),
                    ));
          } else {
            return Text('Error');
          }
        },
      ),
    );
  }
}
