

class Product {
  String id;
  String productName;
  String sellersName;
  int accessibleAmount;
  int reservedAmount;
  int totalAmount;
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