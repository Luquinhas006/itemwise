class Product {
  final int? id;
  final String name;
  final String image;
  final String subtitle;
  final double unitPrice;

  Product({
      this.id
    , required this.name
    , required this.image
    , required this.subtitle
    , required this.unitPrice
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'subtitle': subtitle,
      'image': image,
      'unitPrice': unitPrice,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      subtitle: map['subtitle'],
      image: map['image'],
      unitPrice: map['unitPrice'],
    );
  }
}