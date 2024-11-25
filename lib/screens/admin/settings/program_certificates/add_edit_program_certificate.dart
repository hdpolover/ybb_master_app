import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/helpers/common_helper.dart';
import 'package:ybb_master_app/core/models/program_certificate_model.dart';
import 'package:ybb_master_app/core/services/program_certificate_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

class AddEditProgramCertificate extends StatefulWidget {
  final ProgramCertificateModel? certificate;
  const AddEditProgramCertificate({super.key, this.certificate});

  @override
  State<AddEditProgramCertificate> createState() =>
      _AddEditProgramCertificateState();
}

class _AddEditProgramCertificateState extends State<AddEditProgramCertificate> {
  final _formKey = GlobalKey<FormBuilderState>();

  final _titleKey = GlobalKey<FormBuilderFieldState>();
  final _descKey = GlobalKey<FormBuilderFieldState>();

  String? title, desc;

  FilePickerResult? templateFile;
  Uint8List? fileBytes;
  String? fileName;
  String? templateUrl;

  bool isLoading = false;

  saveData() {
    setState(() {
      isLoading = true;
    });

    ProgramCertificateModel data = ProgramCertificateModel(
      title: _titleKey.currentState!.value,
      description: _descKey.currentState!.value,
      programId: Provider.of<ProgramProvider>(context, listen: false)
          .currentProgram!
          .id,
    );

    print(data.programId);

    Map<String, dynamic> imageData = {
      "file_bytes": fileBytes,
      "file_name": fileName,
    };

    ProgramCertificateService().add(data, imageData).then((value) {
      setState(() {
        isLoading = false;
      });

      Provider.of<ProgramProvider>(context, listen: false)
          .addProgramCertificate(value);

      CommonHelper().showSimpleOkDialog(
        context,
        "Success",
        "Program certificate has been added successfully.",
        () {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context).pop();
        },
      );
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });

      CommonHelper().showError(context, e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
          title: widget.certificate == null
              ? "Add Program Certificate"
              : "Edit Program Certificate"),
      body: SingleChildScrollView(
        child: FormBuilder(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                CommonWidgets().buildTextField(
                  _titleKey,
                  "title",
                  "Program Certificate Title",
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(5),
                  ],
                  initial: title ?? "",
                ),
                CommonWidgets().buildTextField(
                  _descKey,
                  "description",
                  "Program Certificate Description",
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(10),
                  ],
                  initial: desc ?? "",
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Certificate Template Image",
                      style: AppTextStyleConstants.bodyTextStyle.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        // upload payment proof
                        await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'jpeg', 'png'],
                        ).then((value) {
                          // check if the file size is more than 2MB, add error message saying for file efficiency it cannot exceed 2 mb
                          if (value!.files.single.size > 2000000) {
                            CommonHelper().showSimpleOkDialog(
                                context,
                                "File size too large",
                                "Please upload a file with size less than 2MB.",
                                () {
                              Navigator.of(context, rootNavigator: true).pop();
                            });
                          } else {
                            if (value.files.single.extension != "jpg" &&
                                value.files.single.extension != "jpeg" &&
                                value.files.single.extension != "png") {
                              CommonHelper().showSimpleOkDialog(
                                  context,
                                  "Invalid file type",
                                  "Please upload a file with extension .jpg, .jpeg, or .png.",
                                  () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              });
                            } else {
                              setState(() {
                                templateFile = value;
                                fileBytes = value.files.single.bytes!;
                                fileName = value.files.single.name;
                              });
                            }
                          }
                        });
                      },
                      child: Container(
                        height: 400,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: templateFile == null
                            ? templateUrl == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 100,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Please upload a certificate template",
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ],
                                  )
                                : Image.network(
                                    templateUrl!,
                                    fit: BoxFit.cover,
                                  )
                            : Image.memory(
                                templateFile!.files.first.bytes!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                isLoading
                    ? const LoadingWidget()
                    : CommonWidgets().buildCustomButton(
                        text: "Save",
                        onPressed: () {
                          // check all fields are filled
                          if (_titleKey.currentState!.value != null &&
                              _descKey.currentState!.value != null &&
                              templateFile != null) {
                            // save the data
                            saveData();
                          } else {
                            CommonHelper().showError(
                              // show error message
                              context,
                              "Please fill in all fields.",
                            );
                          }
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
