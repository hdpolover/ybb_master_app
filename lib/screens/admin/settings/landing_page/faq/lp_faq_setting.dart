import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/services/faq_service.dart';
import 'package:ybb_master_app/providers/faq_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/screens/admin/settings/landing_page/faq/faq_item.dart';

class LpFaqSetting extends StatefulWidget {
  const LpFaqSetting({super.key});

  @override
  State<LpFaqSetting> createState() => _LpFaqSettingState();
}

class _LpFaqSettingState extends State<LpFaqSetting> {
  List<String> categories = [];

  @override
  void initState() {
    super.initState();

    getFaqs();
  }

  getFaqs() async {
    String programId = Provider.of<ProgramProvider>(context, listen: false)
        .currentProgram!
        .id!;
    // get the FAQs
    await FaqService().getProgramFaqs(programId).then((value) {
      Provider.of<FaqProvider>(context, listen: false).faqs = value;

      // get the categories
      List<String> temp = [];

      for (var faq in value) {
        if (!temp.contains(faq.faqCategory)) {
          temp.add(faq.faqCategory!);
        }
      }

      setState(() {
        categories = temp;
      });
    });
  }

  buildFaqBasedOnCategory(String category) {
    var faqProvider = Provider.of<FaqProvider>(context);

    Map<String, String> categoryData = {
      "event_details": "Event Details",
      "registration": "Registration",
      "payments": "Payments",
    };

    String categoryText = categoryData[category] ?? category;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            categoryText,
            style: AppTextStyleConstants.bodyTextStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: faqProvider.faqs.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (faqProvider.faqs[index].faqCategory == category) {
              return FaqItem(faq: faqProvider.faqs[index]);
            } else {
              return const SizedBox();
            }
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var faqProvider = Provider.of<FaqProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: faqProvider.faqs.isEmpty
              ? const Center(
                  child: Text("No FAQs available"),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return buildFaqBasedOnCategory(categories[index]);
                  },
                ),
        ),
      ),
    );
  }
}
