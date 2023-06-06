import 'package:analytical_ecommerce/models/models.dart';
import 'package:hive/hive.dart';

abstract class BaseLocalStorageRepo {
  Future<Box> openBox();
  Future<Box> clearWishlist(Box box);
  List<Product> getWishlist(Box box);
  Future<void> addProductToWishlist(Box box, Product product);
  Future<void> removeProductFromWishlist(Box box, Product product);
}
