import 'package:analytical_ecommerce/models/models.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class GooglePay extends StatelessWidget {
  GooglePay({super.key, required this.total, required this.products});

  final String total;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    var _paymentItems = products
        .map((product) => PaymentItem(
            amount: product.price.toString(),
            label: product.name,
            type: PaymentItemType.item,
            status: PaymentItemStatus.final_price))
        .toList();

    _paymentItems.add(PaymentItem(
        label: 'Стоимость',
        amount: total,
        type: PaymentItemType.item,
        status: PaymentItemStatus.final_price));

    void onGooglePayResult(paymentResult) {
      debugPrint(paymentResult.toString());
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: GooglePayButton(
        paymentConfigurationAsset: 'default_google_pay_config.json',
        type: GooglePayButtonType.pay,
        margin: EdgeInsets.only(top: 10),
        onPaymentResult: (Map<String, dynamic> result) {
          onGooglePayResult(result);
        },
        paymentItems: _paymentItems,
        loadingIndicator: const CircularProgressIndicator(),
      ),
    );
  }
}
