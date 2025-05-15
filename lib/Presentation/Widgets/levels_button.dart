import 'package:flutter/material.dart';

class LevelsButton extends StatefulWidget {
  final void Function(String) onLevelSelected;
  const LevelsButton({super.key, required this.onLevelSelected});

  @override
  State<LevelsButton> createState() => _LevelsButtonState();
}

class _LevelsButtonState extends State<LevelsButton> {
  String? _selectedCategory;
  final List<String> _level = ['Easy', 'Medium', 'Hard'];
  final String _levelQuestions = '10 questions';

  Widget _buildSelectedCategory(String levels) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: Offset(0, 4),
            color: Color(0xFF298EC8).withAlpha(77),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              levels,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF101922),
              ),
            ),
            Text(
              _levelQuestions,
              style: TextStyle(
                fontFamily: "Open Sans",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF101922),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnselectedCategory(String levels) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1E2730),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              levels,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Text(
              _levelQuestions,
              style: TextStyle(
                fontFamily: "Open Sans",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF7B8A99),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children:
          _level.map((sport) {
            final isSelected = _selectedCategory == sport;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = sport;
                });
                widget.onLevelSelected(sport);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child:
                    isSelected
                        ? _buildSelectedCategory(sport)
                        : _buildUnselectedCategory(sport),
              ),
            );
          }).toList(),
    );
  }
}
