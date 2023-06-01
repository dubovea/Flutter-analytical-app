import 'package:analytical_ecommerce/blocs/product/product_bloc.dart';
import 'package:analytical_ecommerce/models/models.dart';
import 'package:analytical_ecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogScreen extends StatelessWidget {
  static const String routeName = '/catalog';

  static Route route({required Category category}) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => CatalogScreen(category: category));
  }

  final Category category;

  const CatalogScreen({super.key, required this.category});

  BlocBuilder productBuilder() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductLoaded) {
          final List<Product> categoryProducts =
              state.products.where((o) => o.category == category.name).toList();
          return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.23),
              itemCount: categoryProducts.length,
              itemBuilder: (BuildContext context, int index) => Center(
                    child: ProductCard.catalog(
                      product: categoryProducts[index],
                    ),
                  ));
        }
        return const Text('Error loading products');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: category.name),
      body: productBuilder(),
      bottomNavigationBar: const CustomBottomBar(
        screen: routeName,
      ),
    );
  }
}
