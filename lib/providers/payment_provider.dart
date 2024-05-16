import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/full_payment_model.dart';

class PaymentProvider extends ChangeNotifier {
  List<FullPaymentModel> _payments = [];
  List<FullPaymentModel> _filteredPayments = [];

  List<FullPaymentModel> get filteredPayments => _filteredPayments;

  set filteredPayments(List<FullPaymentModel> filteredPayments) {
    _filteredPayments = filteredPayments;
    notifyListeners();
  }

  List<FullPaymentModel> get payments => _payments;

  set payments(List<FullPaymentModel> payments) {
    _payments = payments;
    notifyListeners();
  }

  void addPayment(FullPaymentModel payment) {
    _payments.add(payment);
    notifyListeners();
  }

  void removePayment(FullPaymentModel payment) {
    _payments.remove(payment);
    notifyListeners();
  }

  void updatePayment(FullPaymentModel payment) {
    int index = _payments.indexWhere((element) => element.id == payment.id);
    _payments[index] = payment;
    notifyListeners();
  }

  FullPaymentModel? getPaymentById(String id) {
    return _payments.firstWhere((element) => element.id == id);
  }

  void clearPayments() {
    _payments = [];
    notifyListeners();
  }

  void removePaymentById(String id) {
    _payments.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
