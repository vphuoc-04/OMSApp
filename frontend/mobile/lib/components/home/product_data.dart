import 'package:flutter/material.dart';

// Model
import 'package:mobile/models/product.dart';

class ProductData extends StatelessWidget {
  final List<Product> products;

  const ProductData({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 1),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Giá: ${product.price}'),
                Text('Mô tả: ${product.description}'),
                Text('Số lượng: ${product.quantity}'),
                Text('Trạng thái: ${product.status}'),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: product.img != null && product.img!.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(product.img!),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: Colors.grey[200], 
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            isThreeLine: true,
          );
        },
      ),
    );
  }
}