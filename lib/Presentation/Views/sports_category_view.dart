import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SportsCategoryView extends StatefulWidget {
  final Function(String) onCategorySelected;
  final String? selectedCategory;

  const SportsCategoryView({
    Key? key,
    required this.onCategorySelected,
    this.selectedCategory,
  }) : super(key: key);

  @override
  _SportsCategoryViewState createState() => _SportsCategoryViewState();
}

class _SportsCategoryViewState extends State<SportsCategoryView> {
  String? _selectedCategory;

  final List<String> _sports = [
    'Football',
    'Swimming',
    'Golf',
    'Badminton',
    'Cricket',
    'Rugby',
    'Basket Ball',
    'Tennis',
    'Gymnastic',
    'Cycling',
  ];

  final Map<String, IconData> _sportIcons = {
    'Football': Icons.sports_soccer,
    'Swimming': Icons.pool,
    'Golf': Icons.golf_course,
    'Badminton': Icons.sports_tennis,
    'Cricket': Icons.sports_cricket,
    'Rugby': Icons.sports_rugby,
    'Basket Ball': Icons.sports_basketball,
    'Tennis': Icons.sports_tennis,
    'Gymnastic': Icons.fitness_center,
    'Cycling': Icons.directions_bike,
  };

  Widget _buildUnselectedCategory(String sport) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Color(0xFF1E2730), // Background color for unselected
        border: Border.all(color: Color(0xFF32363A), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(64),
            offset: Offset(0, 4),
            blurRadius: 7.5,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withAlpha(64),
            offset: Offset(0, 2),
            blurRadius: 11.1,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0xFF516A82).withAlpha(51),
            offset: Offset(0, 4),
            blurRadius: 10.7,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0xFF6E87A0).withAlpha(77),
            offset: Offset(0, 1),
            blurRadius: 0,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_sportIcons[sport], color: Colors.white),
          SizedBox(width: 8.0),
          Text(sport, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildSelectedCategory(String sport) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: [Color(0xFFF23943), Color(0xFFC1232C)],
        ), // Styling for selected
        border: Border.all(color: Color(0xFF1E2730), width: 2),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFFC5000).withAlpha(65),
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_sportIcons[sport], color: Colors.white),
          SizedBox(width: 4),
          Text(sport, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children:
          _sports.map((sport) {
            final isSelected = widget.selectedCategory == sport;
            return GestureDetector(
              onTap: () {
                widget.onCategorySelected(sport);
              },
              child:
                  isSelected
                      ? _buildSelectedCategory(sport)
                      : _buildUnselectedCategory(sport),
            );
          }).toList(),
    );
  }
}
