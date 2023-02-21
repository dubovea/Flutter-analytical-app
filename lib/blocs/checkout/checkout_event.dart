part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCheckout extends CheckoutEvent {
  final String? email;
  final String? name;
  final String? address;
  final String? city;
  final String? country;
  final String? zipCode;
  final Cart? cart;

  const UpdateCheckout(
      {this.email,
      this.name,
      this.address,
      this.city,
      this.country,
      this.zipCode,
      this.cart});

  @override
  List<Object?> get props =>
      [email, name, address, city, country, zipCode, cart];
}

class ConfirmCheckout extends CheckoutEvent {
  final Checkout checkout;

  const ConfirmCheckout({required this.checkout});

  @override
  List<Object> get props => [checkout];
}
