import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String imageUrl;

  const Category({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [name, imageUrl];

  static List<Category> categories = [
    const Category(
      name: 'Soft Drinks',
      imageUrl:
          'https://cdn.punchng.com/wp-content/uploads/2017/03/29201341/soft-drinks.png',
    ),
    const Category(
      name: 'Smoothies',
      imageUrl:
          'https://static.1000.menu/img/content-v2/cb/1d/58130/fruktovyi-smuzi-v-blendere_1629916238_11_max.jpg',
    ),
    const Category(
      name: 'Water',
      imageUrl:
          'https://n1s1.hsmedia.ru/d9/bb/18/d9bb182555a1997fdfe1d00527ffbef7/1200x800_0xac120003_8897376241615828724.jpg',
    ),
  ];
}
