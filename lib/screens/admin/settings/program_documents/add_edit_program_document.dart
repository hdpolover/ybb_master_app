import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/program_document_model.dart';
import 'package:ybb_master_app/core/services/program_document_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

class AddEditProgramDocument extends StatefulWidget {
  final ProgramDocumentModel? programDocument;

  const AddEditProgramDocument({super.key, this.programDocument});

  @override
  State<AddEditProgramDocument> createState() => _AddEditProgramDocumentState();
}

class _AddEditProgramDocumentState extends State<AddEditProgramDocument> {
  final _nameKey = GlobalKey<FormBuilderFieldState>();
  final _descKey = GlobalKey<FormBuilderFieldState>();
  final _driveUrlKey = GlobalKey<FormBuilderFieldState>();
  final _isGenerateKey = GlobalKey<FormBuilderFieldState>();
  final _isUploadKey = GlobalKey<FormBuilderFieldState>();
  final _orderKey = GlobalKey<FormBuilderFieldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  String? documentName, documentDesc, driveUrl;

  bool isLoading = false;

  Map<String, dynamic> isGenerated = {
    "0": "No",
    "1": "Yes",
  };

  Map<String, dynamic> isUpload = {
    "0": "No",
    "1": "Yes",
  };

  @override
  void initState() {
    super.initState();

    setValue();
  }

  void setValue() {
    if (widget.programDocument != null) {
      documentName = widget.programDocument!.name;
      documentDesc = widget.programDocument!.desc;
    }
  }

  save() async {
    if (_formKey.currentState!.saveAndValidate()) {
      setState(() {
        isLoading = true;
      });

      ProgramDocumentModel document = ProgramDocumentModel(
        programId: Provider.of<ProgramProvider>(context, listen: false)
            .currentProgram!
            .id,
        name: _nameKey.currentState!.value,
        desc: _descKey.currentState!.value,
        driveUrl: _driveUrlKey.currentState!.value,
        isGenerated: _isGenerateKey.currentState!.value == "1" ? "1" : "0",
        isUpload: _isUploadKey.currentState!.value == "1" ? "1" : "0",
        visibility: "1",
      );

      if (widget.programDocument != null) {
        document.id = widget.programDocument!.id;

        await ProgramDocumentService().update(document).then((value) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Document updated successfully'),
            ),
          );

          Provider.of<ProgramProvider>(context, listen: false)
              .updateProgramDocument(value);

          Navigator.pop(context);
        }).catchError((e, s) {
          print(s);

          setState(() {
            isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        });
      } else {
        await ProgramDocumentService().add(document).then((value) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Document added successfully'),
            ),
          );

          Provider.of<ProgramProvider>(context, listen: false)
              .addProgramDocument(value);

          Navigator.pop(context);
        }).catchError((e, s) {
          print(s);

          setState(() {
            isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
          title: widget.programDocument == null
              ? "Add Program Document"
              : "Edit Program Document"),
      body: SingleChildScrollView(
        child: FormBuilder(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                CommonWidgets().buildTextField(
                  _nameKey,
                  "name",
                  "Document Name",
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(5),
                  ],
                  initial: documentName ?? "",
                ),
                CommonWidgets().buildTextField(
                  _descKey,
                  "description",
                  "Document Description",
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(10),
                  ],
                  initial: documentDesc ?? "",
                ),
                CommonWidgets().buildTextField(
                  _driveUrlKey,
                  "driveUrl",
                  "Google Drive URL",
                  [FormBuilderValidators.required()],
                  initial: driveUrl ?? "",
                ),
                CommonWidgets().buildRadioField(
                  _isGenerateKey,
                  "is_generated",
                  "Does it need to be generated?",
                  isGenerated,
                  [
                    FormBuilderValidators.required(),
                  ],
                ),
                CommonWidgets().buildRadioField(
                  _isUploadKey,
                  "is_upload",
                  "Does it need to be uploaded?",
                  isUpload,
                  [
                    FormBuilderValidators.required(),
                  ],
                ),
                isLoading
                    ? const LoadingWidget()
                    : CommonWidgets().buildCustomButton(
                        text: "Save",
                        onPressed: () {
                          save();
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
