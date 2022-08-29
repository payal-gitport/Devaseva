import 'package:devaseva/models/campaign.dart';

class CampaignsList {
  final List<Campaign> campaignsList;

  CampaignsList({
    required this.campaignsList,
  });

  factory CampaignsList.fromJson(List json) {
    final _campaignsList = json;

    return CampaignsList(
      campaignsList: _campaignsList.map((i) => Campaign.fromJson(i)).toList(),
    );
  }
}
