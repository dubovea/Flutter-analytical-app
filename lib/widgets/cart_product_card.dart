
import 'package:analytical_ecommerce/models/models.dart';
import 'package:flutter/material.dart';

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
              IconButton(onPressed: () {}, icon: Icon(Icons.remove_circle)),
              Text('1', style: Theme.of(context).textTheme.headlineSmall),
              IconButton(onPressed: () {}, icon: Icon(Icons.add_circle)),
            ],
          )
        ],
      ),
    );
  }
}