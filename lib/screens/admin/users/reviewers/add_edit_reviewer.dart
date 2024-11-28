import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/models/paper_reviewer_model.dart';
import 'package:ybb_master_app/core/models/paper_topic_model.dart';
import 'package:ybb_master_app/core/services/paper_reviewer_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_dialog.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/paper_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

class AddEditReviewer extends StatefulWidget {
  final PaperReviewerModel? reviewer;
  const AddEditReviewer({super.key, this.reviewer});

  static const String routeName = "add_edit_reviewer";
  static const String pathName = "add_edit_reviewer";

  @override
  State<AddEditReviewer> createState() => _AddEditReviewerState();
}

class _AddEditReviewerState extends State<AddEditReviewer> {
  final _formKey = GlobalKey<FormBuilderState>();

  final _nameKey = GlobalKey<FormBuilderFieldState>();
  final _emailKey = GlobalKey<FormBuilderFieldState>();
  final _instituionKey = GlobalKey<FormBuilderFieldState>();
  final _passwordKey = GlobalKey<FormBuilderFieldState>();
  final _radioKey = GlobalKey<FormBuilderFieldState>();
  final _topicKey = GlobalKey<FormBuilderFieldState>();

  String? name, email, institution, password, topicAccess, topicId;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    setData();
  }

  // create radio button for topic access. values are "specifi" and "all"
  _buildTopicAccessRadioButton() {
    return FormBuilderRadioGroup(
      key: _radioKey,
      name: "topic_access",
      options: ["specific", "all"]
          .map((e) => FormBuilderFieldOption(value: e))
          .toList(growable: false),
      decoration: InputDecoration(
        label: Text(
          "Topic Access",
          style: AppTextStyleConstants.bodyTextStyle.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      validator: FormBuilderValidators.required(),
      onChanged: (value) {
        setState(() {
          topicAccess = value.toString();
        });
      },
      initialValue: topicAccess ?? "specific",
    );
  }

  // build dropdown for topics
  _buildTopicDropdown() {
    var paperProvider = Provider.of<PaperProvider>(context);

    List<PaperTopicModel> paperTopics = List.from(paperProvider.paperTopics);

    // remove topic named "all"
    paperTopics.removeWhere((element) => element.topicName == "all");

    return FormBuilderDropdown(
      key: _topicKey,
      name: "topic",
      decoration: InputDecoration(
        label: Text(
          "Topic",
          style: AppTextStyleConstants.bodyTextStyle.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      validator: FormBuilderValidators.required(),
      items: paperTopics
          .map((e) => DropdownMenuItem(
                value: e.id,
                child: Text(e.topicName!),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          topicId = value.toString();
        });
      },
      initialValue: topicId ?? paperTopics[0].id,
    );
  }

  setData() {
    if (widget.reviewer != null) {
      name = widget.reviewer!.name;
      email = widget.reviewer!.email;
      institution = widget.reviewer!.institution;
      password = widget.reviewer!.password;
      topicAccess = widget.reviewer!.topicAccess;
      topicId = widget.reviewer!.paperTopicId;

      setState(() {});
    }
  }

  save() async {
    // save data
    PaperReviewerModel reviewer = PaperReviewerModel(
      name: _nameKey.currentState!.value.toString(),
      email: _emailKey.currentState!.value.toString(),
      institution: _instituionKey.currentState!.value.toString(),
      password: _passwordKey.currentState!.value.toString(),
      topicAccess: _radioKey.currentState!.value.toString(),
      paperTopicId: topicAccess == "all"
          ? Provider.of<PaperProvider>(context, listen: false)
              .paperTopics
              .firstWhere((element) => element.topicName == "all")
              .id!
          : _topicKey.currentState!.value.toString(),
      programId: Provider.of<ProgramProvider>(context, listen: false)
          .currentProgram!
          .id!,
    );

    await PaperReviewerService().add(reviewer).then((value) {
      setState(() {
        isLoading = false;
      });

      Provider.of<PaperProvider>(context, listen: false)
          .addPaperReviewer(value);

      CommonDialog.showAlertDialog(
          context, "Success", "Reviewer added successfully", isError: false,
          onConfirm: () {
        Navigator.of(context, rootNavigator: true).pop();

        Navigator.pop(context);
      });
    });
  }

  update() {
    // update data
    PaperReviewerModel reviewer = PaperReviewerModel(
      id: widget.reviewer!.id,
      name: _nameKey.currentState!.value.toString(),
      email: _emailKey.currentState!.value.toString(),
      institution: _instituionKey.currentState!.value.toString(),
      password: _passwordKey.currentState!.value.toString(),
      topicAccess: _radioKey.currentState!.value.toString(),
      paperTopicId: _topicKey.currentState!.value.toString(),
      programId: widget.reviewer!.programId,
    );

    PaperReviewerService().update(reviewer).then((value) {
      setState(() {
        isLoading = false;
      });

      Provider.of<PaperProvider>(context, listen: false)
          .updatePaperReviewer(widget.reviewer!);

      CommonDialog.showAlertDialog(
          context, "Success", "Reviewer updated successfully", isError: false,
          onConfirm: () {
        Navigator.of(context, rootNavigator: true).pop();

        Navigator.pop(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: widget.reviewer == null ? "Add Reviewer" : "Edit Reviewer",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                _buildTopicAccessRadioButton(),
                const SizedBox(height: 20),
                topicAccess == "all" ? Container() : _buildTopicDropdown(),
                topicAccess == "all" ? Container() : const SizedBox(height: 20),
                CommonWidgets().buildTextField(
                  _emailKey,
                  "email",
                  "Reviewer Email",
                  [
                    FormBuilderValidators.required(),
                  ],
                  initial: email,
                ),
                CommonWidgets().buildTextField(
                  _nameKey,
                  "name",
                  "Reviewer Name",
                  [
                    FormBuilderValidators.required(),
                  ],
                  initial: name,
                ),
                CommonWidgets().buildTextField(
                  _instituionKey,
                  "institution",
                  "Institution Name",
                  [
                    FormBuilderValidators.required(),
                  ],
                  initial: institution,
                ),
                CommonWidgets().buildTextField(
                  _passwordKey,
                  "password",
                  "Login Password",
                  [
                    FormBuilderValidators.required(),
                  ],
                  initial: password,
                ),
                isLoading
                    ? const LoadingWidget()
                    : CommonWidgets().buildCustomButton(
                        width: 200,
                        color: widget.reviewer == null
                            ? Colors.blue
                            : Colors.orange,
                        text: widget.reviewer == null ? "Save" : "Update",
                        onPressed: () {
                          if (_formKey.currentState!.saveAndValidate()) {
                            setState(() {
                              isLoading = true;
                            });

                            if (widget.reviewer == null) {
                              // add reviewer
                              save();
                            } else {
                              // update reviewer
                              update();
                            }
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
