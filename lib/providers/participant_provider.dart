import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/full_payment_model.dart';
import 'package:ybb_master_app/core/models/participant_status_model.dart';
import 'package:ybb_master_app/core/models/users/complete_participant_data_model.dart';
import 'package:ybb_master_app/core/models/users/participant_essay_model.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';

class ParticipantProvider extends ChangeNotifier {
  ParticipantModel? _currentSelectedParticipant;
  List<ParticipantModel> _participants = [];
  ParticipantStatusModel? _selectedParticipantStatus;
  List<ParticipantEssayModel> _selectedParticipantEssays = [];
  List<FullPaymentModel> _selectedParticipantPayments = [];
  List<CompleteParticipantDataModel> _completeParticipants = [];

  List<ParticipantEssayModel> get selectedParticipantEssays =>
      _selectedParticipantEssays;

  set selectedParticipantEssays(List<ParticipantEssayModel> essays) {
    _selectedParticipantEssays = essays;
    notifyListeners();
  }

  void addSelectedParticipantEssay(ParticipantEssayModel essay) {
    _selectedParticipantEssays.add(essay);
    notifyListeners();
  }

  void removeSelectedParticipantEssay(ParticipantEssayModel essay) {
    _selectedParticipantEssays.remove(essay);
    notifyListeners();
  }

  void updateSelectedParticipantEssay(ParticipantEssayModel essay) {
    int index = _selectedParticipantEssays
        .indexWhere((element) => element.id == essay.id);
    _selectedParticipantEssays[index] = essay;
    notifyListeners();
  }

  void removeSelectedParticipantEssayById(String id) {
    _selectedParticipantEssays.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void clearSelectedParticipantEssays() {
    _selectedParticipantEssays.clear();
    notifyListeners();
  }

  List<FullPaymentModel> get selectedParticipantPayments =>
      _selectedParticipantPayments;

  set selectedParticipantPayments(List<FullPaymentModel> payments) {
    _selectedParticipantPayments = payments;
    notifyListeners();
  }

  void addSelectedParticipantPayment(FullPaymentModel payment) {
    _selectedParticipantPayments.add(payment);
    notifyListeners();
  }

  void removeSelectedParticipantPayment(FullPaymentModel payment) {
    _selectedParticipantPayments.remove(payment);
    notifyListeners();
  }

  void updateSelectedParticipantPayment(FullPaymentModel payment) {
    int index = _selectedParticipantPayments
        .indexWhere((element) => element.id == payment.id);
    _selectedParticipantPayments[index] = payment;
    notifyListeners();
  }

  void removeSelectedParticipantPaymentById(String id) {
    _selectedParticipantPayments.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void clearSelectedParticipantPayments() {
    _selectedParticipantPayments.clear();
    notifyListeners();
  }

  ParticipantStatusModel? get participantStatus => _selectedParticipantStatus;

  set participantStatus(ParticipantStatusModel? status) {
    _selectedParticipantStatus = status;
    notifyListeners();
  }

  void setParticipantStatus(ParticipantStatusModel status) {
    _selectedParticipantStatus = status;
    notifyListeners();
  }

  void clearParticipantStatus() {
    _selectedParticipantStatus = null;
    notifyListeners();
  }

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
