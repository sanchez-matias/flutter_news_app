import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/news/presentation/screens/category_screen.dart';

class CategoryTile {
  final String title;
  final Icon icon;

  CategoryTile({
    required this.title,
    required this.icon,
  });
}

List<CategoryTile> categories = [
  CategoryTile(
    title: 'Business',
    icon: const Icon(Icons.business_center),
  ),
  CategoryTile(
    title: 'Entertainment',
    icon: const Icon(Icons.movie),
  ),
  CategoryTile(
    title: 'Health',
    icon: const Icon(Icons.health_and_safety),
  ),
  CategoryTile(
    title: 'Science',
    icon: const Icon(Icons.science),
  ),
  CategoryTile(
    title: 'Sports',
    icon: const Icon(Icons.sports_basketball),
  ),
  CategoryTile(
    title: 'Technology',
    icon: const Icon(Icons.devices_other),
  ),
];

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.separated(
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final category = categories[index];
    
          return ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            leading: category.icon,
            iconColor: colors.primary,
            title: Text(category.title, style: const TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(categoryName: category.title),
                  ));
            },
          );
        },
      ),
    );
  }
}
