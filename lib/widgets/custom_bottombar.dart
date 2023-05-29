import 'dart:io';

import 'package:analytical_ecommerce/blocs/cart/cart_bloc.dart';
import 'package:analytical_ecommerce/blocs/checkout/checkout_bloc.dart';
import 'package:analytical_ecommerce/models/models.dart';
import 'package:analytical_ecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';

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
      case '/order-confirmation':
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
      BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CheckoutLoaded) {
            if (Platform.isIOS) {
              switch (state.paymentMethod) {
                case PaymentMethod.apple_pay:
                  return ApplePayButton(
                    onPaymentResult: (Map<String, dynamic> result) {},
                    paymentItems: [],
                  );
                case PaymentMethod.credit_card:
                  return Container(
                    child: Text('Банковская карта',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white)),
                  );
                default:
                  return ApplePayButton(
                    onPaymentResult: (Map<String, dynamic> result) {},
                    paymentItems: [],
                  );
              }
            }
            if (Platform.isAndroid) {
              switch (state.paymentMethod) {
                case PaymentMethod.google_pay:
                  return GooglePay(
                    products: state.products!,
                    total: state.total!,
                  );
                case PaymentMethod.credit_card:
                  return Container(
                    child: Text('Банковская карта',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white)),
                  );
                default:
                  return GooglePay(
                    products: state.products!,
                    total: state.total!,
                  );
              }
            }

            return ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/payment-selection');
                },
                child: Text('ВЫБЕРИТЕ ОПЛАТУ',
                    style: Theme.of(context).textTheme.displaySmall));
          }
          return const Text('Error loading order bottom bar');
        },
      )
    ];
  }
}
