import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/campaign_list.dart';
import '../models/seva_list.dart';

Future<CampaignsList> fetchCampaign() async {
  final response =
      await http.get(Uri.parse('https://testapi.devaseva.com/api/campaigns/getFeaturedCampaigns/'));

  if (response.statusCode == 200) {
    return CampaignsList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Campaign');
  }
}

Future<SevasList> fetchSeva(int campaignId) async {
  print(Uri.parse('https://testapi.devaseva.com/api/campaigns/GetAllSevas/$campaignId'));
  final response = await http
      .get(Uri.parse('https://testapi.devaseva.com/api/campaigns/GetAllSevas/$campaignId'));

  if (response.statusCode == 200) {
    return SevasList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Campaign');
  }
}
