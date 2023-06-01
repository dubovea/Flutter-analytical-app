import 'package:analytical_ecommerce/blocs/cart/cart_bloc.dart';
import 'package:analytical_ecommerce/blocs/wishlist/wishlist_bloc.dart';
import 'package:analytical_ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  const ProductCard.catalog(
      {super.key,
      required this.product,
      this.quantity,
      this.widthFactor = 2.25,
      this.height = 150,
      this.isCatalog = true,
      this.isWishlist = false,
      this.isCart = false,
      this.isSummary = false,
      this.iconColor = Colors.white,
      this.fontColor = Colors.white});

  const ProductCard.cart(
      {super.key,
      required this.product,
      this.quantity,
      this.widthFactor = 2.25,
      this.height = 80,
      this.isCatalog = false,
      this.isWishlist = false,
      this.isCart = true,
      this.isSummary = false,
      this.iconColor = Colors.black,
      this.fontColor = Colors.black});

  const ProductCard.wishlist(
      {super.key,
      required this.product,
      this.quantity,
      this.widthFactor = 1.1,
      this.height = 150,
      this.isCatalog = false,
      this.isWishlist = true,
      this.isCart = false,
      this.isSummary = false,
      this.iconColor = Colors.white,
      this.fontColor = Colors.white});

  const ProductCard.summary(
      {super.key,
      required this.product,
      this.quantity,
      this.widthFactor = 2.25,
      this.height = 80,
      this.isCatalog = false,
      this.isWishlist = false,
      this.isCart = false,
      this.isSummary = true,
      this.iconColor = Colors.black,
      this.fontColor = Colors.black});

  final Product product;
  final int? quantity;
  final double widthFactor;
  final double height;
  final bool isCatalog;
  final bool isWishlist;
  final bool isCart;
  final bool isSummary;
  final Color iconColor;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double adjWidth = width / widthFactor;
    return InkWell(
      onTap: () {
        if (isCatalog || isWishlist) {
          Navigator.pushNamed(context, '/product', arguments: product);
        }
      },
      child: isCart || isSummary
          ? Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  ProductImage(adjWidth: 100, height: height, product: product),
                  const SizedBox(width: 20),
                  Expanded(
                      child: ProductInformation(
                    fontColor: fontColor,
                    product: product,
                    quantity: quantity,
                    isOrderSummary: isSummary || false,
                  )),
                  const SizedBox(width: 10),
                  ProductActions(
                      product: product,
                      isCatalog: isCatalog,
                      isWishlist: isWishlist,
                      isCart: isCart,
                      iconColor: iconColor)
                ],
              ),
            )
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ProductImage(
                    adjWidth: adjWidth, height: height, product: product),
                ProductBackground(adjWidth: adjWidth, widgets: <Widget>[
                  ProductInformation(fontColor: fontColor, product: product),
                  ProductActions(
                      product: product,
                      isCatalog: isCatalog,
                      isWishlist: isWishlist,
                      isCart: isCart,
                      iconColor: iconColor)
                ]),
              ],
            ),
    );
  }
}

class ProductInformation extends StatelessWidget {
  const ProductInformation({
    super.key,
    required this.fontColor,
    this.isOrderSummary = false,
    this.quantity,
    required this.product,
  });

  final Product product;
  final Color fontColor;
  final bool isOrderSummary;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: fontColor),
            ),
            Text(
              '\$${product.price.toString()}',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: fontColor),
            ),
          ],
        ),
        isOrderSummary
            ? Text('Кол. ${quantity}',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: fontColor))
            : SizedBox()
      ],
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.adjWidth,
    required this.product,
    required this.height,
  });

  final double adjWidth;
  final double height;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: adjWidth,
        height: height,
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ));
  }
}

class ProductBackground extends StatelessWidget {
  const ProductBackground(
      {super.key, required this.adjWidth, required this.widgets});

  final List<Widget> widgets;
  final double adjWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: adjWidth - 10,
        height: 70,
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(color: Colors.black.withAlpha(50)),
        child: Container(
          width: adjWidth - 20,
          height: 70,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.8)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [...widgets]),
          ),
        ));
  }
}

class ProductActions extends StatelessWidget {
  const ProductActions(
      {super.key,
      required this.product,
      required this.isCatalog,
      required this.isWishlist,
      required this.isCart,
      required this.iconColor,
      this.quantity});

  final Product product;
  final bool isCatalog;
  final bool isWishlist;
  final bool isCart;
  final Color iconColor;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          if (state is CartLoaded) {
            IconButton addProduct = IconButton(
                onPressed: () {
                  context.read<CartBloc>().add(AddProductToCart(product));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Товар добавлен в корзину')));
                },
                icon: Icon(
                  Icons.add_circle,
                  color: iconColor,
                ));

            IconButton removeFromWishlist = IconButton(
                onPressed: () {
                  context
                      .read<WishlistBloc>()
                      .add(RemoveProductWishlist(product));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Товар удалён из избранных')));
                },
                icon: Icon(
                  Icons.delete,
                  color: iconColor,
                ));

            IconButton removeProduct = IconButton(
                onPressed: () {
                  context.read<CartBloc>().add(RemoveProductFromCart(product));
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Товар удалён из корзины')));
                },
                icon: Icon(
                  Icons.remove_circle,
                  color: iconColor,
                ));

            Text productQuantity = Text(product.count.toString(),
                style: Theme.of(context).textTheme.headlineSmall);

            if (isCatalog) {
              return Row(
                children: [
                  addProduct,
                ],
              );
            }
            if (isWishlist) {
              return Row(
                children: [addProduct, removeFromWishlist],
              );
            }
            if (isCart) {
              return Row(
                children: [removeProduct, productQuantity, addProduct],
              );
            }
            return const SizedBox();
          }
          return const Text('Возникла ошибка при загрузке данных с продуктами');
        })
      ],
    );
  }
}
