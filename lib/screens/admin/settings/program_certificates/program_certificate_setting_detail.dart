import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/program_certificate_model.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';

class ProgramCertificateSettingDetail extends StatefulWidget {
  final ProgramCertificateModel certificate;
  const ProgramCertificateSettingDetail({super.key, required this.certificate});

  @override
  State<ProgramCertificateSettingDetail> createState() =>
      _ProgramCertificateSettingDetailState();
}

class _ProgramCertificateSettingDetailState
    extends State<ProgramCertificateSettingDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Certificate Detail"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets().buildTitleTextItem(
                  "Certificate Title", widget.certificate.title!),
              CommonWidgets().buildTitleTextItem(
                  "Certificate Description", widget.certificate.description!),
              CommonWidgets().buildTextImageItem(
                  context,
                  "Certificate Template Image",
                  widget.certificate.templateUrl!),
            ],
          ),
        ),
      ),
    );
  }
}
