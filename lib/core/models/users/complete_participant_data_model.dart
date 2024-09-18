import 'package:ybb_master_app/core/models/participant_status_model.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';

class CompleteParticipantDataModel {
  ParticipantModel? participant;
  ParticipantStatusModel? participantStatus;

  CompleteParticipantDataModel({
    this.participant,
    this.participantStatus,
  });
}
