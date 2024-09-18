import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ybb_master_app/core/models/faq_model.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';

class AddEditFaq extends StatefulWidget {
  final FaqModel? faq;
  const AddEditFaq({super.key, this.faq});

  @override
  State<AddEditFaq> createState() => _AddEditFaqState();
}

class _AddEditFaqState extends State<AddEditFaq> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: widget.faq == null ? "Add FAQ" : "Edit FAQ"),
      body: SingleChildScrollView(
        child: FormBuilder(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
