import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/paper_reviewer_model.dart';

class ReviewerDetail extends StatefulWidget {
  final PaperReviewerModel? reviewer;
  const ReviewerDetail({super.key, this.reviewer});

  static const String routeName = "reviewer_detail";
  static const String pathName = "reviewer_detail";

  @override
  State<ReviewerDetail> createState() => _ReviewerDetailState();
}

class _ReviewerDetailState extends State<ReviewerDetail> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
