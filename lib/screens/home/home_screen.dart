import 'package:analytical_ecommerce/models/models.dart';
import 'package:analytical_ecommerce/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';
  const HomeScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const HomeScreen());
  }

  static List<Product> productsRecommended =
      Product.products.where((o) => o.isRecommended).toList();

  static List<Product> productsPopular =
      Product.products.where((o) => o.isPopular).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Zero to Unicorn'),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 1.5,
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                ),
                items: Category.categories
                    .map((category) => CategoryCarousel(category: category))
                    .toList(),
              ),
              SectionTitle(title: 'RECOMMENDED'),
              ProductCarousel(products: productsRecommended),
              SectionTitle(title: 'POPULAR'),
              ProductCarousel(products: productsPopular),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }
}
