import 'package:flutter/material.dart';
import 'package:sports_app/Utils/Constants/images.dart';
import 'package:sports_app/Utils/Constants/text.dart';
import 'package:sports_app/Utils/Constants/ui.dart';
import 'package:sports_app/models/quote_card.dart';

class SavedQuotes extends StatefulWidget {
  const SavedQuotes({super.key});

  @override
  State<SavedQuotes> createState() => _SavedQuotesState();
}

class _SavedQuotesState extends State<SavedQuotes> {
  final List<QuoteCard> quoteCards = [
    QuoteCard(
      name: "Grane Smith",
      category: "Cricket",
      quote: LoremIpsum.p5,
      likes: 54,
      bookmarkCount: 5,
      imageUrl: Images.img6,
    ),
    QuoteCard(
      name: "John Doe",
      category: "Football",
      quote:
          LoremIpsum.p6,
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

  @override
  Widget build(BuildContext context) {
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
                  ), 
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
                      "Saved Quotes",
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
            SizedBox(height: 14),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Color(0xFFFFFFFF),
                    fontFamily: 'Poppins',
                  ),
                  children: [
                    const TextSpan(text: "Saved Quotes -"),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFFC5000), Color(0xFFFC5000)],
                          ).createShader(bounds);
                        },
                        child: const Text(
                          "Motivate",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    WidgetSpan(
                      alignment:
                          PlaceholderAlignment
                              .middle, // Ensures vertical alignment
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF9F0FF7), Color(0xFFF03F3F)],
                          ).createShader(bounds);
                        },
                        child: const Text(
                          "Yourself Anytime!",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: quoteCards.length,
              separatorBuilder: (context, index) => const SizedBox(height: 19),
              itemBuilder: (context, index) {
                final card = quoteCards[index];
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
                                    horizontal: 7,vertical: 5,
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
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [Color(0xFF160FF7), Color(0xFFFC5000)],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                            ),

                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 33,
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
}
