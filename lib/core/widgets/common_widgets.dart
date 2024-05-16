import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ybb_master_app/core/constants/color_constants.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CommonWidgets {
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
}
