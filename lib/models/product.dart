//autor: Matěj Mudra
//
//
//
class Product {
  String id;
  String productName;
  String sellersID;
  var accessibleAmount;
  var reservedAmount;
  var totalAmount;
  var price;
  var imagePath;
  String unit;
  String description;
  bool offered;

  Product(
    this.id,
    this.productName,
    this.sellersID,
    this.unit,
    this.totalAmount,
    this.accessibleAmount,
    this.reservedAmount,
    this.price,
    this.description,
    this.offered,
  );
}
