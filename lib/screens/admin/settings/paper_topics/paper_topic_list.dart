import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/paper_topic_model.dart';
import 'package:ybb_master_app/core/services/paper_topic_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/providers/paper_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/screens/admin/settings/item_widget_tile.dart';
import 'package:ybb_master_app/screens/admin/settings/paper_topics/add_edit_paper_topic.dart';

class PaperTopicList extends StatefulWidget {
  const PaperTopicList({super.key});

  static const String routeName = "paper_topic_list";
  static const String pathName = "paper_topic_list";

  @override
  State<PaperTopicList> createState() => _PaperTopicListState();
}

class _PaperTopicListState extends State<PaperTopicList> {
  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    String programId = Provider.of<ProgramProvider>(context, listen: false)
        .currentProgram!
        .id!;

    await PaperTopicService().getAll(programId).then((value) {
      Provider.of<PaperProvider>(context, listen: false).paperTopics = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var paperProvider = Provider.of<PaperProvider>(context);

    List<PaperTopicModel> paperTopics = List.from(paperProvider.paperTopics);

    // remove topic named "all"
    paperTopics.removeWhere((element) => element.topicName == "all");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Paper Topics"),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          context.pushNamed(AddEditPaperTopic.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        itemCount: paperTopics.length,
        itemBuilder: (context, index) {
          PaperTopicModel paperTopic = paperTopics[index];

          return ItemWidgetTile(
            id: paperTopic.id!,
            title: paperTopic.topicName!,
            onEdit: () {
              context.pushNamed(AddEditPaperTopic.routeName, extra: paperTopic);
            },
            onDelete: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Delete Paper Topic"),
                    content: const Text(
                        "Are you sure you want to delete this paper topic?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          await PaperTopicService()
                              .delete(paperTopic.id!)
                              .then((value) {
                            paperProvider.removePaperTopic(paperTopic);
                            Navigator.of(context).pop();
                          });
                        },
                        child: const Text("Delete"),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
