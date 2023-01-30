import 'package:analytical_ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            height: 150,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            )),
        Positioned(
            top: 60,
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(color: Colors.black.withAlpha(50)),
            )),
        Positioned(
            bottom: 5,
            left: 5,
            child: Container(
              width: MediaQuery.of(context).size.width / 2.5 - 10,
              height: 51,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          '\$${product.price.toString()}',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        )),
                  )
                ]),
              ),
            ))
      ],
    );
  }
}
