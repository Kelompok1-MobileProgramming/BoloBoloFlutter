class Barang {
  final String name;
  final String price;

  const Barang._(this.name, this.price);

  factory Barang.fromJson(Map json) {
    final name = json['name'];
    final price = json['price'];
    return Barang._(name, price);
  }
}
