class ImageCData {
  ImageCData({
    this.imagePath = '',
    this.title,
    this.desc,
  });

  String imagePath;
  String title;
  String desc;

  static List<ImageCData> tabIconsList = <ImageCData>[
    ImageCData(
      imagePath: 'assets/images/calculator0.png',
      title: 'CALCULAZI',
      desc: 'Make your task eazier & faster with us',
    ),
    ImageCData(
      imagePath: 'assets/images/calculator1.png',
      title: 'SCIENTIFIC',
      desc: 'Coming soon we will add a sciencetific, and manymore',
    ),
    ImageCData(
      imagePath: 'assets/images/calculator2.png',
      title: 'SIMPLE',
      desc: 'We give you a better design with neumorphic',
    ),
  ];
}
