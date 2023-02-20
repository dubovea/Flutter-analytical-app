import 'package:analytical_ecommerce/models/models.dart';
import 'base_category_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryRepo extends BaseCategoryRepo {
  final FirebaseFirestore _firebaseFirestore;

  CategoryRepo({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Category>> getAllCategories() {
    return _firebaseFirestore
        .collection('categories')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Category.fromSnapshot(doc)).toList();
    });
  }
}
