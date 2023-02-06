import 'package:analytical_ecommerce/models/models.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final List<Product> products;

  const Cart({this.products = const <Product>[]});

  double get subtotal => products.fold(
      0, (total, current) => total + (current.price * current.count));

  double deliveryPrice(double subtotal) {
    if (subtotal > 30) {
      return 0;
    }
    return 10;
  }

  double total(double subtotal) {
    return subtotal + deliveryPrice(subtotal);
  }

  String freeDelivery(double subtotal) {
    if (subtotal >= 30) {
      return 'У вас бесплатная доставка';
    }
    double missing = 30 - subtotal;
    return 'Добавьте на \$${missing.toStringAsFixed(2)}, для бесп. доставки';
  }


  String get subtotalString => subtotal.toStringAsFixed(2);

  String get deliveryString => deliveryPrice(subtotal).toStringAsFixed(2);

  String get freeDeliveryString => freeDelivery(subtotal);

  String get totalString => total(subtotal).toStringAsFixed(2);

  @override
  List<Object> get props => [products];
}
