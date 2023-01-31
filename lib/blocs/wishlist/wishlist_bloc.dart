import 'package:analytical_ecommerce/models/models.dart';
import 'package:analytical_ecommerce/models/wishlist_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<StartWishlist>(_onLoadWishList);
    on<AddProductWishlist>(_onAddProductWishlist);
    on<RemoveProductWishlist>(_onRemoveProductWishlist);
  }

  void _onLoadWishList(StartWishlist event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    try {
      await Future<void>.delayed(Duration(seconds: 1));
      emit(const WishlistLoaded());
    } catch (_) {}
  }

  void _onAddProductWishlist(
      AddProductWishlist event, Emitter<WishlistState> emit) async {
    final state = this.state;
    if (state is WishlistLoaded) {
      try {
        emit(WishlistLoaded(
            wishlist: Wishlist(
                products: List.from(state.wishlist.products)
                  ..add(event.product))));
      } catch (_) {}
    }
  }

  void _onRemoveProductWishlist(
      RemoveProductWishlist event, Emitter<WishlistState> emit) async {
    final state = this.state;
    if (state is WishlistLoaded) {
      try {
        emit(WishlistLoaded(
            wishlist: Wishlist(
                products: List.from(state.wishlist.products)
                  ..remove(event.product))));
      } catch (_) {}
    }
  }
}
