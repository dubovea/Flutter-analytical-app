part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
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
  final Checkout checkout;
  final PaymentMethod paymentMethod;

  CheckoutLoaded(
      {this.email,
      this.name,
      this.address,
      this.city,
      this.country,
      this.zipCode,
      this.products,
      this.subtotal,
      this.delivery,
      this.total,
      this.paymentMethod = PaymentMethod.google_pay})
      : checkout = Checkout(email, name, address, city, country, zipCode,
            products, subtotal, delivery, total);

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
        subtotal,
        checkout,
        paymentMethod
      ];
}
