import 'package:analytical_ecommerce/models/models.dart';
import 'package:analytical_ecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CatalogScreen extends StatelessWidget {
  static const String routeName = '/catalog';

  static Route route({required Category category}) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => CatalogScreen(category: category));
  }

  final Category category;

  const CatalogScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final List<Product> categoryProducts =
        Product.products.where((o) => o.category == category.name).toList();
    return Scaffold(
      appBar: CustomAppBar(title: category.name),
      body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.23),
          itemCount: categoryProducts.length,
          itemBuilder: (BuildContext context, int index) => Center(
                child: ProductCard(
                  widthFactor: 2.2,
                  product: categoryProducts[index],
                ),
              )),
      bottomNavigationBar: CustomBottomBar(
        screen: routeName,
      ),
    );
  }
}
