import 'package:flutter/material.dart';

class IngredientInput extends StatefulWidget {
  final Function(List<String>) onIngredientsChanged;

  const IngredientInput({
    super.key,
    required this.onIngredientsChanged,
  });

  @override
  State<IngredientInput> createState() => _IngredientInputState();
}

class _IngredientInputState extends State<IngredientInput> {
  final List<String> _ingredients = [];
  final _controller = TextEditingController();

  String _sanitizeIngredient(String input) {
    // Remove any special characters and replace spaces with underscores
    final sanitized = input
        .trim()
        .replaceAll(RegExp(r'[^\w\s-]'), '') // Remove special characters
        .replaceAll(RegExp(r'\s+'), '_'); // Replace spaces with underscores

    return sanitized;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter an ingredient',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) => _addIngredient(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: _addIngredient,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: _ingredients
                .map((ingredient) => Chip(
                      label: Text(ingredient),
                      onDeleted: () => _removeIngredient(ingredient),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  void _addIngredient() {
    final rawIngredient = _controller.text;
    final sanitizedIngredient = _sanitizeIngredient(rawIngredient);

    if (sanitizedIngredient.isNotEmpty) {
      setState(() {
        if (!_ingredients.contains(sanitizedIngredient)) {
          _ingredients.add(sanitizedIngredient);
          _controller.clear();
          widget.onIngredientsChanged(_ingredients);
        } else {
          // Optionally show a message that the ingredient is already added
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('This ingredient is already in the list'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      });
    }
  }

  void _removeIngredient(String ingredient) {
    setState(() {
      _ingredients.remove(ingredient);
      widget.onIngredientsChanged(_ingredients);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
