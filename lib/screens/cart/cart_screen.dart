import 'package:analytical_ecommerce/models/models.dart';
import 'package:analytical_ecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';
  const CartScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const CartScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Cart'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Add 20 for FREE Delivery',
                          style: Theme.of(context).textTheme.displaySmall),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: const RoundedRectangleBorder(),
                              elevation: 0),
                          child: Text('Add more items',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.white))),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CartProductCard(
                    product: Product.products[0],
                  ),
                  CartProductCard(
                    product: Product.products[1],
                  ),
                  CartProductCard(
                    product: Product.products[2],
                  ),
                ],
              ),
              Column(
                children: [
                  const Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('SUBTOTAL',
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            Text('\$5.98',
                                style:
                                    Theme.of(context).textTheme.headlineSmall)
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('DELIVERY',
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            Text('\$5.98',
                                style:
                                    Theme.of(context).textTheme.headlineSmall)
                          ],
                        )
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(50),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('TOTAL',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(color: Colors.white)),
                              Text('\$12.98',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(color: Colors.white))
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ]),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: SizedBox(
          height: 70,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {},
              child: Text('GO TO CHECKOUT',
                  style: Theme.of(context).textTheme.displaySmall),
            )
          ]),
        ),
      ),
    );
  }
}
