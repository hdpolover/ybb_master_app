import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ybb_master_app/core/models/participant_certificate_model.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';

class AddEditProgramCertificateForParticipant extends StatefulWidget {
  final ParticipantCertificateModel? participantCertificate;
  const AddEditProgramCertificateForParticipant(
      {super.key, this.participantCertificate});

  @override
  State<AddEditProgramCertificateForParticipant> createState() =>
      _AddEditProgramCertificateForParticipantState();
}

class _AddEditProgramCertificateForParticipantState
    extends State<AddEditProgramCertificateForParticipant> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
          title: widget.participantCertificate == null
              ? "Add Participant Certificate"
              : "Edit Participant Certificate"),
      body: SingleChildScrollView(
        child: FormBuilder(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Container(),
          ),
        ),
      ),
    );
  }
}
