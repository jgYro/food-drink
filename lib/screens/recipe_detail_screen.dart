import 'package:flutter/material.dart';
import '../models/recipe_detail.dart';
import '../services/recipe_service.dart';
import '../widgets/recipe_list.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String id;
  final RecipeType type;

  const RecipeDetailScreen({
    super.key,
    required this.id,
    required this.type,
  });

  List<String> _formatInstructions(String instructions) {
    // Split by period but keep periods that are part of numbers (e.g., "350.5")
    final steps = instructions
        .split(
            RegExp(r'(?<!\d)\.(?!\d)')) // Split on periods not between numbers
        .map((step) => step
            .trim()
            .replaceAll(RegExp(r'\r\n|\r|\n'), ' ')) // Remove line breaks
        .where((step) => step.isNotEmpty) // Remove empty steps
        .toList();

    return steps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
      ),
      body: FutureBuilder<RecipeDetail?>(
        future: RecipeService().getRecipeDetail(id, type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final recipe = snapshot.data;
          if (recipe == null) {
            return const Center(child: Text('Recipe not found'));
          }

          final instructions = recipe.instructions != null
              ? _formatInstructions(recipe.instructions!)
              : [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (recipe.thumbnailUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      recipe.thumbnailUrl!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  recipe.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                if (recipe.category != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    recipe.category!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
                const SizedBox(height: 16),
                Text(
                  'Ingredients',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: recipe.ingredients.entries
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text('• ${e.key} ${e.value}'),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Instructions',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                if (instructions.isEmpty)
                  const Text('No instructions available')
                else
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: instructions.asMap().entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  child: Text(
                                    '${entry.key + 1}',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(entry.value),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
