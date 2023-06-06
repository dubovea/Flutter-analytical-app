import 'package:analytical_ecommerce/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<LoadCart>(_onLoadCart);
    on<AddProductToCart>(_onAddProductToCart);
    on<RemoveProductFromCart>(_onRemoveProductFromCart);
  }

  void _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const CartLoaded());
    } catch (_) {}
  }

  void _onAddProductToCart(
      AddProductToCart event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        if (!state.cart.products.toList().contains(event.product)) {
          return emit(CartLoaded(
              cart: Cart(
                  products: List.from(state.cart.products)
                    ..add(event.product))));
        }
        emit(CartLoaded(cart:
            Cart(products: List.from(state.cart.products.map((Product product) {
          if (product.name == event.product.name) {
            return Product(
                id: product.id,
                name: product.name,
                imageUrl: product.imageUrl,
                price: product.price,
                isRecommended: product.isRecommended,
                isPopular: product.isPopular,
                category: product.category,
                count: product.count + 1);
          }
          return product;
        })))));
      } catch (_) {}
    }
  }

  void _onRemoveProductFromCart(
      RemoveProductFromCart event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        Product findedProduct = List.from(state.cart.products)
            .firstWhere((element) => element.name == event.product.name);
        if (findedProduct.count == 1) {
          return emit(CartLoaded(
              cart: Cart(
                  products: List.from(state.cart.products)
                    ..remove(event.product))));
        }
        emit(CartLoaded(cart:
            Cart(products: List.from(state.cart.products.map((Product product) {
          if (product.name == event.product.name) {
            return Product(
                id: product.id,
                name: product.name,
                imageUrl: product.imageUrl,
                price: product.price,
                isRecommended: product.isRecommended,
                isPopular: product.isPopular,
                category: product.category,
                count: product.count - 1);
          }
          return product;
        })))));
      } catch (_) {}
    }
  }
}
