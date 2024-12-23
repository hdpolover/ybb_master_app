// import paper abstract, paper author, paper detail models

import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/paper_abstract_model.dart';
import 'package:ybb_master_app/core/models/paper_author_model.dart';
import 'package:ybb_master_app/core/models/paper_detail_model.dart';
import 'package:ybb_master_app/screens/reviewers/dashboard_reviewer.dart';

class ReviewerPaperProvider extends ChangeNotifier {
  List<PaperAbstractModel> _paperAbstracts = [];
  List<PaperDetailModel> _paperDetails = [];
  List<PaperAuthorModel> _paperAuthors = [];
  List<ReviewerPaperData> _reviewerPaperData = [];

  List<ReviewerPaperData> get reviewerPaperData => _reviewerPaperData;

  set reviewerPaperData(List<ReviewerPaperData> data) {
    _reviewerPaperData = data;
    notifyListeners();
  }

  void addReviewerPaperData(ReviewerPaperData data) {
    _reviewerPaperData.add(data);
    notifyListeners();
  }

  void removeReviewerPaperData(ReviewerPaperData data) {
    _reviewerPaperData.remove(data);
    notifyListeners();
  }

  void updateReviewerPaperData(ReviewerPaperData data) {
    int index = _reviewerPaperData.indexWhere(
        (element) => element.paperDetail!.id == data.paperDetail!.id);
    _reviewerPaperData[index] = data;
    notifyListeners();
  }

  void removeReviewerPaperDataById(String id) {
    _reviewerPaperData.removeWhere((element) => element.paperDetail!.id == id);
    notifyListeners();
  }

  void clearReviewerPaperData() {
    _reviewerPaperData.clear();
    notifyListeners();
  }

  List<PaperAbstractModel> get paperAbstracts => _paperAbstracts;

  set paperAbstracts(List<PaperAbstractModel> abstracts) {
    _paperAbstracts = abstracts;
    notifyListeners();
  }

  void addPaperAbstract(PaperAbstractModel abstract) {
    _paperAbstracts.add(abstract);
    notifyListeners();
  }

  void removePaperAbstract(PaperAbstractModel abstract) {
    _paperAbstracts.remove(abstract);
    notifyListeners();
  }

  void updatePaperAbstract(PaperAbstractModel abstract) {
    int index =
        _paperAbstracts.indexWhere((element) => element.id == abstract.id);
    _paperAbstracts[index] = abstract;
    notifyListeners();
  }

  void removePaperAbstractById(String id) {
    _paperAbstracts.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void clearPaperAbstracts() {
    _paperAbstracts.clear();
    notifyListeners();
  }

  List<PaperDetailModel> get paperDetails => _paperDetails;

  set paperDetails(List<PaperDetailModel> details) {
    _paperDetails = details;
    notifyListeners();
  }

  void addPaperDetail(PaperDetailModel detail) {
    _paperDetails.add(detail);
    notifyListeners();
  }

  void removePaperDetail(PaperDetailModel detail) {
    _paperDetails.remove(detail);
    notifyListeners();
  }

  void updatePaperDetail(PaperDetailModel detail) {
    int index = _paperDetails.indexWhere((element) => element.id == detail.id);
    _paperDetails[index] = detail;
    notifyListeners();
  }

  void removePaperDetailById(String id) {
    _paperDetails.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void clearPaperDetails() {
    _paperDetails.clear();
    notifyListeners();
  }

  List<PaperAuthorModel> get paperAuthors => _paperAuthors;

  set paperAuthors(List<PaperAuthorModel> authors) {
    _paperAuthors = authors;
    notifyListeners();
  }

  void addPaperAuthor(PaperAuthorModel author) {
    _paperAuthors.add(author);
    notifyListeners();
  }

  void removePaperAuthor(PaperAuthorModel author) {
    _paperAuthors.remove(author);
    notifyListeners();
  }

  void updatePaperAuthor(PaperAuthorModel author) {
    int index = _paperAuthors.indexWhere((element) => element.id == author.id);
    _paperAuthors[index] = author;
    notifyListeners();
  }

  void removePaperAuthorById(String id) {
    _paperAuthors.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void clearPaperAuthors() {
    _paperAuthors.clear();
    notifyListeners();
  }
}
