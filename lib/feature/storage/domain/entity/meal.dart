class Meal {
  const Meal({
    required this.isFreezed,
    required this.orderedTable,
    required this.name,
  });

  final String name;
  final bool isFreezed;
  final String? orderedTable;
}
