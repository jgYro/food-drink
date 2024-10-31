class Recipe {
  final String id;
  final String name;
  final String? thumbnailUrl;

  Recipe({
    required this.id,
    required this.name,
    this.thumbnailUrl,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['idMeal'] ?? json['idDrink'] ?? '',
      name: json['strMeal'] ?? json['strDrink'] ?? '',
      thumbnailUrl: json['strMealThumb'] ?? json['strDrinkThumb'],
    );
  }
}
