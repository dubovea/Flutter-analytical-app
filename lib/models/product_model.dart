import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final bool isRecommended;
  final bool isPopular;

  const Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.isRecommended,
    required this.isPopular,
    required this.category,
  });

  @override
  List<Object> get props => [name, imageUrl, price, isRecommended, isPopular];

  static List<Product> products = [
    const Product(
        name: 'Soft drink 1',
        imageUrl: 'https://c.ndtvimg.com/2022-01/mg0fne68_pepsi_625x300_05_January_22.jpg?im=FeatureCrop,algorithm=dnn,width=620,height=350',
        price: 2.99,
        isRecommended: true,
        isPopular: true,
        category: 'Soft Drinks'),
    const Product(
        name: 'Soft drink 2',
        imageUrl: 'https://c.ndtvimg.com/2022-01/mg0fne68_pepsi_625x300_05_January_22.jpg?im=FeatureCrop,algorithm=dnn,width=620,height=350',
        price: 2.99,
        isRecommended: true,
        isPopular: true,
        category: 'Soft Drinks'),
    const Product(
        name: 'Soft drink 3',
        imageUrl: 'https://c.ndtvimg.com/2022-01/mg0fne68_pepsi_625x300_05_January_22.jpg?im=FeatureCrop,algorithm=dnn,width=620,height=350',
        price: 2.99,
        isRecommended: true,
        isPopular: false,
        category: 'Soft Drinks'),
  ];
}
