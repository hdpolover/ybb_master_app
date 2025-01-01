import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';

class AddRevision extends StatefulWidget {
  const AddRevision({super.key});

  static const String routeName = "add_revision";
  static const String pathName = "/add-revision";

  @override
  State<AddRevision> createState() => _AddRevisionState();
}

class _AddRevisionState extends State<AddRevision> {
  final _formKey = GlobalKey<FormState>();

  final _commentKey = GlobalKey<FormFieldState>();

  bool _isLoading = false;

  saveComment() {
    if (_formKey.currentState!.validate()) {
      // save the comment

      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CommonAppBar(
          title: "Add Revision",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  CommonWidgets().buildTextField(
                    _commentKey,
                    "comment",
                    "Revision Comment",
                    [
                      FormBuilderValidators.required(
                          errorText: "Please enter your comment"),
                    ],
                    lines: 5,
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const LoadingWidget()
                      : CommonWidgets().buildCustomButton(
                          text: "Save Comment",
                          onPressed: saveComment,
                        ),
                ],
              ),
            ),
          ),
        ));
  }
}
