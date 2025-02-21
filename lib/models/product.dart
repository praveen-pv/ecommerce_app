class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String category;
  final double rating;
  final int stock;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.rating,
    required this.stock,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      category: json['category'],
      rating: json['rating'].toDouble(),
      stock: json['stock'],
      thumbnail: json['thumbnail'],
    );
  }
}
