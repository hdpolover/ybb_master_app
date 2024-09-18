import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/faq_model.dart';

class FaqProvider extends ChangeNotifier {
  List<FaqModel> _faqs = [];

  List<FaqModel> get faqs => _faqs;

  set faqs(List<FaqModel> faqs) {
    _faqs = faqs;
    notifyListeners();
  }

  void addFaq(FaqModel faq) {
    _faqs.add(faq);
    notifyListeners();
  }

  void removeFaq(FaqModel faq) {
    _faqs.remove(faq);
    notifyListeners();
  }

  void updateFaq(FaqModel faq) {
    int index = _faqs.indexWhere((element) => element.id == faq.id);
    _faqs[index] = faq;
    notifyListeners();
  }

  void removeFaqById(String id) {
    _faqs.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void clearFaqs() {
    _faqs.clear();
    notifyListeners();
  }
}
