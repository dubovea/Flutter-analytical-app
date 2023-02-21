import 'package:analytical_ecommerce/models/models.dart';

abstract class BaseCheckoutRepo {
  Future<void> addToCheckout(Checkout checkout);
}
