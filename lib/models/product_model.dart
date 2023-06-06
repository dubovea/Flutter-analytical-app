import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String category;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final bool isRecommended;
  @HiveField(6)
  final bool isPopular;
  @HiveField(7)
  int count;

  Product(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.price,
      required this.isRecommended,
      required this.isPopular,
      required this.category,
      this.count = 1});

  @override
  List<Object> get props =>
      [id, name, imageUrl, price, isRecommended, isPopular, count];

  static Product fromSnapshot(snapshot) {
    Product product = Product(
        id: snapshot.id,
        name: snapshot['name'],
        imageUrl: snapshot['imageUrl'],
        category: snapshot['category'],
        isPopular: snapshot['isPopular'],
        isRecommended: snapshot['isRecommended'],
        price: snapshot['price']);
    return product;
  }

  static List<Product> products = [
    Product(
        id: '1',
        name: 'PEPSI',
        imageUrl:
            'https://c.ndtvimg.com/2022-01/mg0fne68_pepsi_625x300_05_January_22.jpg?im=FeatureCrop,algorithm=dnn,width=620,height=350',
        price: 2.99,
        isRecommended: true,
        isPopular: true,
        category: 'Soft Drinks'),
    Product(
        id: '2',
        name: 'COCA COLA',
        imageUrl:
            'https://sun9-53.userapi.com/impg/tGWbpy5unaNqjDd473U0p4S9f9I2IjMMWkG5Ew/fN-67csrgZs.jpg?size=807x538&quality=95&sign=4bf42db3b10d9db46013d544847cdf88&type=album',
        price: 1.44,
        isRecommended: true,
        isPopular: true,
        category: 'Soft Drinks'),
    Product(
        id: '3',
        name: 'FANTA',
        imageUrl:
            'https://kupivody.ru/wp-content/uploads/2022/06/fantamango0355banka.jpeg',
        price: 2.58,
        isRecommended: true,
        isPopular: false,
        category: 'Soft Drinks'),
  ];
}
