import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class CollegeCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CollegeSearchModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('College Categories'),
      ),
      body: ListView.builder(
        itemCount: model.filteredColleges.length,
        itemBuilder: (context, index) {
          final college = model.filteredColleges[index];
          return ListTile(
            title: Text(college),
          );
        },
      ),
    );
  }
}

class SavedItemsSheet extends StatefulWidget {
  @override
  _SavedItemsSheetState createState() => _SavedItemsSheetState();
}

class _SavedItemsSheetState extends State<SavedItemsSheet> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Bachelor of Technology',
      'Bachelor of Architecture',
      'Pharmacy',
      'Law',
      'Management',
    ];

    final categoryIcons = {
      'Bachelor of Technology': Icons.engineering,
      'Bachelor of Architecture': Icons.architecture,
      'Pharmacy': Icons.local_pharmacy,
      'Law': Icons.gavel,
      'Management': Icons.business,
    };

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sort by',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Divider(),
          ...categories.map((category) {
            return ListTile(
              leading: Icon(categoryIcons[category]),
              title: Text(category),
              trailing: Radio<String>(
                value: category,
                groupValue: _selectedCategory,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
