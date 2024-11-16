import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

// Service
import 'package:mobile/services/cart_service.dart';

// Model
import 'package:mobile/models/cart.dart';

class OrderProduct extends StatefulWidget {
  @override
  _OrderProductState createState() => _OrderProductState();
}

class _OrderProductState extends State<OrderProduct> {
  List<Cart> cartItems = [];

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  Future<void> _fetchCartItems() async {
    CartService cartService = CartService();
    var items = await cartService.getDataCart(); 
    setState(() {
      cartItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
      return Center(
        child: Text('Your cart is empty!'),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: cartItems.map((item) {
            return GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  width: 400,
                  height: 100,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color.fromARGB(206, 177, 177, 177)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            item.img,
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  item.name,
                                  style: TextStyle(
                                    fontSize: 20
                                  ),
                                ), 
                              ),
                              Text('${item.price} VNĐ'),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () async {},
                        child: Ink(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(67, 169, 162, 1),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Icon(
                              IconlyLight.delete, 
                              color: Color.fromRGBO(255, 255, 255, 50),
                              size: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      )
    );
  }
}