class Meal {
  const Meal({
    required this.isFreezed,
    required this.orderedTable,
    required this.name,
    required this.id,
  });

  final String name;
  final bool isFreezed;
  final String? orderedTable;
  final String? id;
}
