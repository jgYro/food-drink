import 'package:flutter/material.dart';
import '../services/recipe_service.dart';
import '../models/recipe.dart';
import '../screens/recipe_detail_screen.dart';

enum RecipeType { meal, cocktail }

class RecipeList extends StatelessWidget {
  final List<String> ingredients;
  final RecipeType type;

  const RecipeList({
    super.key,
    required this.ingredients,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    if (ingredients.isEmpty) {
      return const Center(
        child: Text('Add ingredients to see recipes'),
      );
    }

    return FutureBuilder<List<Recipe>>(
      future: RecipeService().getRecipes(ingredients, type),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final recipes = snapshot.data ?? [];
        if (recipes.isEmpty) {
          return const Center(child: Text('No recipes found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            return Card(
              child: ListTile(
                leading: recipe.thumbnailUrl != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(recipe.thumbnailUrl!),
                      )
                    : null,
                title: Text(recipe.name),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailScreen(
                        id: recipe.id,
                        type: type,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
