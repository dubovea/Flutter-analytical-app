import 'package:analytical_ecommerce/blocs/cart/cart_bloc.dart';
import 'package:analytical_ecommerce/screens/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomBar extends StatelessWidget {
  final String screen;
  const CustomBottomBar({
    super.key,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 70,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _selectNavBar(context, screen)),
      ),
    );
  }

  List<Widget> _selectNavBar(context, screen) {
    switch (screen) {
      case '/':
        return _buildNavBar(context);
      case '/catalog':
        return _buildNavBar(context);
      case '/wishlist':
        return _buildNavBar(context);
      case '/product':
        return _buildNavBar(context);
      case '/cart':
        return _buildGoToCheckoutNavBar(context);
      case '/checkout':
        return _buildOrderNowNavBar(context);
      default:
        _buildNavBar(context);
    }
    return [const Text('Screen is undefined')];
  }

  List<Widget> _buildNavBar(context) {
    return [
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
        icon: const Icon(Icons.home),
        color: Colors.white,
      ),
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        icon: const Icon(Icons.shopping_cart),
        color: Colors.white,
      ),
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/user');
        },
        icon: const Icon(Icons.person),
        color: Colors.white,
      ),
    ];
  }

  List<Widget> _buildGoToCheckoutNavBar(context) {
    return [
      BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder()),
            onPressed: () {
              if (state is CartLoaded) {
                if (state.cart.subtotal == 0) {
                  const snackBar = SnackBar(
                      content: Text('Добавьте хотя бы 1 товар в корзину'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }
              }
              Navigator.pushNamed(context, '/checkout');
            },
            child: Text('ОФОРМИТЬ ЗАКАЗ',
                style: Theme.of(context).textTheme.displaySmall),
          );
        },
      )
    ];
  }

  List<Widget> _buildOrderNowNavBar(context) {
    return [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder()),
        onPressed: () {},
        child: Text('КУПИТЬ', style: Theme.of(context).textTheme.displaySmall),
      )
    ];
  }
}
