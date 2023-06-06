import 'package:analytical_ecommerce/models/models.dart';
import 'package:hive/hive.dart';
import 'base_local_storage_repo.dart';

class LocalStorageRepo extends BaseLocalStorageRepo {
  String boxName = 'wishlist_products';
  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<Product>(boxName);
    return box;
  }

  @override
  Future<Box> clearWishlist(Box box) async {
    await box.clear();
    return box;
  }

  @override
  List<Product> getWishlist(Box box) {
    return box.values.toList() as List<Product>;
  }

  @override
  Future<void> addProductToWishlist(Box box, Product product) async {
    await box.put(product.id, product);
  }

  @override
  Future<void> removeProductFromWishlist(Box box, Product product) async {
    await box.delete(product.id);
  }
}
