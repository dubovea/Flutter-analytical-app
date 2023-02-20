import 'dart:async';

import 'package:analytical_ecommerce/models/models.dart';
import 'package:analytical_ecommerce/repositories/product/product_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo _productRepo;
  StreamSubscription? _productSubscription;

  ProductBloc({required ProductRepo productRepo})
      : _productRepo = productRepo,
        super(ProductLoading()) {
    on<LoadProduct>(_onLoadProduct);
    on<UpdateProducts>(_onUpdateProducts);
  }

  void _onLoadProduct(LoadProduct event, Emitter<ProductState> emit) async {
    try {
      _productSubscription?.cancel();
      _productSubscription = _productRepo
          .getAllProducts()
          .listen((products) => add(UpdateProducts(products)));
    } catch (_) {}
  }

  void _onUpdateProducts(
      UpdateProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      emit(ProductLoaded(products: event.products));
    } catch (_) {}
  }
}
