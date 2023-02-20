import 'package:analytical_ecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController countryController = TextEditingController();
    final TextEditingController zipCodeController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Checkout'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CUSTOM INFORMATION',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              _buildTextFormField(emailController, context, 'Email'),
              _buildTextFormField(nameController, context, 'Full name'),
              Text(
                'DELIVERY INFORMATION',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              _buildTextFormField(addressController, context, 'Address'),
              _buildTextFormField(cityController, context, 'City'),
              _buildTextFormField(countryController, context, 'Country'),
              _buildTextFormField(zipCodeController, context, 'Zip Code'),
              Text(
                'ORDER SUMMARY',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const OrderSummary()
            ]),
      ),
      bottomNavigationBar: const CustomBottomBar(
        screen: routeName,
      ),
    );
  }

  _buildTextFormField(TextEditingController controller, BuildContext context,
      String labelText) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        SizedBox(
            width: 75,
            child:
                Text(labelText, style: Theme.of(context).textTheme.titleLarge)),
        Expanded(
            child: TextFormField(
          controller: controller,
          decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(left: 10),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.black,
              ))),
        ))
      ]),
    );
  }
}
