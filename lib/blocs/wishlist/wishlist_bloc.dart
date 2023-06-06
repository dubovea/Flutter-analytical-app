import 'package:analytical_ecommerce/models/models.dart';
import 'package:analytical_ecommerce/repositories/local_storage/local_storage_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final LocalStorageRepo _localStorageRepo;
  WishlistBloc({required LocalStorageRepo localStorageRepo})
      : _localStorageRepo = localStorageRepo,
        super(WishlistLoading()) {
    on<StartWishlist>(_onLoadWishList);
    on<AddProductWishlist>(_onAddProductWishlist);
    on<RemoveProductWishlist>(_onRemoveProductWishlist);
  }

  void _onLoadWishList(StartWishlist event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    try {
      Box box = await _localStorageRepo.openBox();
      List<Product> products = _localStorageRepo.getWishlist(box);
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(WishlistLoaded(wishlist: Wishlist(products: products)));
    } catch (_) {}
  }

  void _onAddProductWishlist(
      AddProductWishlist event, Emitter<WishlistState> emit) async {
    final state = this.state;
    if (state is WishlistLoaded) {
      try {
        Box box = await _localStorageRepo.openBox();
        _localStorageRepo.addProductToWishlist(box, event.product);
        if (!state.wishlist.products.toList().contains(event.product)) {
          emit(WishlistLoaded(
              wishlist: Wishlist(
                  products: List.from(state.wishlist.products)
                    ..add(event.product))));
        }
      } catch (_) {}
    }
  }

  void _onRemoveProductWishlist(
      RemoveProductWishlist event, Emitter<WishlistState> emit) async {
    final state = this.state;
    if (state is WishlistLoaded) {
      try {
        Box box = await _localStorageRepo.openBox();
        _localStorageRepo.removeProductFromWishlist(box, event.product);
        emit(WishlistLoaded(
            wishlist: Wishlist(
                products: List.from(state.wishlist.products)
                  ..remove(event.product))));
      } catch (_) {}
    }
  }
}
