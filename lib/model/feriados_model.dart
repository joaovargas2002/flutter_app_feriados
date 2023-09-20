class FeriadosEntity {
  String? date;
  String? name;
  String? type;

  FeriadosEntity({
    this.date,
    this.name,
    this.type,
  });

  static FeriadosEntity mapToEntity(Map<String, dynamic> map) {
    return FeriadosEntity(
      date: map['date'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
    );
  }
}
