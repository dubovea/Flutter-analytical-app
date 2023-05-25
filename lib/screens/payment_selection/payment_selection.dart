import 'dart:io';

import 'package:analytical_ecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class PaymentSelection extends StatelessWidget {
  static const String routeName = '/payment-selection';
  const PaymentSelection({super.key});
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const PaymentSelection());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'СПОСОБ ОПЛАТЫ'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Platform.isIOS ? RawApplePayButton() : const SizedBox(),
          const SizedBox(height: 10),
          Platform.isAndroid
              ? RawGooglePayButton(
                  type: GooglePayButtonType.pay,
                  onPressed: () {},
                )
              : const SizedBox(),
        ],
      ),
      bottomNavigationBar: const CustomBottomBar(screen: routeName),
    );
  }
}
