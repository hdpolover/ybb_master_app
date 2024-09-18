import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/program_announcement/program_announcement_model.dart';

class ProgramAnnouncementProvider extends ChangeNotifier {
  List<ProgramAnnouncementModel> _announcements = [];

  List<ProgramAnnouncementModel> get announcements => _announcements;

  set announcements(List<ProgramAnnouncementModel> announcements) {
    _announcements = announcements;
    notifyListeners();
  }

  void addAnnouncement(ProgramAnnouncementModel announcement) {
    _announcements.add(announcement);
    notifyListeners();
  }

  void removeAnnouncement(ProgramAnnouncementModel announcement) {
    _announcements.remove(announcement);
    notifyListeners();
  }

  void updateAnnouncement(ProgramAnnouncementModel announcement) {
    int index =
        _announcements.indexWhere((element) => element.id == announcement.id);
    _announcements[index] = announcement;
    notifyListeners();
  }

  void removeCurrentAnnouncements() {
    _announcements = [];
    notifyListeners();
  }

  void removeAnnouncementById(String id) {
    _announcements.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
