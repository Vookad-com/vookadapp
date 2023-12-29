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

  @HiveField(4)
  final String pincode;

  SearchAddr({
    required this.placeName,
    required this.place,
    required this.pincode,
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
    final pincode = reader.readString();
    final lng = reader.readDouble();
    final lat = reader.readDouble();

    return SearchAddr(
      placeName: placeName,
      place: place,
      pincode: pincode,
      lng: lng,
      lat: lat,
    );
  }

  @override
  void write(BinaryWriter writer, SearchAddr obj) {
    writer.writeString(obj.placeName);
    writer.writeString(obj.place);
    writer.writeString(obj.pincode);
    writer.writeDouble(obj.lng);
    writer.writeDouble(obj.lat);
  }
}
