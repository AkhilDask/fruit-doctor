class FruitDetails {
  final String name;
  final int id;
  final String family;
  final String order;
  final String genus;
  final Nutritions nutritions;

  FruitDetails({
    required this.name,
    required this.id,
    required this.family,
    required this.order,
    required this.genus,
    required this.nutritions,
  });

  factory FruitDetails.fromJson(Map<String, dynamic> json) {
    return FruitDetails(
      name: json['name'],
      id: json['id'],
      family: json['family'],
      order: json['order'],
      genus: json['genus'],
      nutritions: Nutritions.fromJson(json['nutritions']),
    );
  }
}

class Nutritions {
  final int calories;
  final double fat;
  final double sugar;
  final double carbohydrates;
  final double protein;

  Nutritions({
    required this.calories,
    required this.fat,
    required this.sugar,
    required this.carbohydrates,
    required this.protein,
  });

  factory Nutritions.fromJson(Map<String, dynamic> json) {
    return Nutritions(
      calories: json['calories'],
      fat: json['fat'],
      sugar: json['sugar'],
      carbohydrates: json['carbohydrates'],
      protein: json['protein'],
    );
  }
}