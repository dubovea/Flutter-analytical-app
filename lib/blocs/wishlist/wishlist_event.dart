part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class StartWishlist extends WishlistEvent {}

class AddProductWishlist extends WishlistEvent {
  final Product product;

  const AddProductWishlist(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveProductWishlist extends WishlistEvent {
  final Product product;

  const RemoveProductWishlist(this.product);

  @override
  List<Object> get props => [product];
}
