import 'package:assignment_flutter/screens/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:assignment_flutter/screens/user_colors.dart';

class GrocerySearch extends SearchDelegate<String> {
  final List<String> groceryItems = [
    "apples",
    "bananas",
    "oranges",
    "grapes",
    "strawberries",
    "blueberries",
    "raspberries",
    "blackberries",
    "kiwis",
    "mangos",
    "pineapples",
    "watermelons",
    "cantaloupes",
    "honeydews",
    "peaches",
    "nectarines",
    "plums",
    "apricots",
    "cherries",
    "lemons",
    "limes",
    "grapefruits",
    "tangerines",
    "clementines",
    "pomegranates",
    "avocados",
    "tomatoes",
    "cucumbers",
    "carrots",
    "celery",
    "lettuce",
    "spinach",
    "kale",
    "broccoli",
    "cauliflower",
    "asparagus",
    "green beans",
    "peas",
    "corn",
    "potatoes",
    "sweet potatoes",
    "onions",
    "garlic",
    "ginger",
    "bell peppers",
    "jalapenos",
    "habaneros",
    "chili peppers",
    "mushrooms",
    "zucchini",
    "squash",
    "eggplant",
    "artichokes",
    "olives",
    "pickles",
    "sauerkraut",
    "canned tomatoes",
    "canned beans",
    "canned corn",
    "canned fruit",
    "canned vegetables",
    "pasta",
    "rice",
    "quinoa",
    "oats",
    "bread",
    "bagels",
    "tortillas",
    "chips",
    "pretzels",
    "popcorn",
    "nuts",
    "seeds",
    "peanut butter",
    "jelly",
    "honey",
    "syrup",
    "sugar",
    "flour",
    "baking powder",
    "baking soda",
    "yeast",
    "salt",
    "pepper",
    "spices",
    "herbs",
    "oil",
    "vinegar",
    "soy sauce",
    "hot sauce",
    "ketchup",
    "mustard",
    "mayonnaise",
    "salad dressing",
    "salsa",
    "guacamole",
    "cheese",
    "yogurt",
    "milk",
    "cream",
    "butter",
    "eggs",
    "bacon",
    "sausage",
    "chicken",
    "beef",
    "pork",
    "fish",
    "shrimp",
    "lobster",
    "crab",
    "clams",
    "oysters",
    "tofu",
    "beans",
    "lentils",
    "chickpeas",
    "toothpaste",
    "soap",
    "shampoo",
    "conditioner",
    "lotion",
    "razors",
    "toilet paper",
    "paper towels",
    "trash bags",
    "dish soap",
    "laundry detergent",
    "fabric softener",
    "cleaning spray",
    "cleaning wipes",
    "batteries",
    "light bulbs",
    "candles",
    "matches",
    "pet food",
    "cat litter",
    "bird seed",
    "fertilizer",
    "weed killer",
    "insect repellent",
    "sunscreen",
    "first aid kit",
    "vitamins",
    "pain relievers",
    "cold medicine",
    "allergy medicine",
    "contact solution",
    "diapers",
    "baby wipes",
    "baby food",
    "baby formula",
    "school supplies",
    "office supplies",
    "books",
    "magazines",
    "newspapers",
    "movies",
    "music",
    "video games",
    "board games",
    "puzzles",
    "craft supplies",
    "sewing supplies",
    "gardening supplies",
    "sporting goods",
    "exercise equipment",
    "bicycles",
    "helmets",
    "skateboards",
    "rollerblades",
    "camping gear",
    "fishing gear",
    "hunting gear",
    "skiing equipment",
    "snowboarding equipment",
    "swimming gear",
    "golf clubs",
    "tennis rackets",
    "basketballs",
    "footballs",
    "soccer balls",
    "baseballs",
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
    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) => Container(
      color: UserColors.getColor(0),
      child: ListView.builder(
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
            title: Text(
                style: TextStyle(
                  color: UserColors.getColor(3)
                ),
                suggestion
            ),
            trailing: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
                color: Color.fromARGB(255, 181, 180, 180),
              ),
              child: Icon(
                Icons.add,
                color: UserColors.getColor(1),
              ),
            ),
          );
        },
      )
  );
}
