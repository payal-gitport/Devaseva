import 'package:devaseva/models/seva.dart';

class SevasList {
  final List<Seva> sevasList;

  SevasList({
    required this.sevasList,
  });

  factory SevasList.fromJson(List json) {
    final _sevasList = json;

    return SevasList(
      sevasList: _sevasList.map((i) => Seva.fromJson(i)).toList(),
    );
  }
}
