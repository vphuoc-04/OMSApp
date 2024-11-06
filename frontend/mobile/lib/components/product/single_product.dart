import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Model
import 'package:mobile/models/product.dart';

class SingleProduct extends StatelessWidget {

  final Product product;
  const SingleProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: product.img != null && product.img!.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(product.img!),
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
              product.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(
              product.description ?? 'No description available',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              '${product.price} VNĐ',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () {
              },
              child: Ink(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(67, 169, 162, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                      CupertinoIcons.cart,
                      color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}