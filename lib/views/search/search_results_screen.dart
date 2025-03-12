import 'package:black_broth/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/food_service.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var foodProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Food Search"), backgroundColor: Colors.blue),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(10),
            child: MySearchBar(
              controller: _searchController,
              onChanged: (query) => foodProvider.searchFood(query),
            ),
          ),
          // Display Search Results
          Expanded(
            child: ListView.builder(
              itemCount: foodProvider.filteredFoodItems.length,
              itemBuilder: (context, index) {
                var food = foodProvider.filteredFoodItems[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(food.image),
                  ),
                  title: Text(food.name),
                  subtitle: Text("${food.category} • ${food.description}"),
                  trailing: Text("\$${food.price.toStringAsFixed(2)}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
