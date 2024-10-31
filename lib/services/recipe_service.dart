import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';
import '../models/recipe_detail.dart';
import '../widgets/recipe_list.dart';

class RecipeService {
  // Remove 'www.' from the base URLs
  static const String _mealBaseUrl = 'themealdb.com';
  static const String _cocktailBaseUrl = 'thecocktaildb.com';

  Future<List<Recipe>> getRecipes(
      List<String> ingredients, RecipeType type) async {
    if (ingredients.isEmpty) {
      print('No ingredients provided');
      return [];
    }

    final baseUrl = type == RecipeType.meal ? _mealBaseUrl : _cocktailBaseUrl;
    final ingredientString = ingredients.join(',');

    // Create URI with the correct path structure
    final uri = Uri.https(
        baseUrl, '/api/json/v2/1/filter.php', {'i': ingredientString});

    // Log request details
    print('Making request to: ${uri.toString()}');
    print('Recipe type: ${type.toString()}');
    print('Ingredients: $ingredients');
    print('Encoded ingredients: $ingredientString');

    try {
      final response = await http.get(uri);

      // Log response details
      print('Response status code: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Raw response body: ${response.body}');

      if (response.statusCode == 200) {
        // Check if response body is empty or null
        if (response.body.isEmpty) {
          print('Response body is empty');
          return [];
        }

        // Try to decode the JSON response
        final Map<String, dynamic> data;
        try {
          data = json.decode(response.body) as Map<String, dynamic>;
          print('Decoded JSON data: $data');
        } catch (e) {
          print('JSON decode error: $e');
          print('Response body that caused error: ${response.body}');
          return [];
        }

        // Check if meals/drinks is null or not a list
        final List<dynamic> items = data['meals'] ?? data['drinks'] ?? [];
        print('Found ${items.length} items in response');

        // Convert items to Recipe objects
        final recipes = items
            .map((json) {
              try {
                final recipe = Recipe.fromJson(json as Map<String, dynamic>);
                print('Successfully parsed recipe: ${recipe.name}');
                return recipe;
              } catch (e) {
                print('Error parsing recipe: $e');
                print('Problematic JSON: $json');
                return null;
              }
            })
            .whereType<Recipe>()
            .toList();

        print('Successfully parsed ${recipes.length} recipes');
        return recipes;
      } else if (response.statusCode == 404) {
        print('404 Not Found error');
        return [];
      } else {
        print('HTTP error: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print('Network error: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<RecipeDetail?> getRecipeDetail(String id, RecipeType type) async {
    final baseUrl = type == RecipeType.meal ? _mealBaseUrl : _cocktailBaseUrl;
    final version = type == RecipeType.meal ? 'v1' : 'v1';

    final uri = Uri.https(
      baseUrl,
      '/api/json/$version/1/lookup.php',
      {'i': id},
    );

    print('Fetching recipe detail from: $uri');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data['meals'] ?? data['drinks'] ?? [];

        if (items.isNotEmpty) {
          return RecipeDetail.fromJson(
            items.first as Map<String, dynamic>,
            type == RecipeType.meal,
          );
        }
      }

      print('Failed to fetch recipe detail: ${response.statusCode}');
      return null;
    } catch (e) {
      print('Error fetching recipe detail: $e');
      return null;
    }
  }
}
