library;

class PaymentPlan {
  final String id;
  final String name;
  final double price;
  final String description;

  const PaymentPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });
}
