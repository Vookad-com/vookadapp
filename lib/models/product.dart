import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Product extends HiveObject {
  final String pdtId;
  final String categoryId;
  int quantity;

  Product({
    required this.pdtId,
    required this.categoryId,
    this.quantity = 1, // Default quantity is 1.
  });
}

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final typeId = 1;

  @override
  Product read(BinaryReader reader) {
    final pdtId = reader.readString();
    final categoryId = reader.readString();
    final quantity = reader.readInt();

    return Product(
      pdtId: pdtId,
      categoryId: categoryId,
      quantity: quantity,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer.writeString(obj.pdtId);
    writer.writeString(obj.categoryId);
    writer.writeInt(obj.quantity);
  }
}
