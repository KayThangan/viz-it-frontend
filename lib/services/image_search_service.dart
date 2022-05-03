import 'dart:convert';

import 'package:viz_it_app/global.dart';
import 'package:http/http.dart' as http;
import 'package:viz_it_app/models/image.dart';
import 'package:viz_it_app/states/image_search_state.dart';

class ImageSearchService {
  Future<void> uploadImage() async {
    final json =
        jsonEncode(ImageSearch.ImageSearchToJson(ImageSearchState.imageSearch));

    Uri uri = Uri.parse(API_URL + '/image-search/upload/');

    var response = await http.post(uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json);
    print("Uploading Responses: " + response.body);
  }

  Future<String> getResultImage() async {
    Uri uri = Uri.parse(API_URL + '/image-search/result/');
    var response = await http.get(uri, headers: {'Content-Type': 'application/json; charset=UTF-8'});
    print("Getting Result Image Path: " + response.body);

    Map<String, dynamic> responseMap;
    String resultPath = "";
    if (response.statusCode == 200) {
      responseMap = jsonDecode(response.body);
      resultPath = ImageSearch.resutPathFromJsom(responseMap);
    } else {
      print("Error ${response.statusCode}");
    }
    return resultPath;
  }

  Future<List<ImageData>> getImageDatas() async {
    Uri uri = Uri.parse(API_URL + '/image-search/datas/');
    var response = await http.get(uri, headers: {'Content-Type': 'application/json; charset=UTF-8'});
    print("Getting Image Datas: " + response.body);

    Map<String, dynamic> responseMap;
    List<ImageData> imageDatas = [];
    if (response.statusCode == 200) {
      responseMap = jsonDecode(response.body);
      imageDatas = ImageSearch.imageDatasFromJson(responseMap);
    } else {
      print("Error ${response.statusCode}");
    }
    return imageDatas;
  }
}
