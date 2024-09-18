import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/users/complete_participant_data_model.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';

class ParticipantProvider extends ChangeNotifier {
  ParticipantModel? _currentSelectedParticipant;
  List<ParticipantModel> _participants = [];
  List<CompleteParticipantDataModel> _completeParticipants = [];

  List<CompleteParticipantDataModel> get completeParticipants =>
      _completeParticipants;

  set completeParticipants(List<CompleteParticipantDataModel> participants) {
    _completeParticipants = participants;
    notifyListeners();
  }

  void addCompleteParticipant(CompleteParticipantDataModel participant) {
    _completeParticipants.add(participant);
    notifyListeners();
  }

  void removeCompleteParticipant(CompleteParticipantDataModel participant) {
    _completeParticipants.remove(participant);
    notifyListeners();
  }

  void updateCompleteParticipant(CompleteParticipantDataModel participant) {
    int index = _completeParticipants.indexWhere(
        (element) => element.participant!.id == participant.participant!.id);
    _completeParticipants[index] = participant;
    notifyListeners();
  }

  void removeCompleteParticipantById(String id) {
    _completeParticipants
        .removeWhere((element) => element.participant!.id == id);
    notifyListeners();
  }

  ParticipantModel? get currentSelectedParticipant =>
      _currentSelectedParticipant;

  set currentSelectedParticipant(ParticipantModel? participant) {
    _currentSelectedParticipant = participant;
    notifyListeners();
  }

  void updateSelectedParticipant(ParticipantModel participant) {
    _currentSelectedParticipant = participant;
    notifyListeners();
  }

  void removeCurrentSelectedParticipant() {
    _currentSelectedParticipant = null;
    notifyListeners();
  }

  List<ParticipantModel> get participants => _participants;

  set participants(List<ParticipantModel> participants) {
    _participants = participants;
    notifyListeners();
  }

  void addParticipant(ParticipantModel participant) {
    _participants.add(participant);
    notifyListeners();
  }

  void removeParticipant(ParticipantModel participant) {
    _participants.remove(participant);
    notifyListeners();
  }

  void updateParticipant(ParticipantModel participant) {
    int index =
        _participants.indexWhere((element) => element.id == participant.id);
    _participants[index] = participant;
    notifyListeners();
  }

  void removeParticipantById(String id) {
    _participants.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void clearParticipants() {
    _participants.clear();
    notifyListeners();
  }

  void clearCurrentSelectedParticipant() {
    _currentSelectedParticipant = null;
    notifyListeners();
  }

  void clearAll() {
    _participants.clear();
    _currentSelectedParticipant = null;
    notifyListeners();
  }

  void addParticipants(List<ParticipantModel> participants) {
    _participants.addAll(participants);
    notifyListeners();
  }
}
