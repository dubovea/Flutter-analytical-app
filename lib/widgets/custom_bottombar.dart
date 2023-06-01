import 'dart:io';

import 'package:analytical_ecommerce/blocs/cart/cart_bloc.dart';
import 'package:analytical_ecommerce/blocs/checkout/checkout_bloc.dart';
import 'package:analytical_ecommerce/blocs/wishlist/wishlist_bloc.dart';
import 'package:analytical_ecommerce/models/models.dart';
import 'package:analytical_ecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';

class CustomBottomBar extends StatelessWidget {
  final String screen;
  final Product? product;
  const CustomBottomBar({super.key, required this.screen, this.product});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
          height: 70,
          child: screen == '/product'
              ? AddToCartNavBar(product: product!)
              : screen == '/cart'
                  ? const GoToCheckoutNavBar()
                  : screen == '/checkout'
                      ? const OrderNowNavBar()
                      : const HomeNavBar()),
    );
  }
}

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
      ],
    );
  }
}

class OrderNowNavBar extends StatelessWidget {
  const OrderNowNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CheckoutLoaded) {
              if (state.paymentMethod == PaymentMethod.credit_card) {
                return Text('Банковская карта',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white));
              }
              if (Platform.isIOS &&
                  state.paymentMethod == PaymentMethod.apple_pay) {
                return ApplePayButton(
                  onPaymentResult: (Map<String, dynamic> result) {},
                  paymentItems: const [],
                );
              }
              if (Platform.isAndroid &&
                  state.paymentMethod == PaymentMethod.google_pay) {
                return GooglePay(
                  products: state.products!,
                  total: state.total!,
                );
              }

              return ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, '/payment-selection');
                  },
                  child: Text('ВЫБЕРИТЕ СПОСОБ ОПЛАТЫ',
                      style: Theme.of(context).textTheme.displaySmall));
            }
            return const Text('Ошибка при загрузке');
          },
        )
      ],
    );
  }
}

class GoToCheckoutNavBar extends StatelessWidget {
  const GoToCheckoutNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
      ],
    );
  }
}

class AddToCartNavBar extends StatelessWidget {
  const AddToCartNavBar({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share, color: Colors.white)),
        BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is WishlistLoaded) {
              return IconButton(
                  onPressed: () {
                    context
                        .read<WishlistBloc>()
                        .add(AddProductWishlist(product));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Товар добавлен в избранные')));
                  },
                  icon: const Icon(Icons.favorite, color: Colors.white));
            }
            return const Text('Ошибка при загрузке');
          },
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CartLoaded) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder()),
                onPressed: () {
                  context.read<CartBloc>().add(AddProductToCart(product));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Товар добавлен в корзину')));
                  Navigator.pushNamed(context, '/cart');
                },
                child: Text('ДОБАВИТЬ',
                    style: Theme.of(context).textTheme.displaySmall),
              );
            }

            return const Text('Ошибка при загрузке');
          },
        )
      ],
    );
  }
}
