import 'package:analytical_ecommerce/models/models.dart';
import 'package:equatable/equatable.dart';

class Checkout extends Equatable {
  final String? email;
  final String? name;
  final String? address;
  final String? city;
  final String? country;
  final String? zipCode;

  final List<Product>? products;
  final String? subtotal;
  final String? delivery;
  final String? total;

  const Checkout(this.email, this.name, this.address, this.city, this.country,
      this.zipCode, this.products, this.subtotal, this.delivery, this.total);

  @override
  List<Object?> get props => [
        email,
        name,
        address,
        city,
        country,
        zipCode,
        products,
        delivery,
        total,
        subtotal
      ];

  Map<String, Object> toDocument() {
    Map customerAddress = Map();
    customerAddress['address'] = address;
    customerAddress['city'] = city;
    customerAddress['country'] = country;
    customerAddress['zipCode'] = zipCode;
    return {
      'customerAddress': customerAddress,
      'customerName': name!,
      'customerEmail': email!,
      'products': products!.map((o) => o.name).toList(),
      'subtotal': subtotal!,
      'delivery': delivery!,
      'total': total!
    };
  }
}
