class ImageSearch {
  final String image;
  final String resultImage;
  final List<ImageData> imageDatas;
  double imageWidth = 0;
  double imageHeight = 0;

  ImageSearch({
    required this.image,
    required this.resultImage,
    required this.imageDatas,
  });

  void setImageWidth(double width) {
    this.imageWidth = width;
  }

  double getImageWidth() {
    return this.imageWidth;
  }

  void setImageHeight(double height) {
    this.imageHeight = height;
  }

  double getImageHeight() {
    return this.imageHeight;
  }

  ImageSearch setDetails({
    String? image,
    String? resultImage,
    List<ImageData>? imageDatas,
  }) =>
      ImageSearch(
        image: image ?? this.image,
        resultImage: resultImage ?? this.resultImage,
        imageDatas: imageDatas ?? this.imageDatas,
      );

  static String resutPathFromJsom(Map<String, dynamic> json) {
    return json['result_image'];
  }

  static Map<String, dynamic> ImageSearchToJson(ImageSearch image) {
    return {
      "image": image.image,
    };
  }

  static List<ImageData> imageDatasFromJson(Map<String, dynamic> json) {
    return List.from(json['datas']).map((e) => ImageData.dataFromJsom(e)).toList();
  }
}

class ImageData {
  final String object;
  final int y1;
  final int x1;
  final int y2;
  final int x2;

  ImageData({
    required this.object,
    required this.y1,
    required this.x1,
    required this.y2,
    required this.x2,
  });

  static ImageData dataFromJsom(Map<String, dynamic> json) {
    return ImageData(
      object: json['object_class'],
      y1: json['y1'],
      x1: json['x1'],
      y2: json['y2'],
      x2: json['x2'],
    );
  }
}
