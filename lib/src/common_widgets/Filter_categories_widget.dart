import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFilterCategoryListWidget extends StatelessWidget {
  final Image image;
  final String name;

  const MyFilterCategoryListWidget({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 1),
        child: SizedBox(
          height: 95,
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff3a4054),
                ),
                child: image,
              ),
              Text(
                name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductListTile extends StatelessWidget {
  final String name;
  final String price;
  final String quantity;
  final String imageUrl;

  ProductListTile({
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  static Future<ProductListTile> fetch(String itemId) async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('ItemList')
          .doc(itemId)
          .get();

      final data = docSnapshot.data() as Map<String, dynamic>;
      String name = data['name'];
      String price = data['price'];
      String quantity = data['quantity'];
      String imageUrl = data['imageUrl'];

      return ProductListTile(
        name: name,
        price: price,
        quantity: quantity,
        imageUrl: imageUrl,
      );
    } catch (error) {
      print('Error fetching product: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      width: 350,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: const Color(0xff3a4054),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    quantity,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  Text(
                    "Basic Price: $price",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.phone),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// child: ListTile(
      //   leading: CachedNetworkImage(
      //     imageUrl: imageUrl,
      //     placeholder: (context, url) => new CircularProgressIndicator(),
      //     errorWidget: (context, url, error) => new Icon(Icons.error),
      //   ),
      //   title: Text(name),
      //   subtitle: Text(price),
      //   trailing: Text('Qty: ${quantity}'),
      // ),
