import 'package:flutter/material.dart';

class CollegeDetailsScreen extends StatefulWidget {
  final String collegeName;

  CollegeDetailsScreen({required this.collegeName});

  @override
  _CollegeDetailsScreenState createState() => _CollegeDetailsScreenState();
}

class _CollegeDetailsScreenState extends State<CollegeDetailsScreen> {
  String _selectedBed = '';
  List<String> _facilities = [
    'WiFi',
    'Cafeteria',
    'Sports',
    // Add more facilities here
  ];
  List<String> _options = ['About', 'Hostel Facility', 'Q & A', 'Events'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/clg12.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 16.0,
                  left: 16.0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  top: 16.0,
                  right: 16.0,
                  child: IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () {
                      // Handle save button tap
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    'Description about the ${widget.collegeName} goes here. It includes various details about the college.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _options.map((option) => _buildOption(option)).toList(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  _selectedBed.isNotEmpty
                      ? SizedBox(
                          height: 150,
                          child: _buildBedOptions(),
                        )
                      : SizedBox.shrink(),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Address: XYZ', // Add the actual address
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Facilities:',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildFacilitiesWithIcons(),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle apply button tap
                      },
                      child: Text('Apply Now'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String option) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // Handle option tap
          if (option == 'Hostel Facility') {
            _showBedOptions();
          } else {
            // You can add functionality for other options if needed
          }
        },
        child: Text(option),
      ),
    );
  }

  Widget _buildBedOption(String option) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBed = option;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 8.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: _selectedBed == option ? Colors.blue : Colors.grey,
            width: 2.0,
          ),
        ),
        child: Text(
          option,
          style: TextStyle(
            fontSize: 16,
            color: _selectedBed == option ? Colors.blue : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildBedOptions() {
    if (_selectedBed == '4 Bed') {
      return ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildImage('assets/images/clg12.jpg'),
          _buildImage('assets/images/clg23.jpg'),
          _buildImage('assets/images/clg.jpeg'),
          // Add more images here
        ],
      );
    } else if (_selectedBed == '3 Bed') {
      return ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildImage('assets/images/clg12.jpg'),
          _buildImage('assets/images/clg23.jpg'),
          _buildImage('assets/images/exam.jpg'),
          // Add more images here
        ],
      );
    }
    // Add more conditions for other bed options if needed
    return SizedBox.shrink();
  }

  Widget _buildImage(String imagePath) {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  List<Widget> _buildFacilitiesWithIcons() {
    return _facilities.map((facility) {
      return Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 8.0),
          Text(facility),
        ],
      );
    }).toList();
  }

  void _showBedOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Bed Option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBedOption('4 Bed'),
              _buildBedOption('3 Bed'),
              // Add more bed options here if needed
            ],
          ),
        );
      },
    );
  }
}
