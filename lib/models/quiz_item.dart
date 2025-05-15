import 'package:sports_app/Utils/Constants/images.dart';

class QuizItem {
  final String title;
  final String description;
  final String imageUrl;

  QuizItem(this.title, this.description, this.imageUrl);
}

final List<QuizItem> quizList = [
  QuizItem("Cricket Quiz", "Test your knowledge on World Cups, legendary players, and memorable matches.", Images.img17),
  QuizItem("Football Quiz", "Test your knowledge on World Cups, legendary players, and memorable matches.", Images.img18),
  QuizItem("Tennis Quiz", "Test your knowledge on World Cups, legendary players, and memorable matches.", Images.img19),
];
