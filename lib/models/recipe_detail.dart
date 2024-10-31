class RecipeDetail {
  final String id;
  final String name;
  final String? category;
  final String? instructions;
  final String? thumbnailUrl;
  final String? tags;
  final String? youtubeUrl;
  final Map<String, String> ingredients;

  RecipeDetail({
    required this.id,
    required this.name,
    this.category,
    this.instructions,
    this.thumbnailUrl,
    this.tags,
    this.youtubeUrl,
    required this.ingredients,
  });

  factory RecipeDetail.fromJson(Map<String, dynamic> json, bool isMeal) {
    // Create a map to store ingredients and their measurements
    final ingredients = <String, String>{};

    // Collect ingredients and measurements
    for (var i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null && ingredient.toString().isNotEmpty) {
        ingredients[ingredient.toString()] = measure?.toString().trim() ?? '';
      }
    }

    return RecipeDetail(
      id: json['idMeal'] ?? json['idDrink'] ?? '',
      name: json['strMeal'] ?? json['strDrink'] ?? '',
      category: json['strCategory'],
      instructions: json['strInstructions'],
      thumbnailUrl: json['strMealThumb'] ?? json['strDrinkThumb'],
      tags: json['strTags'],
      youtubeUrl: json['strYoutube'],
      ingredients: ingredients,
    );
  }
}
