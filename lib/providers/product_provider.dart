import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final Dio _dio = Dio();
  List<Product> _products = [];
  Product? _selectedProduct;

  List<Product> get products => _products;
  Product? get selectedProduct => _selectedProduct;

  Future<void> fetchProducts() async {
    try {
      final response = await _dio.get('https://dummyjson.com/products');
      final List<dynamic> data = response.data['products'];
      _products = data.map((json) => Product.fromJson(json)).toList();
      notifyListeners();
    } catch (error) {
      throw Exception("Failed to fetch products: $error");
    }
  }

  Future<void> fetchProductById(int id) async {
    try {
      final response = await _dio.get('https://dummyjson.com/products/$id');
      _selectedProduct = Product.fromJson(response.data);
      notifyListeners();
    } catch (error) {
      throw Exception("Failed to fetch product: $error");
    }
  }
  Future<void> updateProduct(int id, {required String title, required double price, required String description}) async {
    try {
      final url = 'https://dummyjson.com/products/$id';
      final response = await Dio().put(
        url,
        data: {
          "title": title,
          "price": price,
          "description": description,
        },
      );

      if (response.statusCode == 200) {
        final updatedProduct = Product.fromJson(response.data);

        // Update the product in the list
        final productIndex = _products.indexWhere((product) => product.id == id);
        if (productIndex != -1) {
          _products[productIndex] = updatedProduct;
        }

        // Update the selected product
        _selectedProduct = updatedProduct;

        notifyListeners(); // Notify listeners for UI refresh
      } else {
        throw Exception("Failed to update product");
      }
    } catch (error) {
      throw Exception("Error updating product: $error");
    }
  }

  // Future<void> updateProduct(int id, {required String title, required double price, required String description}) async {
  //   try {
  //     final url = 'https://dummyjson.com/products/$id';
  //     final response = await Dio().put(
  //       url,
  //       data: {
  //         "title": title,
  //         "price": price,
  //         "description": description,
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       _selectedProduct = Product.fromJson(response.data); // Update locally
  //       notifyListeners();
  //     } else {
  //       throw Exception("Failed to update product");
  //     }
  //   } catch (error) {
  //     throw Exception("Error updating product: $error");
  //   }
  // }
}
