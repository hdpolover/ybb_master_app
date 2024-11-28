import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/paper_reviewer_model.dart';
import 'package:ybb_master_app/core/models/paper_topic_model.dart';

class PaperProvider extends ChangeNotifier {
  List<PaperReviewerModel> _paperReviewers = [];
  List<PaperTopicModel> _paperTopics = [];
  PaperReviewerModel? _currentReviewer;

  PaperReviewerModel? get currentReviewer => _currentReviewer;

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
