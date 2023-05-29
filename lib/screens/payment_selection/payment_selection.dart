import 'dart:io';

import 'package:analytical_ecommerce/blocs/payment/payment_bloc.dart';
import 'package:analytical_ecommerce/models/models.dart';
import 'package:analytical_ecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (state is PaymentLoaded) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Platform.isIOS
                    ? RawApplePayButton(
                        onPressed: () {
                          context.read<PaymentBloc>().add(
                              const SelectPaymentMethod(
                                  paymentMethod: PaymentMethod.apple_pay));
                          Navigator.pop(context);
                        },
                      )
                    : const SizedBox(),
                const SizedBox(height: 10),
                Platform.isAndroid
                    ? RawGooglePayButton(
                        type: GooglePayButtonType.pay,
                        onPressed: () {
                          context.read<PaymentBloc>().add(
                              const SelectPaymentMethod(
                                  paymentMethod: PaymentMethod.google_pay));
                          Navigator.pop(context);
                        },
                      )
                    : const SizedBox(),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    context.read<PaymentBloc>().add(const SelectPaymentMethod(
                        paymentMethod: PaymentMethod.credit_card));
                    Navigator.pop(context);
                  },
                  child: const Text('Оплатить банковской картой'),
                )
              ],
            );
          }
          return const Text('Произошла ошибка при загрузке способы оплаты');
        },
      ),
      bottomNavigationBar: const CustomBottomBar(screen: routeName),
    );
  }
}
