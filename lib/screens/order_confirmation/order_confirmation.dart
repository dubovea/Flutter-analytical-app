import 'package:analytical_ecommerce/models/models.dart';
import 'package:analytical_ecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderConfirmation extends StatelessWidget {
  static const String routeName = '/order-confirmation';
  const OrderConfirmation({super.key});
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const OrderConfirmation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Подтверждение'),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              Container(
                color: Colors.black,
                width: double.infinity,
                height: 300,
              ),
              Positioned(
                  left: (MediaQuery.of(context).size.width - 150) / 2,
                  top: 80,
                  width: 150,
                  height: 150,
                  child: Image.asset('assets/images/confirmation.png')),
              Positioned(
                top: 250,
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Ваша покупка завершена успешно!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ваша покупка завершена успешно!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  'Ваша покупка завершена успешно!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                Text(
                  'Ваша покупка завершена успешно!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const OrderSummary(),
                const SizedBox(height: 20),
                Text(
                  'ДЕТАЛИ ЗАКАЗА',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Divider(thickness: 2),
                const SizedBox(height: 5),
                ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    OrderSummaryProductCard(
                      product: Product.products[0],
                      quantity: 2,
                    ),
                    OrderSummaryProductCard(
                      product: Product.products[1],
                      quantity: 3,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      )),
      bottomNavigationBar: const CustomBottomBar(screen: routeName),
    );
  }
}
