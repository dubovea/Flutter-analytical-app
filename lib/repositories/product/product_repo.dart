import 'package:analytical_ecommerce/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'base_product_repo.dart';

class ProductRepo extends BaseProductRepo {
  final FirebaseFirestore _firebaseFirestore;

  ProductRepo({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }
}
