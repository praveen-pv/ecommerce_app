// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/product_provider.dart';
// import 'edit_product_screen.dart';
//
// class ProductDetailScreen extends StatefulWidget {
//   final int productId;
//
//   ProductDetailScreen(this.productId);
//
//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }
//
// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   late Future<void> _fetchProductFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch product details once and store the Future
//     _fetchProductFuture = Provider.of<ProductProvider>(context, listen: false)
//         .fetchProductById(widget.productId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: FutureBuilder(
//         future: _fetchProductFuture,
//         builder: (ctx, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error loading product details'));
//           } else {
//             final product = productProvider.selectedProduct!;
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Image.network(
//                       product.thumbnail,
//                       height: 200,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     "\$${product.price}",
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     product.title,
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     product.description,
//                     style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                         builder: (ctx) => EditProductScreen(widget.productId),
//                       ));
//                     },
//                     child: Text("Edit Product"),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import 'edit_product_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  ProductDetailScreen(this.productId);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<void> _fetchProductFuture;

  @override
  void initState() {
    super.initState();
    // Fetch product details once and store the Future
    _fetchProductFuture = Provider.of<ProductProvider>(context, listen: false)
        .fetchProductById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple, // Changed AppBar color
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          " Product Details",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _fetchProductFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading product details'));
          } else {
            final product = productProvider.selectedProduct!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        product.thumbnail,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Product Title
                    Text(
                      product.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    // Product Price
                    Text(
                      "\$${product.price}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Product Description
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    // Edit Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => EditProductScreen(widget.productId),
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple, // Purple color for the button
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: TextStyle(
                          fontSize: 18,
                          //fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      child: Text("Edit Product", style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

