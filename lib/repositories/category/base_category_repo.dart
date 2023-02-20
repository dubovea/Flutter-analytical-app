import 'package:analytical_ecommerce/models/models.dart';

abstract class BaseCategoryRepo {
  Stream<List<Category>> getAllCategories();
}
