import 'package:black_broth/models/food_item_model.dart';
import 'package:black_broth/theme/app_colors.dart';
import 'package:black_broth/views/cart/receipt_screen.dart';
import 'package:black_broth/widgets/mybotton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../services/cart_service.dart';
import '../../services/favorite_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final favoriteProvider = Provider.of<FavoritesProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 32),
            child: Text("Cart", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
      body:
          cartProvider.cartItems.isEmpty
              ? Center(
                child: Text(
                  "Your cart is empty!",
                  style: TextStyle(fontSize: 18),
                ),
              )
              : Column(
                children: [
                  SizedBox(height: 30),
                  Text("Swipe right to delete"),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartProvider.cartItems[index];

                        return Padding(
                          padding: const EdgeInsets.only(
                            right: 25,
                            left: 25,
                            bottom: 7,
                          ),
                          child: Slidable(
                            key: Key(cartItem.food['name']),
                            endActionPane: ActionPane(
                              // Slide only to the left
                              motion: const BehindMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "${cartItem.food['name']} added to favorites!",
                                        ),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: AppColors.circularButton,
                                  icon: Icons.favorite,
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    cartProvider.removeFromCart(cartItem.food);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "${cartItem.food['name']} removed from cart!",
                                        ),
                                      ),
                                    );
                                  },
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: AppColors.circularButton,
                                  icon: Icons.delete,
                                ),
                              ],
                            ),
                            child: Card(
                              elevation: 0,
                              margin: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage(
                                    "assets/images/${cartItem.food['image']}",
                                  ),
                                ),
                                title: Text(
                                  cartItem.food['name'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                subtitle: Text(
                                  "XAF${cartItem.food['price'].toStringAsFixed(2)} x ${cartItem.quantity}",
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            cartProvider.decreaseQuantity(
                                              cartItem.food,
                                            );
                                          },
                                        ),
                                        Text(
                                          cartItem.quantity.toString(),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            cartProvider.increaseQuantity(
                                              Map<String, dynamic>.from(
                                                cartItem.food.data(),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "Total: XAF ${cartProvider.totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            await generateReceipt(context);
                          },
                          child: MyBotton(text: 'Complete Order'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
