import 'package:flutter/material.dart';
import '../widgets/ingredient_input.dart';
import '../widgets/recipe_list.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _ingredients = [];
  Key _ingredientInputKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _ingredients.clear();
        _ingredientInputKey = UniqueKey();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Meals'),
            Tab(text: 'Cocktails'),
          ],
        ),
        IngredientInput(
          key: _ingredientInputKey,
          onIngredientsChanged: (ingredients) {
            setState(() {
              _ingredients.clear();
              _ingredients.addAll(ingredients);
            });
          },
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              RecipeList(
                ingredients: _ingredients,
                type: RecipeType.meal,
              ),
              RecipeList(
                ingredients: _ingredients,
                type: RecipeType.cocktail,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }
}
