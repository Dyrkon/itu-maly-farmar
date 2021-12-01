

class Product {
  String id;
  String productName;
  String sellersName;
  var accessibleAmount;
  var reservedAmount;
  var totalAmount;
  String unit;

  Product(
      this.id,
      this.productName,
      this.sellersName,
      this.unit,
      this.totalAmount,
      this.accessibleAmount,
      this.reservedAmount,
      );
}