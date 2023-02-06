import 'package:analytical_ecommerce/blocs/cart/cart_bloc.dart';
import 'package:analytical_ecommerce/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductCard extends StatelessWidget {
  final Product product;
  const CartProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Image.network(
            product.imageUrl,
            width: 100,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: Theme.of(context).textTheme.headlineSmall),
                Text('\$${product.price.toString()}',
                    style: Theme.of(context).textTheme.titleLarge)
              ],
            ),
          ),
          Row(
            children: [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return IconButton(
                      onPressed: () {
                        context
                            .read<CartBloc>()
                            .add(RemoveProductFromCart(product));
                        const snackBar =
                            SnackBar(content: Text('Товар удалён из корзины'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      icon: const Icon(Icons.remove_circle));
                },
              ),
              Text(product.count.toString(),
                  style: Theme.of(context).textTheme.headlineSmall),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return IconButton(
                      onPressed: () {
                        context
                            .read<CartBloc>()
                            .add(AddProductToCart(product));
                        const snackBar =
                            SnackBar(content: Text('Товар добавлен в корзину'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      icon: const Icon(Icons.add_circle));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
