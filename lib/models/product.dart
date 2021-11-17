

class Product {
  String id;
  String name;
  int accessibleAmount;
  int reservedAmount;
  int totalAmount;
  String unit;

  Product(
      this.id,
      this.name,
      this.unit,
      this.totalAmount,
      this.accessibleAmount,
      this.reservedAmount,
      );
}