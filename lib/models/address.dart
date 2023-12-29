class AddressInst{
  final String label;
  final String area;
  final String building;
  final String landmark;
  final String pincode;
  final String id;
  final List<Object?> location;

  AddressInst({
    required this.label,
    required this.area,
    required this.pincode,
    required this.building,
    required this.id,
    required this.landmark,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'location': {
        'type': 'Point',
        'coordinates': location,
      },
      'label': [label],
      'building': building,
      'pincode': pincode,
      'area': area,
      'landmark': landmark,
    };
  }
}