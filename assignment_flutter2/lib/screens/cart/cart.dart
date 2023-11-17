import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../reports/report_screen.dart';
import 'grocery_search.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:assignment_flutter/screens/user_colors.dart';

List groceryCart = [];
final List<String> recentSearch = [];
List bought = [];
List price = [];
List amount = [];
String item = '';

class Cart extends StatefulWidget {
  final String docID;
  Cart({required this.docID, super.key});
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Future getDocID() async {
    await FirebaseFirestore.instance.doc('group/' + widget.docID).toString();
  }

  @override
  void initState() {
    setState(() {
      groceryCart = [];
      bought = [];
      price = [];
      amount = [];
    });
    getCart();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListLink'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 30,
        ),
        backgroundColor: UserColors.getColor(1),
        actions: [
          GestureDetector(
            onTap: (){
              Get.to(()=>ReportScreen(docAccess: widget.docID));
            },
            child: Icon(Icons.add_chart,color: Colors.white,),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: () async {
              final newItem = await showSearch(
                context: context,
                delegate: GrocerySearch(),
              );
              addItem(newItem);
              //item = newItem.toString();
            },
          )
        ],
      ),
      body: Container (
        color: UserColors.getColor(0),
        child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Center(
              child: Text(
                'Your Grocery List',
                style: TextStyle(
                  color: UserColors.getColor(3),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: FutureBuilder(
                future: null, //getDocID(),
                builder: (context, snapshot) {
                  //return GetCart(docID: widget.docID);

                  return ListView.builder(
                    itemCount: groceryCart.length,
                    itemBuilder: ((context, index) {
                      return Slidable(
                          startActionPane: ActionPane(
                            motion: DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) => removeItem(index),
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(18)),
                                padding: const EdgeInsets.all(8.0),
                              ),
                              SlidableAction(
                                onPressed: (context) => check(index),
                                backgroundColor: Colors.green,
                                icon: Icons.check,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                                color: UserColors.getColor(1),
                              ),
                              child: Center(
                                child: Text(
                                  groceryCart[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          )
                          //itemName: groceryCart[index],
                          );
                    }),
                  );
                }),
          ),
        ],
      ),
    ));
  }

  void addItem(item) async {
    if (item != '') {
      final DocumentReference doc =
          FirebaseFirestore.instance.doc('groups/' + widget.docID);

      final DocumentSnapshot snapshot = await doc.get();
      final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      setState(() {
        groceryCart.add(item); // Add or update the array as needed
      });

      data['cart'] = groceryCart;
      await doc.update(data);
    }
  }

  void getCart() async {
    final DocumentReference doc =
        FirebaseFirestore.instance.doc('groups/' + widget.docID);

    final DocumentSnapshot snapshot = await doc.get();
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    groceryCart = data['cart'] as List<dynamic>;
    bought = data['purchased_items'] as List<dynamic>;
    price = data['purchased_cost'] as List<dynamic>;
    amount = data['purchased_quantity'] as List<dynamic>;
    setState(() {});
  }

  void updateCart() {
    setState(() {});
  }

  void removeItem(index) async {
    final DocumentReference doc =
        FirebaseFirestore.instance.doc('groups/' + widget.docID);

    final DocumentSnapshot snapshot = await doc.get();
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    setState(() {
      groceryCart.removeAt(index); // Add or update the array as needed
      data['cart'] = groceryCart;
    });
    await doc.update(data);
  }

  void check(index) async {
    bought.add(groceryCart.elementAt(index));
    price.add(0.0);
    amount.add(0.0);

    final DocumentReference doc =
        FirebaseFirestore.instance.doc('groups/' + widget.docID);

    final DocumentSnapshot snapshot = await doc.get();
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    setState(() {
      groceryCart.removeAt(index); // Add or update the array as needed
      data['cart'] = groceryCart;
      data['purchased_items'] = bought;
      data['purchased_cost'] = price;
      data['purchased_quantity'] = amount;
    });
    await doc.update(data);
  }
}
