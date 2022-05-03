import 'package:flutter/cupertino.dart';
import 'package:viz_it_app/models/image.dart';
import 'package:viz_it_app/services/image_search_service.dart';

class ImageSearchState extends ChangeNotifier {
  ImageSearchService service = ImageSearchService();

  static ImageSearch imageSearch = ImageSearch(
    image: "",
    resultImage: "",
    imageDatas: [],
  );

  Future<void> uploadImage() async {
    await service.uploadImage();
    notifyListeners();
  }

  Future<void> getResultImage() async {
    String path = await service.getResultImage();
    imageSearch = imageSearch.setDetails(resultImage: path);
  }

  Future<void> getImageDatas() async {
    List<ImageData> datas = await service.getImageDatas();
    imageSearch = imageSearch.setDetails(imageDatas: datas);
  }
}
