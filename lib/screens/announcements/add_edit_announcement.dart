import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/helpers/common_helper.dart';
import 'package:ybb_master_app/core/models/program_announcement/program_announcement_model.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/program_announcement_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

import '../../core/services/program_announcement_service.dart';

class AddEditAnnouncement extends StatefulWidget {
  final ProgramAnnouncementModel? announcement;
  const AddEditAnnouncement({super.key, this.announcement});

  @override
  State<AddEditAnnouncement> createState() => _AddEditAnnouncementState();
}

class _AddEditAnnouncementState extends State<AddEditAnnouncement> {
  final _titleKey = GlobalKey<FormBuilderFieldState>();

  QuillController _controller = QuillController.basic();

  FilePickerResult? photoFile;
  Uint8List? fileBytes;
  String? fileName;
  String? profileUrl;

  int visibleTo = 0;
  Map<int, String> visibleToMap = {
    0: "Public (Everyone that visits the site)",
    1: "Participants (All participants that have accounts)",
    2: "Program Participants (Participants that have at least paid registration)",
  };

  String titleInitialValue = "";

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    checkData();
  }

  checkData() {
    if (widget.announcement != null) {
      titleInitialValue = widget.announcement!.title!;
      // convert html to quill delta and set it to the controller
      _controller.document.insert(0, widget.announcement!.description!);

      visibleTo = int.parse(widget.announcement!.visibleTo!);
      profileUrl = widget.announcement!.imgUrl;
    }

    setState(() {});
  }

  getFormattedQuil() {
    final deltaJson = _controller.document.toDelta().toJson();

    final converter = QuillDeltaToHtmlConverter(List.castFrom(deltaJson));

    final html = converter.convert();

    print(html);

    return html;
  }

  saveData() async {
    setState(() {
      isLoading = true;
    });

    String formattedContent = getFormattedQuil();

    Map<String, dynamic> data = {
      'program_id': Provider.of<ProgramProvider>(context, listen: false)
          .currentProgram!
          .id,
      'title': _titleKey.currentState!.value,
      'description': formattedContent,
      'visible_to': visibleTo.toString(),
      'file_bytes': fileBytes!,
      'file_name': fileName,
    };

    await ProgramAnnouncementService().save(data).then((value) {
      setState(() {
        isLoading = false;
      });

      Provider.of<ProgramAnnouncementProvider>(context, listen: false)
          .addAnnouncement(value);

      CommonHelper().showSimpleOkDialog(
        context,
        "Success",
        "Announcement has been saved.",
        () {
          context.pop();
          context.pop();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "Add or Edit Announcement"),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidgets().buildTextField(
                  _titleKey,
                  "title",
                  "Title",
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(3),
                  ],
                  initial: titleInitialValue,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Poster Image",
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
                              Navigator.pop(context);
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
                                Navigator.pop(context);
                              });
                            } else {
                              setState(() {
                                photoFile = value;
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
                        child: photoFile == null
                            ? profileUrl == null
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
                                        "Please upload a photo",
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ],
                                  )
                                : Image.network(
                                    profileUrl!,
                                    fit: BoxFit.cover,
                                  )
                            : Image.memory(
                                photoFile!.files.first.bytes!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ],
                ),
                CommonWidgets().buildQuilEditor(_controller, "Content"),
                Text(
                  "Visible To",
                  style: AppTextStyleConstants.bodyTextStyle.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                FormBuilderRadioGroup(
                  name: 'visible_to',
                  initialValue: visibleTo,
                  onChanged: (value) {
                    setState(() {
                      visibleTo = value as int;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    isDense: false,
                  ),
                  validator: FormBuilderValidators.required(),
                  options: visibleToMap.entries
                      .map((e) => FormBuilderFieldOption(
                            value: e.key,
                            child: Text(e.value),
                          ))
                      .toList(growable: false),
                ),
                const SizedBox(height: 20),
                isLoading
                    ? const LoadingWidget()
                    : CommonWidgets().buildCustomButton(
                        text: "Save",
                        onPressed: () {
                          // check all fields are filled
                          if (_titleKey.currentState!.value != null &&
                              _controller.document.toPlainText().isNotEmpty &&
                              photoFile != null) {
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
            )),
      ),
    );
  }
}
