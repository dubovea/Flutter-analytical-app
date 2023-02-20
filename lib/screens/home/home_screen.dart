import 'package:analytical_ecommerce/blocs/category/category_bloc.dart';
import 'package:analytical_ecommerce/blocs/product/product_bloc.dart';
import 'package:analytical_ecommerce/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';
  HomeScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => HomeScreen());
  }

  BlocBuilder productBuilder({bool? isRecommended, bool? isPopular}) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductLoaded) {
          if (isRecommended != null) {
            return ProductCarousel(
                products:
                    state.products.where((o) => o.isRecommended).toList());
          }
          if (isPopular != null) {
            return ProductCarousel(
                products: state.products.where((o) => o.isPopular).toList());
          }
        }
        return const Text('Error loading products');
      },
    );
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
              productBuilder(isRecommended: true),
              const SectionTitle(title: 'POPULAR'),
              productBuilder(isPopular: true)
            ],
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomBar(
        screen: routeName,
      ),
    );
  }
}
