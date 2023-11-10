import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class SearchAddr {
  @HiveField(0)
  final String placeName;

  @HiveField(1)
  final String place;

  @HiveField(2)
  final double lng;

  @HiveField(3)
  final double lat;

  SearchAddr({
    required this.placeName,
    required this.place,
    required this.lng,
    required this.lat,
  });
}

@HiveType(typeId: 3)
class SearchAddrAdapter extends TypeAdapter<SearchAddr> {
  @override
  final int typeId = 3;

  @override
  SearchAddr read(BinaryReader reader) {
    final placeName = reader.readString();
    final place = reader.readString();
    final lng = reader.readDouble();
    final lat = reader.readDouble();

    return SearchAddr(
      placeName: placeName,
      place: place,
      lng: lng,
      lat: lat,
    );
  }

  @override
  void write(BinaryWriter writer, SearchAddr obj) {
    writer.writeString(obj.placeName);
    writer.writeString(obj.place);
    writer.writeDouble(obj.lng);
    writer.writeDouble(obj.lat);
  }
}
