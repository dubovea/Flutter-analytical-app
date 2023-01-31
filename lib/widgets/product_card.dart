import 'package:analytical_ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double widthFactor;
  final double leftPosition;
  final bool isWishlist;

  const ProductCard(
      {super.key,
      required this.product,
      this.widthFactor = 2.5,
      this.leftPosition = 5,
      this.isWishlist = false});

  @override
  Widget build(BuildContext context) {
    final double widthValue = MediaQuery.of(context).size.width / widthFactor;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/product', arguments: product),
      child: Stack(
        children: [
          SizedBox(
              width: widthValue,
              height: 150,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              )),
          Positioned(
              top: 60,
              left: leftPosition,
              child: Container(
                width: widthValue - 5 - leftPosition,
                height: 80,
                decoration: BoxDecoration(color: Colors.black.withAlpha(50)),
              )),
          Positioned(
              bottom: 5,
              left: leftPosition + 5,
              child: Container(
                width: widthValue - 15,
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
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        )),
                    isWishlist
                        ? Expanded(
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                )),
                          )
                        : SizedBox()
                  ]),
                ),
              ))
        ],
      ),
    );
  }
}
