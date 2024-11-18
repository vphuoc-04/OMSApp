import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Model
import 'package:mobile/models/product.dart';

// Service
import 'package:mobile/services/cart_service.dart';

class SingleProduct extends StatefulWidget {
  final Product product;

  const SingleProduct({Key? key, required this.product}) : super(key: key);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  int? userId;
  String? token;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    _getUserData(); 
  }

  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');  
    userId = prefs.getInt('user_id');  

    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    final CartService cartService = CartService();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.product.name),
      ),
      body: token != null && userId != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        image: widget.product.img != null && widget.product.img!.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(widget.product.img!),
                                fit: BoxFit.contain,
                              )
                            : null,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.product.description ?? 'No description available',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color.fromARGB(206, 0, 0, 0)),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (quantity > 1) {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                              },
                              child: Icon(CupertinoIcons.minus),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '$quantity', 
                                style: TextStyle(
                                  color: Color.fromARGB(206, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: Icon(CupertinoIcons.add),
                            )
                          ],
                        ),
                      ),
                      Text(
                        '${widget.product.price * quantity} VNĐ',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      if (token == null || userId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please log in to add products to the cart')),
                        );
                        return;
                      }

                      try {
                        await cartService.addToCart(widget.product.id, quantity, widget.product.name, widget.product.price, widget.product.img);
                        print('Product added to cart!');
                      } 
                      catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${e.toString()}')),
                        );
                      }
                    },
                    child: Ink(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(67, 169, 162, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          CupertinoIcons.cart,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
