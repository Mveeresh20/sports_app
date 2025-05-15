import 'Constants/images.dart';
import 'Constants/text.dart';

class AdminQuote {
  final String id;
  final String text;
  final String imageUrl;
  final String category;

  AdminQuote({
    required this.id,
    required this.text,
    required this.imageUrl,
    required this.category,
  });
}

final List<AdminQuote> adminQuotes = [
  AdminQuote(
    id: '1',
    text: LoremIpsum.p6,
    imageUrl: Images.img1,
    category: 'Cricket',
  ),
  AdminQuote(
    id: '2',
    text: LoremIpsum.p7,
    imageUrl: Images.img2,
    category: 'Cricket',
  ),
  AdminQuote(
    id: '3',
    text: LoremIpsum.p8,
    imageUrl: Images.img3,
    category: 'Cricket',
  ),
  AdminQuote(
    id: '4',
    text: LoremIpsum.p9,
    imageUrl: Images.img4,
    category: 'Cricket',
  ),
  AdminQuote(
    id: '5',
    text: LoremIpsum.p10,
    imageUrl: Images.img5,
    category: 'Cricket',
  ),
  AdminQuote(
    id: '6',
    text: LoremIpsum.p11,
    imageUrl: Images.img6,
    category: 'Cricket',
  ),
];