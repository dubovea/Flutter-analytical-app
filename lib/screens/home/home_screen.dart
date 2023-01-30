import 'package:analytical_ecommerce/models/category_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Zero to Unicorn'),
      body: CarouselSlider(
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
      bottomNavigationBar: const CustomBottomBar(),
    );
  }
}
