import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';

class ProgramCertificates extends StatefulWidget {
  const ProgramCertificates({super.key});

  @override
  State<ProgramCertificates> createState() => _ProgramCertificatesState();
}

class _ProgramCertificatesState extends State<ProgramCertificates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CommonAppBar(
        title: "Certificates",
      ),
      body: SingleChildScrollView(
        child: Column(children: []),
      ),
    );
  }
}
