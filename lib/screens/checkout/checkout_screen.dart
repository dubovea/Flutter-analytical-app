import 'package:analytical_ecommerce/blocs/checkout/checkout_bloc.dart';
import 'package:analytical_ecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const CheckoutScreen());
  }

  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Заказ'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CheckoutLoaded) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ИНФО КЛИЕНТА',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    CustomTextFromField(
                        title: 'Почта',
                        onChanged: (value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(email: value));
                        }),
                    CustomTextFromField(
                        title: 'ФИО',
                        onChanged: (value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(name: value));
                        }),
                    Text(
                      'ИНФО ДОСТАВКА',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    CustomTextFromField(
                        title: 'Адрес',
                        onChanged: (value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(address: value));
                        }),
                    CustomTextFromField(
                        title: 'Город',
                        onChanged: (value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(city: value));
                        }),
                    CustomTextFromField(
                        title: 'Страна',
                        onChanged: (value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(country: value));
                        }),
                    CustomTextFromField(
                        title: 'Индекс',
                        onChanged: (value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(zipCode: value));
                        }),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: const BoxDecoration(color: Colors.black),
                      alignment: Alignment.bottomCenter,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                                child: TextButton(
                              child: Text('ВЫБЕРИТЕ СПОСОБ ОПЛАТЫ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(color: Colors.white)),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/payment-selection');
                              },
                            )),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                )),
                          ]),
                    ),
                    Text(
                      'К ОПЛАТЕ',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const OrderSummary()
                  ]);
            }
            return const Text('Error with loading checkout screen');
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomBar(
        screen: routeName,
      ),
    );
  }
}
