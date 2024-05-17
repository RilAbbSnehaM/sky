import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky/top_colleges_screen.dart';
import 'fav.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CollegeSearchModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color _notificationIconColor = Colors.white;
  Color _micIconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Find Your Way',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTapDown: (_) {
                          setState(() {
                            _notificationIconColor = Colors.red;
                          });
                        },
                        onTapUp: (_) {
                          setState(() {
                            _notificationIconColor = Colors.white;
                          });
                          print('Notification icon tapped');
                        },
                        child: Icon(
                          Icons.notifications,
                          color: _notificationIconColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Search in 600 colleges around!',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: Consumer<CollegeSearchModel>(
                          builder: (context, model, child) {
                            return TextField(
                              onChanged: (value) {
                                model.setSearchText(value);
                              },
                              decoration: InputDecoration(
                                hintText: 'Search for colleges, schools...',
                                prefixIcon: Icon(Icons.search),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 8.0),
                      GestureDetector(
                        onTapDown: (_) {
                          setState(() {
                            _micIconColor = Colors.red;
                          });
                        },
                        onTapUp: (_) {
                          setState(() {
                            _micIconColor = Colors.white;
                          });
                          print('Mic icon tapped');
                        },
                        child: Icon(
                          Icons.mic,
                          color: _micIconColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionCard(
                    title: 'Top Colleges',
                    subtitle:
                        'Search through thousands of accredited colleges and universities online to find the right one for you. Apply in 3 min, and connect with your future.',
                    itemCount: 126,
                    itemType: 'Colleges',
                    imagePath: 'assets/images/clg23.jpg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TopCollegesScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16.0),
                  SectionCard(
                    title: 'Top Schools',
                    subtitle:
                        'Searching for the best school for you just got easier! With our Advanced School Search, you can easily filter out the schools that are fit for you.',
                    itemCount: 106,
                    itemType: 'Schools',
                    imagePath: 'assets/images/clg12.jpg',
                    onTap: () {
                      // Implement functionality
                    },
                  ),
                  SizedBox(height: 16.0),
                  SectionCard(
                    title: 'Exams',
                    subtitle:
                        'Find an end to end information about the exams that are happening in India.',
                    itemCount: 16,
                    itemType: 'Exams',
                    imagePath: 'assets/images/exam.jpg',
                    onTap: () {
                      // Implement functionality
                    },
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBottomNavigationBarItem(Icons.home, 'Home', () {
                // Add functionality for home icon here
              }),
              _buildBottomNavigationBarItem(Icons.save, 'Saved', () {
                _showSavedItems(context);
              }),
              _buildBottomNavigationBarItem(Icons.bookmark, 'Bookmark', () {
                // Add functionality for saved items icon here
              }),
              _buildBottomNavigationBarItem(Icons.account_circle, 'Account', () {
                // Add functionality for account icon here
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBarItem(
      IconData icon, String label, VoidCallback onPressed) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.white),
          onPressed: onPressed,
        ),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }

  void _showSavedItems(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SavedItemsSheet();
      },
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int itemCount;
  final String itemType;
  final String imagePath;
  final VoidCallback onTap;

  SectionCard({
    required this.title,
    required this.subtitle,
    required this.itemCount,
    required this.itemType,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        '+$itemCount $itemType',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CollegeSearchModel with ChangeNotifier {
  List<String> _colleges =
      List.generate(160, (index) => 'College ${index + 1}');
  List<String> _schools = List.generate(10, (index) => 'School ${index + 1}');
  List<String> _exams = List.generate(10, (index) => 'Exam ${index + 1}');
  String _searchText = '';

  List<String> get colleges => _colleges;
  List<String> get schools => _schools;
  List<String> get exams => _exams;
  String get searchText => _searchText;

  List<String> get filteredColleges {
    if (_searchText.isEmpty) {
      return _colleges;
    } else {
      return _colleges
          .where((college) => college.contains(_searchText))
          .toList();
    }
  }

  void setSearchText(String value) {
    _searchText = value;
    notifyListeners();
  }
}
