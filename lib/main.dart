import 'package:flutter/material.dart';

import 'models/campaign_list.dart';
import 'models/seva.dart';
import 'models/seva_list.dart';
import 'services/service.dart';
import 'models/campaign.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<CampaignsList> getCampaignList;
  late List<Campaign> campaignList = [];

  late Future<SevasList> getSevasList;
  late List<Seva> sevasList;

  bool _isLoading = true;
  bool _isSevaLoading = true;

  @override
  void initState() {
    super.initState();
    getCampaignList = fetchCampaign();
    getCampaignList.then((value) {
      setState(() {
        campaignList = value.campaignsList;
        _isLoading = false;

        for (var i = campaignList.length - 1; i >= 0; i--) {
          getSevasList = fetchSeva(campaignList[i].id);
          getSevasList.then((value) {
            setState(() {
              sevasList = value.sevasList;
              campaignList[i].sevaList = sevasList;
              _isSevaLoading = false;
              print("Seva List Done");
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('DevaSeva'),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator(strokeWidth: 4))
            : SingleChildScrollView(
                child: ExpansionPanelList.radio(
                  expandedHeaderPadding: EdgeInsets.all(0),
                  dividerColor: Colors.transparent,
                  // initialOpenPanelValue: campaignList[0].id,
                  children: campaignList.map<ExpansionPanelRadio>((Campaign campaign) {
                    return ExpansionPanelRadio(
                      value: campaign.id,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          leading: SizedBox(),
                          title: Text(
                            campaign.name,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                      body: SingleChildScrollView(
                        child: _sevaListView(campaign.sevaList),
                      ),
                    );
                  }).toList(),
                ),
              ),
      ),
    );
  }

  Widget _sevaListView(List<Seva> sevasList) {
    return
        // sevasList.length == 0
        // ? Padding(
        //     padding: const EdgeInsets.only(bottom: 18.0),
        //     child: Text("Upcoming soon"),
        //   )
        // :
        _isSevaLoading
            ? Padding(
                padding: const EdgeInsets.all(18.0),
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: sevasList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: SizedBox(),
                    title: Text(
                      sevasList[index].name.toString(),
                    ),
                  );
                });
  }
}
