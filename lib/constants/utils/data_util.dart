import 'dart:math';

class DataUtils {
  DataUtils._privateConstructor();
  static final DataUtils _instance = DataUtils._privateConstructor();

  static DataUtils get instance => _instance;

  String randomNicknameGenerator() {
    const first = [
      "멋있는",
      "유쾌한",
      "화려한",
      "깔끔한",
      "열정적인",
      "매력적인",
    ];
    const second = [
      "루피",
      "조로",
      "상디",
      "우솝",
      "나미",
      "쵸파",
    ];
    return '${first.elementAt(Random().nextInt(first.length))} ${second.elementAt(Random().nextInt(second.length))}';
  }
}
