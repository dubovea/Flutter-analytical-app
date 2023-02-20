import 'dart:async';

import 'package:analytical_ecommerce/models/category_model.dart';
import 'package:analytical_ecommerce/repositories/category/category_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepo _categoryRepo;
  StreamSubscription? _categorySubscription;

  CategoryBloc({required CategoryRepo categoryRepo})
      : _categoryRepo = categoryRepo,
        super(CategoryLoading()) {
    on<LoadCategory>(_onLoadCategory);
    on<UpdateCategories>(_onUpdateCategories);
  }

  void _onLoadCategory(LoadCategory event, Emitter<CategoryState> emit) async {
    try {
      _categorySubscription?.cancel();
      _categorySubscription = _categoryRepo
          .getAllCategories()
          .listen((categories) => add(UpdateCategories(categories)));
    } catch (_) {}
  }

  void _onUpdateCategories(
      UpdateCategories event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      emit(CategoryLoaded(categories: event.categories));
    } catch (_) {}
  }
}
