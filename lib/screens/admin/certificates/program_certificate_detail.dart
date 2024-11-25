import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/participant_certificate_model.dart';
import 'package:ybb_master_app/core/models/program_certificate_model.dart';
import 'package:ybb_master_app/core/services/participant_certificate_service.dart';
import 'package:ybb_master_app/core/services/program_certificate_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/screens/admin/settings/item_widget_tile.dart';

class ProgramCertificateDetail extends StatefulWidget {
  final ProgramCertificateModel? programCertificate;
  const ProgramCertificateDetail({super.key, this.programCertificate});

  @override
  State<ProgramCertificateDetail> createState() =>
      _ProgramCertificateDetailState();
}

class _ProgramCertificateDetailState extends State<ProgramCertificateDetail>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  List<ParticipantCertificateModel> participantCertificates = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    getParticipantData();
  }

  getParticipantData() async {
    //get data
    await ParticipantCertificateService()
        .getAll(widget.programCertificate!.id!)
        .then((value) {
      //set data
      participantCertificates = value;

      setState(() {});
    });
  }

  _buildTabAndContainer() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            isScrollable: true,
            tabs: const [
              Tab(
                text: "Participants",
              ),
              Tab(
                text: "Certificate Details",
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildParticipants(),
              _buildCertificateDetails(),
            ],
          ),
        ),
      ],
    );
  }

  _buildCertificateDetails() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidgets().buildTitleTextItem(
              "Certificate Name",
              widget.programCertificate!.title!,
            ),
            CommonWidgets().buildTitleTextItem(
              "Certificate Description",
              widget.programCertificate!.description!,
            ),
            CommonWidgets().buildTextImageItem(
              context,
              "Certificate Image",
              widget.programCertificate!.templateUrl!,
            ),
          ],
        ),
      ),
    );
  }

  _buildParticipants() {
    return participantCertificates.isEmpty
        ? const Center(
            child: Text("No participants found"),
          )
        : ListView.builder(
            itemCount: participantCertificates.length,
            itemBuilder: (context, index) {
              return ItemWidgetTile(
                id: participantCertificates[index].id!,
                title: participantCertificates[index].participantId!,
                description: "",
                moreDesc: "",
                onTap: () {},
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "Certificate Details",
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getParticipantData();
        },
        child: const Icon(Icons.add),
      ),
      body: _buildTabAndContainer(),
    );
  }
}
