import 'package:analytical_ecommerce/models/models.dart';

abstract class BaseProductRepo {
  Stream<List<Product>> getAllProducts();
}