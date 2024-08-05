import 'package:pharmacy/products/Product.dart';

class Catalog {
  List<Product> _products = [
      Product(name: 'Aspirina', image: 'assets/images/aspirina.png', subtitle: 'Alívio da Dor', unitPrice: 10.59),
      Product(name: 'Novalgina', image: 'assets/images/novalgina.png', subtitle: 'Alívio da Dor', unitPrice: 23),
      Product(name: 'Energil C', image: 'assets/images/energilc.png', subtitle: 'Vitamina C', unitPrice: 20.69),
      Product(name: 'Dorflex', image: 'assets/images/dorflex.png', subtitle: 'Alívio da Dor', unitPrice: 22.52),
      Product(name: 'Ivermectina', image: 'assets/images/ivermectina.png', subtitle: 'Antiparasitário', unitPrice: 16.81),
    ];

  List<Product> getAll() {
    return _products;
  }
}