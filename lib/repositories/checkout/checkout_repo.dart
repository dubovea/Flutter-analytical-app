import 'package:analytical_ecommerce/models/models.dart';
import 'base_checkout_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckoutRepo extends BaseCheckoutRepo {
  final FirebaseFirestore _firebaseFirestore;

  CheckoutRepo({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addToCheckout(Checkout checkout) {
    return _firebaseFirestore.collection('checkout').add(checkout.toDocument());
  }
}
