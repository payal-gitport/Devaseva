class Seva {
  final int? id;
  final String? name;

  Seva({
    required this.name,
    required this.id,
  });

  factory Seva.fromJson(Map<String, dynamic> parsedJson) {
    return Seva(
      name: parsedJson['name'],
      id: parsedJson['id'],
    );
  }
}
