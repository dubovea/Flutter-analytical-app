import 'dart:async';

import 'package:analytical_ecommerce/blocs/cart/cart_bloc.dart';
import 'package:analytical_ecommerce/blocs/payment/payment_bloc.dart';
import 'package:analytical_ecommerce/models/models.dart';
import 'package:analytical_ecommerce/repositories/checkout/checkout_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc _cartBloc;
  final PaymentBloc _paymentBloc;
  final CheckoutRepo _checkoutRepo;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _paymentSubscription;
  StreamSubscription? _checkoutSubscription;

  CheckoutBloc({
    required CartBloc cartBloc,
    required PaymentBloc paymentBloc,
    required CheckoutRepo checkoutRepo,
  })  : _cartBloc = cartBloc,
        _paymentBloc = paymentBloc,
        _checkoutRepo = checkoutRepo,
        super(cartBloc.state is CartLoaded
            ? CheckoutLoaded(
                products: (cartBloc.state as CartLoaded).cart.products,
                subtotal: (cartBloc.state as CartLoaded).cart.subtotalString,
                delivery: (cartBloc.state as CartLoaded).cart.deliveryString,
                total: (cartBloc.state as CartLoaded).cart.totalString,
              )
            : CheckoutLoading()) {
    _cartSubscription = cartBloc.stream.listen((state) {
      if (state is CartLoaded) {
        add(UpdateCheckout(cart: state.cart));
      }
    });

    _paymentSubscription = paymentBloc.stream.listen((state) {
      if (state is PaymentLoaded) {
        add(UpdateCheckout(paymentMethod: state.paymentMethod));
      }
    });
    on<UpdateCheckout>(_onUpdateCheckout);
    on<ConfirmCheckout>(_onConfirmCheckout);
  }
  void _onUpdateCheckout(
      UpdateCheckout event, Emitter<CheckoutState> emit) async {
    final state = this.state;
    if (state is CheckoutLoaded) {
      try {
        emit(CheckoutLoaded(
            paymentMethod: event.paymentMethod ?? state.paymentMethod,
            email: event.email ?? state.email,
            name: event.name ?? state.name,
            products: event.cart?.products ?? state.products,
            delivery: event.cart?.deliveryString ?? state.delivery,
            subtotal: event.cart?.subtotalString ?? state.subtotal,
            total: event.cart?.totalString ?? state.total,
            address: event.address ?? state.address,
            city: event.city ?? state.city,
            country: event.country ?? state.country,
            zipCode: event.zipCode ?? state.zipCode));
      } catch (_) {}
    }
  }

  void _onConfirmCheckout(
      ConfirmCheckout event, Emitter<CheckoutState> emit) async {
    _checkoutSubscription?.cancel();
    if (state is CheckoutLoaded) {
      try {
        await _checkoutRepo.addToCheckout(event.checkout);
        print('Done add to checkout');
        emit(CheckoutLoading());
      } catch (_) {}
    }
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    _paymentSubscription?.cancel();
    return super.close();
  }
}
