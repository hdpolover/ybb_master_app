import 'package:clipboard/clipboard.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ybb_master_app/core/constants/color_constants.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CommonWidgets {
  static Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static Widget buildError(String message) {
    return Center(
      child: Text(message),
    );
  }

  buildTitleTextItem(String label, String text,
      {bool isCopyable = false, BuildContext? context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyleConstants.bodyTextStyle.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          isCopyable
              ? Row(
                  children: [
                    Text(
                      text,
                      style: AppTextStyleConstants.bodyTextStyle,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.copy,
                        color: AppColorConstants.kPrimaryColor,
                      ),
                      onPressed: () {
                        // copy to clipboard
                        FlutterClipboard.copy(text).then((value) {
                          ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
                            content: Text("Copied ($text) to clipboard"),
                          ));
                        });
                      },
                    )
                  ],
                )
              : Text(
                  text,
                  style: AppTextStyleConstants.bodyTextStyle,
                ),
        ],
      ),
    );
  }

  buildCopyableTextItem(String text, BuildContext? context) {
    return Row(
      children: [
        Text(
          text,
          style: AppTextStyleConstants.bodyTextStyle,
        ),
        IconButton(
          icon: const Icon(
            Icons.copy,
            color: AppColorConstants.kPrimaryColor,
          ),
          onPressed: () {
            // copy to clipboard
            FlutterClipboard.copy(text).then((value) {
              ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
                content: Text("Copied ($text) to clipboard"),
              ));
            });
          },
        )
      ],
    );
  }

  buildTextImageItem(BuildContext context, String label, String imgUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyleConstants.bodyTextStyle.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              showImageViewer(
                context,
                Image.network(imgUrl).image,
                useSafeArea: true,
                swipeDismissible: true,
                doubleTapZoomable: true,
              );
            },
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Image.network(imgUrl)),
          )
        ],
      ),
    );
  }

  buildCustomButton(
      {double? width,
      Color? color,
      required String text,
      required Function() onPressed}) {
    return MaterialButton(
      minWidth: width ?? double.infinity,
      height: 7.h,
      color: color ?? AppColorConstants.kPrimaryColor,
      // give radius to the button
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: onPressed,
      child: Text(text, style: AppTextStyleConstants.buttonTextStyle),
    );
  }

  buildTextField(Key key, String name, String hintText,
      List<FormFieldValidator> validators,
      {String? desc, dynamic initial, int? lines}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: AppTextStyleConstants.bodyTextStyle.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Visibility(
              visible: desc != null,
              child: Column(
                children: [
                  Text(
                    (desc ?? ""),
                    style: AppTextStyleConstants.bodyTextStyle
                      ..copyWith(color: Colors.red),
                  ),
                  const SizedBox(height: 15),
                ],
              )),
          FormBuilderTextField(
            maxLines: lines ?? 1,
            key: key,
            name: name,
            initialValue: initial,
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            validator: FormBuilderValidators.compose(validators),
          ),
        ],
      ),
    );
  }

  buildRadioField(Key key, String name, String hintText,
      Map<String, dynamic> options, List<FormFieldValidator> validators,
      {String? desc, dynamic initial, int? lines}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: AppTextStyleConstants.bodyTextStyle.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Visibility(
              visible: desc != null,
              child: Column(
                children: [
                  Text(
                    (desc ?? ""),
                    style: AppTextStyleConstants.bodyTextStyle
                      ..copyWith(color: Colors.red),
                  ),
                  const SizedBox(height: 15),
                ],
              )),
          FormBuilderRadioGroup(
            key: key,
            name: name,
            initialValue: initial,
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            validator: FormBuilderValidators.compose(validators),
            options: options.entries
                .map((e) =>
                    FormBuilderFieldOption(value: e.key, child: Text(e.value)))
                .toList(),
          ),
        ],
      ),
    );
  }

  buildDateField(Key key, String name, String hintText,
      List<FormFieldValidator> validators,
      {String? desc, dynamic initial, int? lines}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: AppTextStyleConstants.bodyTextStyle.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Visibility(
              visible: desc != null,
              child: Column(
                children: [
                  Text(
                    (desc ?? ""),
                    style: AppTextStyleConstants.bodyTextStyle
                      ..copyWith(color: Colors.red),
                  ),
                  const SizedBox(height: 15),
                ],
              )),
          FormBuilderDateTimePicker(
            key: key,
            name: name,
            initialValue: initial,
            inputType: InputType.date,
            format: DateFormat("yyyy-MM-dd"),
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            validator: FormBuilderValidators.compose(validators),
          ),
        ],
      ),
    );
  }

  buildDropdownField(Key key, String name, String hintText,
      List<FormFieldValidator> validators, List<DropdownMenuItem> items,
      {String? desc, dynamic initial, int? lines}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: AppTextStyleConstants.bodyTextStyle.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Visibility(
              visible: desc != null,
              child: Column(
                children: [
                  Text(
                    (desc ?? ""),
                    style: AppTextStyleConstants.bodyTextStyle
                      ..copyWith(color: Colors.red),
                  ),
                  const SizedBox(height: 15),
                ],
              )),
          FormBuilderDropdown(
            items: items,
            key: key,
            name: name,
            initialValue: initial,
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            validator: FormBuilderValidators.compose(validators),
          ),
        ],
      ),
    );
  }

  buildQuilEditor(QuillController controller, String hintText,
      {String? desc, dynamic initial, int? lines}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: AppTextStyleConstants.bodyTextStyle.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Visibility(
              visible: desc != null,
              child: Column(
                children: [
                  Text(
                    (desc ?? ""),
                    style: AppTextStyleConstants.bodyTextStyle
                      ..copyWith(color: Colors.red),
                  ),
                  const SizedBox(height: 15),
                ],
              )),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: double.infinity,
            height: 300,
            child: QuillToolbarProvider(
              toolbarConfigurations: const QuillToolbarConfigurations(
                sharedConfigurations: QuillSharedConfigurations(
                  locale: Locale('en'),
                ),
              ),
              child: Column(
                children: [
                  QuillSimpleToolbar(
                    controller: controller,
                    configurations: const QuillSimpleToolbarConfigurations(),
                  ),
                  Expanded(
                    child: QuillEditor.basic(
                      controller: controller,
                      configurations: const QuillEditorConfigurations(),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
