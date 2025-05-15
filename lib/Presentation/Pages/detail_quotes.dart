import 'package:flutter/material.dart';
import 'package:sports_app/Presentation/Pages/quotes_screen.dart'; // Fixed import path
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sports_app/Utils/Constants/images.dart';
import 'package:sports_app/Utils/admin_quote.dart';

class DetailQuotes extends StatefulWidget {
  final AdminQuote adminQuote;
  const DetailQuotes({super.key, required this.adminQuote});

  @override
  State<DetailQuotes> createState() => _DetailQuotesState();
}

class _DetailQuotesState extends State<DetailQuotes> {
  bool _isSaved = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
  }

  Future<void> _checkIfSaved() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => _isLoading = true);

    try {
      final ref = FirebaseDatabase.instance
          .ref()
          .child('w02_users')
          .child(user.uid)
          .child('savedQuotes');

      final snapshot = await ref.get();
      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;

        // Check if this quote is already saved
        final matches = data.values.where(
          (value) =>
              value is Map &&
              value['text'] == widget.adminQuote.text &&
              value['imageUrl'] == widget.adminQuote.imageUrl,
        );

        setState(() => _isSaved = matches.isNotEmpty);
      }
    } catch (e) {
      print('Error checking if quote is saved: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleSaveQuote() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please sign in to save quotes!')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (_isSaved) {
        // Find and delete the saved quote
        final ref = FirebaseDatabase.instance
            .ref()
            .child('w02_users')
            .child(user.uid)
            .child('savedQuotes');

        final snapshot = await ref.get();
        if (snapshot.exists) {
          final data = snapshot.value as Map<dynamic, dynamic>;

          // Find the key of the matching quote
          String? matchingKey;
          data.forEach((key, value) {
            if (value is Map &&
                value['text'] == widget.adminQuote.text &&
                value['imageUrl'] == widget.adminQuote.imageUrl) {
              matchingKey = key.toString();
            }
          });

          if (matchingKey != null) {
            await ref.child(matchingKey!).remove();
            setState(() => _isSaved = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Quote removed from saved quotes')),
            );
          }
        }
      } else {
        // Save the quote
        final newKey =
            FirebaseDatabase.instance
                .ref()
                .child('w02_users')
                .child(user.uid)
                .child('savedQuotes')
                .push()
                .key;

        if (newKey != null) {
          await FirebaseDatabase.instance
              .ref()
              .child('w02_users')
              .child(user.uid)
              .child('savedQuotes')
              .child(newKey)
              .set({
                'text': widget.adminQuote.text,
                'imageUrl': widget.adminQuote.imageUrl,
                'category': widget.adminQuote.category,
                'savedAt': DateTime.now().toIso8601String(),
              });

          setState(() => _isSaved = true);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Quote saved!')));
        }
      }
    } catch (e) {
      print('Error saving/removing quote: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      body: Stack(
        children: [
          Image.network(
            widget.adminQuote.imageUrl,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            errorBuilder:
                (context, error, stackTrace) => Container(color: Colors.black),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withAlpha(200), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 21,
            ).copyWith(top: 64),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 125),
                Text(
                  widget.adminQuote.category,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 190, left: 23, right: 23),
            child: Text(
              widget.adminQuote.text,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: "Plus Jakarta Sans",
                fontWeight: FontWeight.w800,
                fontSize: 32,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 27,
              ).copyWith(bottom: 44),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color(0xFF1E2730),
                    Color(0xFF151B21),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:
                        () => showSetAlarmPopup(context, rootContext: context),
                    child: _iconWithLabel(Icons.alarm_rounded, "Set Alarm"),
                  ),
                  _isLoading
                      ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          strokeWidth: 2,
                        ),
                      )
                      : GestureDetector(
                        onTap: _toggleSaveQuote,
                        child: _iconWithLabel(
                          _isSaved ? Icons.bookmark : Icons.bookmark_border,
                          _isSaved ? "Saved" : "Save",
                          color: _isSaved ? Colors.amber : Colors.white,
                        ),
                      ),
                  _iconWithLabel(Icons.volume_up_outlined, "Listen"),
                  _iconWithLabel(Icons.favorite_border, "Like"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconWithLabel(IconData icon, String label, {Color? color}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color ?? Colors.white),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color ?? Colors.white,
            fontFamily: "Plus Jakarta Sans",
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

void showSetAlarmPopup(
  BuildContext context, {
  required BuildContext rootContext,
}) {
  TimeOfDay selectedTime = TimeOfDay(hour: 8, minute: 0);
  String selectedSound = 'Bells';
  final List<String> sounds = ['Bells', 'Chimes', 'Waves', 'Birds'];

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: StatefulBuilder(
          builder:
              (context, setState) => Center(
                child: Container(
                  width: 333,
                  height: 410,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2730),
                    borderRadius: BorderRadius.circular(21.09),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x4D000000),
                        blurRadius: 11.6,
                        offset: const Offset(0, 3.51),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and close
                        Row(
                          children: [
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Set Alarm for '),
                                    TextSpan(
                                      text: 'Quote',
                                      style: TextStyle(
                                        color: Colors.red.shade400,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'By setting the time, this quote will be shown to you at that exact time to keep you motivated.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Set Alarm Time row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Set Alarm\nTime:',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  final picked = await showTimePicker(
                                    context: context,
                                    initialTime: selectedTime,
                                  );
                                  if (picked != null) {
                                    setState(() => selectedTime = picked);
                                  }
                                },
                                child: Container(
                                  height: 48,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(99),
                                    border: Border.all(
                                      color: Colors.white24,
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedTime.format(context),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Notification Sound row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Notification\nSound:',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 48,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(99),
                                  border: Border.all(
                                    color: Colors.white24,
                                    width: 2,
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedSound,
                                    dropdownColor: const Color(0xFF232B34),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    items:
                                        sounds.map((sound) {
                                          return DropdownMenuItem(
                                            value: sound,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 30,
                                                  ),
                                              child: Text(sound),
                                            ),
                                          );
                                        }).toList(),
                                    onChanged: (value) {
                                      if (value != null)
                                        setState(() => selectedSound = value);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Future.delayed(
                                    const Duration(milliseconds: 200),
                                    () {
                                      showAlarmSetConfirmation(rootContext);
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  backgroundColor: const Color(0xFFF23943),
                                ),
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        ),
      );
    },
  );
}

void showAlarmSetConfirmation(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Center(
          child: Container(
            width: 289,
            height: 290,
            decoration: BoxDecoration(
              color: const Color(0xFF1E2730),
              borderRadius: BorderRadius.circular(18.3),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x4D000000),
                  blurRadius: 11.6,
                  offset: const Offset(0, 3.51),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Close button
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, color: Color(0xFF1E2730)),
                    ),
                  ),
                ),
                // Content
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Owl image
                    Image.network(
                      Images
                          .img22, // Make sure Images.img22 is a valid URL or use Image.asset if it's a local asset
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 16),
                    // Alarm Set text
                    const Text(
                      "Alarm Set!",
                      style: TextStyle(
                        color: Color(0xFFF23943),
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Success message
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Your alarm has been successfully scheduled ⏰",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
