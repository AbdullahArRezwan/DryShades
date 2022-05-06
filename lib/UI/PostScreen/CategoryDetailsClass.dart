class CategoryDetails {
  final String id;
  final List<String> categories;
  final String title;
  final String address;
  final String price;
  final String imageUrl;

  const CategoryDetails({
    required this.id,
    required this.categories,
    required this.title,
    required this.address,
    required this.price,
    required this.imageUrl
  });
}