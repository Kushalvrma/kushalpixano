class ProductCategoryListModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  ProductCategoryListModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductCategoryListModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryListModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'] as double,
      description: json['description'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      rating: Rating.fromJson(json['rating'] as Map<String, dynamic>),
    );
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,s
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] is int) ? (json['rate'] as int).toDouble() : json['rate'] as double,
      count: json['count'] as int,
    );
  }
}
