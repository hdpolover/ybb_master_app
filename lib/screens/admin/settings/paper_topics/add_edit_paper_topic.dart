import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/paper_topic_model.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_dialog.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/paper_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

import '../../../../core/services/paper_topic_service.dart';

class AddEditPaperTopic extends StatefulWidget {
  final PaperTopicModel? paperTopic;
  const AddEditPaperTopic({super.key, this.paperTopic});

  static const String routeName = "add_edit_paper_topic";
  static const String pathName = "add_edit_paper_topic";

  @override
  State<AddEditPaperTopic> createState() => _AddEditPaperTopicState();
}

class _AddEditPaperTopicState extends State<AddEditPaperTopic> {
  final _formKey = GlobalKey<FormBuilderState>();

  final _nameKey = GlobalKey<FormBuilderFieldState>();

  String? name;

  saveData() async {
    name = _nameKey.currentState!.value.toString();

    String programId = Provider.of<ProgramProvider>(context, listen: false)
        .currentProgram!
        .id!;

    if (widget.paperTopic == null) {
      // add paper topic
      PaperTopicModel paperTopic = PaperTopicModel(
        topicName: name,
        programId: programId,
      );

      // add to database
      await PaperTopicService().add(paperTopic).then((value) {
        Provider.of<PaperProvider>(context, listen: false).addPaperTopic(value);

        setState(() {
          isLoading = false;
        });

        CommonDialog.showAlertDialog(
          context,
          "Success",
          "Paper topic has been added successfully",
          isError: false,
          onConfirm: () {
            Navigator.pop(context);
            Navigator.of(context, rootNavigator: true).pop();
          },
        );
      });
    } else {
      // edit paper topic
      PaperTopicModel paperTopic = PaperTopicModel(
        id: widget.paperTopic!.id,
        topicName: name,
        programId: programId,
      );

      // edit in database
      await PaperTopicService().update(paperTopic).then((value) {
        Provider.of<PaperProvider>(context, listen: false)
            .updatePaperTopic(value);

        setState(() {
          isLoading = false;
        });

        CommonDialog.showAlertDialog(
          context,
          "Success",
          "Paper topic has been updated successfully",
          isError: false,
          onConfirm: () {
            Navigator.of(context, rootNavigator: true).pop();

            Navigator.pop(context);
          },
        );
      });
    }
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
          title: widget.paperTopic == null
              ? "Add Paper Topic"
              : "Edit Paper Topic"),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                CommonWidgets().buildTextField(
                  _nameKey,
                  "name",
                  "Paper Topic Name",
                  [FormBuilderValidators.required()],
                  initial: widget.paperTopic == null
                      ? ""
                      : widget.paperTopic!.topicName,
                ),
                const SizedBox(height: 20),
                isLoading
                    ? const LoadingWidget()
                    : CommonWidgets().buildCustomButton(
                        text: widget.paperTopic == null ? "Save" : "Update",
                        color: widget.paperTopic == null
                            ? Colors.blue
                            : Colors.orange,
                        onPressed: () {
                          if (_formKey.currentState!.saveAndValidate()) {
                            setState(() {
                              isLoading = true;
                            });

                            saveData();
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
