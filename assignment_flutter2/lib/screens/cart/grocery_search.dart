import 'package:assignment_flutter/screens/cart/cart.dart';
import 'package:flutter/material.dart';

class GrocerySearch extends SearchDelegate<String> {
  final List<String> groceryItems = [
    'Apples',
    'Bananas',
    'Chips',
    'Broccoli',
    'Chicken',
    'Tomatoes',
    'Grapes',
    'Milk',
    'Yogurt',
    'Potatoes',
    'Juice',
    'Bread',
    'Oatmeal',
    'Soda',
    'Cereal',
    'Oranges',
    'Water',
    'Pineapple',
    'Cheese',
  ];

  String item = '';
  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query == '') {
              close(context, '');
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear),
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              query,
            ),
          ],
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentSearch
        : groceryItems.where((item) {
            final itemLower = item.toLowerCase();
            final queryLower = query.toLowerCase();

            return itemLower.contains(queryLower);
          }).toList();
    return builSuggestionsSuccess(suggestions);
  }

  Widget builSuggestionsSuccess(List<String> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            onTap: () {
              if (recentSearch.contains(suggestion)) {
                recentSearch.remove(suggestion);
                recentSearch.insert(0, suggestion);
              } else if (recentSearch.length < 5) {
                recentSearch.insert(0, suggestion);
              } else {
                recentSearch.removeLast();
                recentSearch.insert(0, suggestion);
              }
              if (suggestion != '') {
                close(context, suggestion);
              }
            },
            title: Text(suggestion),
            trailing: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
                color: Color.fromARGB(255, 181, 180, 180),
              ),
              child: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 3, 139, 7),
              ),
            ),
          );
        },
      );
}
