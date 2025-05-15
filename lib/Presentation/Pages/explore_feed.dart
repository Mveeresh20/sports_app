import 'package:flutter/material.dart';
import 'package:sports_app/Utils/Constants/images.dart';
import 'package:sports_app/Utils/Constants/text.dart';
import 'package:sports_app/models/quote_card.dart';

final List<Map<String, dynamic>> categories = [
  {'name': 'All', 'emoji': '✨'},
  {'name': 'Football', 'emoji': '⚽️'},
  {'name': 'Swimming', 'emoji': '🏊‍♂️'},
  {'name': 'Golf', 'emoji': '🏌️‍♂️'},
  {'name': 'Badminton', 'emoji': '🏸'},
  {'name': 'Cricket', 'emoji': '🏏'},
  {'name': 'Rugby', 'emoji': '🏉'},
  {'name': 'Basket Ball', 'emoji': '🏀'},
  {'name': 'Tennis', 'emoji': '🎾'},
  {'name': 'Cycling', 'emoji': '🚴‍♂️'},
];

class ExploreFeed extends StatefulWidget {
  const ExploreFeed({super.key});

  @override
  State<ExploreFeed> createState() => _ExploreFeedState();
}

class _ExploreFeedState extends State<ExploreFeed> {
  final List<QuoteCard> quoteCards = [
    QuoteCard(
      name: "Grane Smith",
      category: "Cricket",
      quote: LoremIpsum.p5,
      likes: 54,
      bookmarkCount: 5,
      imageUrl: Images.img6,
      backgroundImageUrl: Images.img3,
    ),
    QuoteCard(
      name: "John Doe",
      category: "Football",
      quote: LoremIpsum.p6,
      likes: 120,
      bookmarkCount: 10,
      imageUrl: Images.img5,
    ),
    QuoteCard(
      name: "Jane Smith",
      category: "Tennis",
      quote: "Ut enim ad minim veniam, quis nostrud exercitation ullamco.",
      likes: 75,
      bookmarkCount: 8,
      imageUrl: Images.img6,
    ),
    QuoteCard(
      name: "Michael Johnson",
      category: "Basketball",
      quote: "Duis aute irure dolor in reprehenderit in voluptate velit esse.",
      likes: 200,
      bookmarkCount: 15,
      imageUrl: Images.img5,
    ),
  ];

  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final filteredCards =
        selectedCategory == 'All'
            ? quoteCards
            : quoteCards
                .where((card) => card.category == selectedCategory)
                .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF101922),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF27313B),
                    width: 1,
                  ), // Only bottom border with 1px width
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 21,
                ).copyWith(top: 64, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 89),
                    const Text(
                      "Explore Feed",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ).copyWith(top: 19),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sort by",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showCategoryFilter(context),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1856),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.swap_vert, color: Color(0xFF7B8A99)),
                            Icon(Icons.sort, color: Color(0xFF7B8A99)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredCards.length,
              separatorBuilder: (context, index) => const SizedBox(height: 19),
              itemBuilder: (context, index) {
                final card = filteredCards[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xFF27313B), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ).copyWith(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2640),
                                  color: Color(0xFF273130),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 5,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,

                                    children: [
                                      ClipOval(
                                        child: Image.network(
                                          card.imageUrl,
                                          height: 49,
                                          width: 49,
                                        ),
                                      ),
                                      SizedBox(width: 1),
                                      Column(
                                        children: [
                                          Text(
                                            card.name,
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "Category: ${card.category}",
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3300),
                                  color: Color(0xFF273130),
                                ),

                                child: Center(
                                  child: Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image:
                                  card.backgroundImageUrl != null
                                      ? DecorationImage(
                                        image: NetworkImage(
                                          card.backgroundImageUrl!,
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                      : null,
                              gradient:
                                  card.backgroundImageUrl == null
                                      ? const LinearGradient(
                                        colors: [
                                          Color(0xFF160FF7),
                                          Color(0xFFFC5000),
                                        ],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                      )
                                      : null,
                            ),

                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 33,
                              ),
                              decoration: BoxDecoration(
                                gradient:
                                    card.backgroundImageUrl == null
                                        ? null
                                        : LinearGradient(
                                          colors: [
                                            Color(0xFF1E2730),
                                            Color(0xFF000000),
                                            Color(0xFF11171C).withAlpha(204),
                                            Color(0xFF11171C),
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                border:
                                    card.backgroundImageUrl == null
                                        ? null
                                        : Border.all(
                                          color: Color(0xFF27313B),
                                          width: 1,
                                        ),

                                color:
                                    card.backgroundImageUrl != null
                                        ? Colors.black.withAlpha(150)
                                        : null,
                                borderRadius: BorderRadius.circular(10),
                              ),

                              child: Text(
                                card.quote,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2420),
                                  color: Color(0xFF273130),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 7,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: Color(0xFFF24E1E),
                                      ),
                                      SizedBox(width: 11),
                                      Text(
                                        "${card.likes}",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white.withAlpha(128),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2420),
                                  color: Color(0xFF273130),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 7,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.bookmark,
                                        color: Color(0xFFFFCD1B),
                                      ),
                                      SizedBox(width: 11),
                                      Text(
                                        "${card.bookmarkCount}",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white.withAlpha(128),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // To allow for shadow
      isScrollControlled: false,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E2730),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(33),
              topRight: Radius.circular(33),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(77),
                blurRadius: 14.4,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24, top: 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Drag handle and close icon row
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                        left: 16,
                        right: 16,
                        bottom: 8,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Container(
                                width: 48,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(60),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Category list
                    ...categories.map((cat) {
                      final isSelected = selectedCategory == cat['name'];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = cat['name'];
                          });
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: 348,
                            height: 42,
                            margin: const EdgeInsets.symmetric(
                              vertical: 7,
                              horizontal: 0,
                            ),
                            padding: const EdgeInsets.only(
                              left: 14,
                              right: 16,
                              top: 8,
                              bottom: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? Colors.white.withOpacity(0.06)
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                // Drop shadow 1
                                BoxShadow(
                                  color: const Color(0x66000000), // #00000040
                                  blurRadius: 7.5,
                                  offset: const Offset(0, 4),
                                ),
                                // Drop shadow 2
                                BoxShadow(
                                  color: const Color(0x66000000), // #00000040
                                  blurRadius: 11.1,
                                  offset: const Offset(0, 2),
                                ),
                                // Inner shadow 1 (simulated)
                                BoxShadow(
                                  color: const Color(0x33516A82), // #516A8233
                                  blurRadius: 10.7,
                                  offset: const Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                                // Inner shadow 2 (simulated)
                                BoxShadow(
                                  color: const Color(0x4D6E87A0), // #6E87A04D
                                  blurRadius: 0,
                                  offset: const Offset(0, 1),
                                  spreadRadius: 0,
                                ),
                              ],
                              border: Border(
                                bottom: BorderSide(
                                  color: const Color(0xFF32363A), // #32363A
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  cat['emoji'],
                                  style: TextStyle(
                                    fontSize: 24,
                                    color:
                                        isSelected
                                            ? Color(0xFFF23943)
                                            : Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ), // gap between icon and text
                                Text(
                                  cat['name'],
                                  style: TextStyle(
                                    color:
                                        isSelected
                                            ? Color(0xFFF23943)
                                            : Colors.white,
                                    fontSize: 16,
                                    fontWeight:
                                        isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
