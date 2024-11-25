import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/models/faq_model.dart';

class FaqItem extends StatelessWidget {
  final FaqModel faq;
  const FaqItem({super.key, required this.faq});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(
          faq.question!,
          style: AppTextStyleConstants.pageTitleTextStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(faq.answer!),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {},
        ),
      ),
    );
  }
}
