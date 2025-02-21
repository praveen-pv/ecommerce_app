import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class EditProductScreen extends StatefulWidget {
  final int productId;

  EditProductScreen(this.productId);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _price;
  String? _description;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final product = productProvider.selectedProduct;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple, // Changed AppBar color
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Edit Product",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title Field
                    TextFormField(
                      initialValue: product?.title,
                      decoration: InputDecoration(
                        labelText: "Title",
                        labelStyle: TextStyle(color: Colors.purple),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Title cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (value) => _title = value,
                    ),
                    SizedBox(height: 16),

                    // Price Field
                    TextFormField(
                      initialValue: product?.price.toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Price",
                        labelStyle: TextStyle(color: Colors.purple),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Price cannot be empty";
                        }
                        if (double.tryParse(value) == null) {
                          return "Please enter a valid number";
                        }
                        return null;
                      },
                      onSaved: (value) => _price = value,
                    ),
                    SizedBox(height: 16),

                    // Description Field
                    TextFormField(
                      initialValue: product?.description,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: TextStyle(color: Colors.purple),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Description cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (value) => _description = value,
                    ),
                    SizedBox(height: 24),

                    // Save Button
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          try {
                            await productProvider.updateProduct(
                              widget.productId,
                              title: _title!,
                              price: double.parse(_price!),
                              description: _description!,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Product updated successfully!"),
                            ));
                            Navigator.of(context).pop();
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Failed to update product: $error"),
                            ));
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple, // Purple color for the button
                        padding: EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      child: Text("Save Changes",
                          style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
