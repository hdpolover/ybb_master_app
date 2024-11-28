import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';

class ItemWidgetTile extends StatelessWidget {
  final String id;
  final String title;
  final String? description;
  final String? moreDesc;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ItemWidgetTile(
      {super.key,
      required this.id,
      required this.title,
      this.description,
      this.moreDesc,
      this.onTap,
      this.onEdit,
      this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: AppTextStyleConstants.bodyTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  description == null || moreDesc == null
                      ? Container()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            HtmlWidget(
                              description ?? "-",
                              textStyle:
                                  AppTextStyleConstants.bodyTextStyle.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              moreDesc ?? "-",
                              style:
                                  AppTextStyleConstants.bodyTextStyle.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
            onEdit == null || onDelete == null
                ? Container()
                : Row(
                    children: [
                      IconButton(
                        color: Colors.orange,
                        icon: const Icon(Icons.edit),
                        onPressed: onEdit,
                      ),
                      IconButton(
                        color: Colors.red,
                        icon: const Icon(Icons.delete),
                        onPressed: onDelete,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
