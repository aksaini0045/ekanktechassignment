import './models.dart';

class Content {
  Content._privateConstructor();
  static final Content instance = Content._privateConstructor();

  List<Story> get publicstorylist {
    return _storylist;
  }

  final List<Story> _storylist = [
    Story(
      storyid: '1',
      storyimagepath: 'assets/images/1.jpg',
      storyurl:
          'https://www.thisday.app/en/details/renaissance-man-of-indian-cricket',
      viewduration: const Duration(seconds: 12),
    ),
    Story(
      storyid: '2',
      storyimagepath: 'assets/images/2.jpg',
      storyurl:
          'https://www.thisday.app/en/details/maharaja-his-castle-and-art-love',
      viewduration: const Duration(seconds: 12),
    ),
    Story(
      storyid: '3',
      storyimagepath: 'assets/images/3.jpg',
      storyurl: 'https://www.thisday.app/en/details/a-demigod-behind-the-mic',
      viewduration: const Duration(seconds: 12),
    ),
    Story(
      storyid: '4',
      storyimagepath: 'assets/images/4.jpg',
      storyurl: 'https://www.thisday.app/en/details/turfnado-pillay',
      viewduration: const Duration(seconds: 12),
    )
  ];
}
