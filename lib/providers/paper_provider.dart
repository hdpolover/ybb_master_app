import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/paper_author_model.dart';
import 'package:ybb_master_app/core/models/paper_reviewer_model.dart';
import 'package:ybb_master_app/core/models/paper_reviewer_topic_model.dart';
import 'package:ybb_master_app/core/models/paper_topic_model.dart';

class PaperProvider extends ChangeNotifier {
  List<PaperReviewerModel> _paperReviewers = [];
  List<PaperTopicModel> _paperTopics = [];
  List<PaperAuthorModel> _paperAuthors = [];
  PaperReviewerModel? _currentReviewer;
  List<PaperReviewerTopicModel> _reviewerTopics = [];

  List<PaperAuthorModel> get paperAuthors => _paperAuthors;

  set paperAuthors(List<PaperAuthorModel> paperAuthors) {
    _paperAuthors = paperAuthors;
    notifyListeners();
  }

  void addPaperAuthor(PaperAuthorModel paperAuthor) {
    _paperAuthors.add(paperAuthor);
    notifyListeners();
  }

  void removePaperAuthor(PaperAuthorModel paperAuthor) {
    _paperAuthors.remove(paperAuthor);
    notifyListeners();
  }

  PaperReviewerModel? get currentReviewer => _currentReviewer;

  set reviewerTopics(List<PaperReviewerTopicModel> reviewerTopics) {
    _reviewerTopics = reviewerTopics;
    notifyListeners();
  }

  List<PaperReviewerTopicModel> get reviewerTopics => _reviewerTopics;

  // clear reviewer topics
  void clearReviewerTopics() {
    _reviewerTopics = [];
    notifyListeners();
  }

  // add reviewer topic
  void addReviewerTopic(PaperReviewerTopicModel reviewerTopic) {
    _reviewerTopics.add(reviewerTopic);
    notifyListeners();
  }

  // remove reviewer topic
  void removeReviewerTopic(String idToDelete) {
    _reviewerTopics.removeWhere((element) => element.id == idToDelete);

    notifyListeners();
  }

  // update reviewer topic
  void updateReviewerTopic(PaperReviewerTopicModel reviewerTopic) {
    final index =
        _reviewerTopics.indexWhere((element) => element.id == reviewerTopic.id);

    if (index >= 0) {
      _reviewerTopics[index] = reviewerTopic;
      notifyListeners();
    }
  }

  set currentReviewer(PaperReviewerModel? currentReviewer) {
    _currentReviewer = currentReviewer;
    notifyListeners();
  }

  void clearCurrentReviewer() {
    _currentReviewer = null;
    notifyListeners();
  }

  List<PaperTopicModel> get paperTopics => _paperTopics;

  set paperTopics(List<PaperTopicModel> paperTopics) {
    _paperTopics = paperTopics;
    notifyListeners();
  }

  void addPaperTopic(PaperTopicModel paperTopic) {
    _paperTopics.add(paperTopic);
    notifyListeners();
  }

  void removePaperTopic(PaperTopicModel paperTopic) {
    _paperTopics.remove(paperTopic);
    notifyListeners();
  }

  void updatePaperTopic(PaperTopicModel paperTopic) {
    final index =
        _paperTopics.indexWhere((element) => element.id == paperTopic.id);

    if (index >= 0) {
      _paperTopics[index] = paperTopic;
      notifyListeners();
    }
  }

  List<PaperReviewerModel> get paperReviewers => _paperReviewers;

  set paperReviewers(List<PaperReviewerModel> paperReviewers) {
    _paperReviewers = paperReviewers;
    notifyListeners();
  }

  void addPaperReviewer(PaperReviewerModel paperReviewer) {
    _paperReviewers.add(paperReviewer);
    notifyListeners();
  }

  void removePaperReviewer(PaperReviewerModel paperReviewer) {
    _paperReviewers.remove(paperReviewer);
    notifyListeners();
  }

  void updatePaperReviewer(PaperReviewerModel paperReviewer) {
    final index =
        _paperReviewers.indexWhere((element) => element.id == paperReviewer.id);

    if (index >= 0) {
      _paperReviewers[index] = paperReviewer;
      notifyListeners();
    }
  }
}
