import 'package:devaseva/models/seva.dart';

class Campaign {
  final int id;
  final String name;
  List<Seva> sevaList = [];

  Campaign({
    required this.name,
    required this.id,
  });

  factory Campaign.fromJson(Map<String, dynamic> parsedJson) {
    return Campaign(
      name: parsedJson['name'],
      id: parsedJson['id'],
    );
  }
}
