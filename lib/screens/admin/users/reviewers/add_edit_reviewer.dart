import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/models/paper_reviewer_model.dart';
import 'package:ybb_master_app/core/models/paper_reviewer_topic_model.dart';
import 'package:ybb_master_app/core/models/paper_topic_model.dart';
import 'package:ybb_master_app/core/services/paper_reviewer_service.dart';
import 'package:ybb_master_app/core/services/paper_reviewer_topic_service.dart';
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
  final _topicKey = GlobalKey<FormBuilderFieldState>();

  String? name, email, institution, password, selectedTopicId;

  List<String> topicIds = [];
  List<String> newTopicIds = [];
  List<String> deletedTopicIds = [];

  bool isLoading = false;
  bool isShowTopicInput = false;

  @override
  void initState() {
    super.initState();

    setData();
  }

  _buildTopicDropdownView() {
    List<PaperTopicModel> paperTopics =
        Provider.of<PaperProvider>(context, listen: false).paperTopics;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Topics",
          style: AppTextStyleConstants.bodyTextStyle.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        topicIds.isEmpty
            ? Center(
                child: Text(
                  "No topics selected",
                  style: AppTextStyleConstants.bodyTextStyle.copyWith(
                    color: Colors.black,
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: topicIds.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      title: Text(
                        paperTopics
                            .firstWhere(
                                (element) => element.id == topicIds[index])
                            .topicName!,
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          CommonDialog.showAlertDialog(
                            context,
                            "Delete Topic",
                            "Are you sure you want to delete this topic?",
                            isError: true,
                            onConfirm: () async {
                              setState(() {
                                deletedTopicIds.add(topicIds[index]);
                                topicIds.removeAt(index);
                              });

                              Navigator.of(context, rootNavigator: true).pop();
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
        const SizedBox(height: 10),
        topicIds.length == paperTopics.length
            ? const SizedBox()
            : isShowTopicInput
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTopicDropdownInput(),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CommonWidgets().buildCustomButton(
                              width: 200,
                              color: Colors.red,
                              text: "Cancel",
                              onPressed: () {
                                setState(() {
                                  isShowTopicInput = false;
                                });
                              },
                            ),
                            const SizedBox(width: 10),
                            CommonWidgets().buildCustomButton(
                              width: 200,
                              color: Colors.green,
                              text: "Save Topic",
                              onPressed: () async {
                                setState(() {
                                  topicIds.add(selectedTopicId!);
                                  newTopicIds.add(selectedTopicId!);
                                  isShowTopicInput = false;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : Align(
                    alignment: Alignment.centerRight,
                    child: CommonWidgets().buildCustomButton(
                      width: 200,
                      color: Colors.blue,
                      text: "Add Topic",
                      onPressed: () {
                        setState(() {
                          isShowTopicInput = true;
                        });
                      },
                    ),
                  )
      ],
    );
  }

  // build dropdown for topics
  _buildTopicDropdownInput() {
    var paperProvider = Provider.of<PaperProvider>(context);

    List<PaperTopicModel> paperTopics = List.from(paperProvider.paperTopics);

    // remove topic named "all"
    paperTopics.removeWhere((element) => element.isActive == "0");

    // remove topics that are already  in topicIds
    for (var topicId in topicIds) {
      paperTopics.removeWhere((element) => element.id == topicId);
    }

    return FormBuilderDropdown(
      key: _topicKey,
      name: "topic",
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: "Select Topic",
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
          selectedTopicId = value.toString();
        });
      },
    );
  }

  setData() {
    if (widget.reviewer != null) {
      name = widget.reviewer!.name;
      email = widget.reviewer!.email;
      institution = widget.reviewer!.institution;
      password = widget.reviewer!.password;

      List<PaperReviewerTopicModel> reviewerTopics =
          Provider.of<PaperProvider>(context, listen: false).reviewerTopics;

      for (var topic in reviewerTopics) {
        if (topic.paperReviewerId == widget.reviewer!.id) {
          topicIds.add(topic.paperTopicId!);
        }
      }

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
      programId: Provider.of<ProgramProvider>(context, listen: false)
          .currentProgram!
          .id!,
    );

    await PaperReviewerService().add(reviewer).then((value) async {
      setState(() {
        isLoading = false;
      });

      Provider.of<PaperProvider>(context, listen: false)
          .addPaperReviewer(value);

      // loop through newTopicIds and add to paper reviewer topics
      for (var topicId in newTopicIds) {
        await PaperReviewerTopicService()
            .add(PaperReviewerTopicModel(
          paperReviewerId: value.id,
          paperTopicId: topicId,
        ))
            .then((value) {
          Provider.of<PaperProvider>(context, listen: false)
              .addReviewerTopic(value);
        });
      }

      CommonDialog.showAlertDialog(
          context, "Success", "Reviewer added successfully", isError: false,
          onConfirm: () {
        Navigator.of(context, rootNavigator: true).pop();

        Navigator.pop(context);
      });
    });
  }

  update() async {
    // update data
    PaperReviewerModel reviewer = PaperReviewerModel(
      id: widget.reviewer!.id,
      name: _nameKey.currentState == null
          ? name
          : _nameKey.currentState!.value.toString(),
      email: _emailKey.currentState == null
          ? email
          : _emailKey.currentState!.value.toString(),
      institution: _instituionKey.currentState == null
          ? institution
          : _instituionKey.currentState!.value.toString(),
      password: _passwordKey.currentState == null
          ? password
          : _passwordKey.currentState!.value.toString(),
      programId: widget.reviewer!.programId,
      isActive: widget.reviewer!.isActive,
      isDeleted: widget.reviewer!.isDeleted,
      createdAt: widget.reviewer!.createdAt,
      updatedAt: widget.reviewer!.updatedAt,
    );

    await PaperReviewerService().update(reviewer).then((value) async {
      Provider.of<PaperProvider>(context, listen: false)
          .updatePaperReviewer(value);

      // if new topics are added, add them to paper reviewer topics
      for (var topicId in newTopicIds) {
        await PaperReviewerTopicService()
            .add(PaperReviewerTopicModel(
          paperReviewerId: value.id,
          paperTopicId: topicId,
        ))
            .then((value) {
          Provider.of<PaperProvider>(context, listen: false)
              .addReviewerTopic(value);
        });
      }

      // if topics are deleted, delete them from paper reviewer topics
      for (var topicId in deletedTopicIds) {
        List<PaperReviewerTopicModel> reviewerTopics =
            Provider.of<PaperProvider>(context, listen: false).reviewerTopics;

        String topicIdToDelete = "";

        for (var topic in reviewerTopics) {
          if (topic.paperReviewerId == widget.reviewer!.id &&
              topic.paperTopicId == topicId) {
            topicIdToDelete = topic.id!;
          }
        }
        await PaperReviewerTopicService().delete(topicIdToDelete).then((value) {
          Provider.of<PaperProvider>(context, listen: false)
              .removeReviewerTopic(topicIdToDelete);
        });
      }

      CommonDialog.showAlertDialog(
          context, "Success", "Reviewer updated successfully", isError: false,
          onConfirm: () {
        setState(() {
          isLoading = false;
        });

        Navigator.of(context, rootNavigator: true).pop();

        Navigator.pop(context);
      });
    }).onError((error, stackTrace) {
      setState(() {
        isLoading = false;
      });

      CommonDialog.showAlertDialog(context, "Error", error.toString(),
          isError: true);
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
                _buildTopicDropdownView(),
                const SizedBox(height: 20),
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
