import 'package:analytical_ecommerce/blocs/category/category_bloc.dart';
import 'package:analytical_ecommerce/blocs/product/product_bloc.dart';
import 'package:analytical_ecommerce/models/models.dart';
import 'package:analytical_ecommerce/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';
  const HomeScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Zero to Unicorn'),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CategoryLoaded) {
                    return CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 1.5,
                        viewportFraction: 0.9,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                      ),
                      items: state.categories
                          .map((category) =>
                              CategoryCarousel(category: category))
                          .toList(),
                    );
                  } else {
                    return const Text('Error loading categories');
                  }
                },
              ),
              const SectionTitle(title: 'RECOMMENDED'),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ProductLoaded) {
                    return ProductCarousel(
                        products:
                            state.products.where((o) => o.isPopular).toList());
                  } else {
                    return const Text('Error loading products');
                  }
                },
              ),
              const SectionTitle(title: 'POPULAR'),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ProductLoaded) {
                    return ProductCarousel(
                        products: state.products
                            .where((o) => o.isRecommended)
                            .toList());
                  } else {
                    return const Text('Error loading products');
                  }
                },
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }
}
