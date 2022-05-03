import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import '../theme/theme_manager.dart';
import 'build_bottom_sheet_widget.dart';

class LiveFeedWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LiveFeedWidgetState();
  }
}

class _LiveFeedWidgetState extends State<LiveFeedWidget> {
  CameraController? cameraController;
  CameraImage? cameraImage;
  List recognitionsList = [];

  initCamera() async {
    var cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    cameraController?.initialize().then((value) {
      setState(() {
        cameraController?.startImageStream((image) => {
              cameraImage = image,
              runModel(),
            });
      });
    });
  }

  runModel() async {
    recognitionsList = (await Tflite.detectObjectOnFrame(
      bytesList: cameraImage?.planes.map((plane) {
            return plane.bytes;
          }).toList() ??
          [],
      imageHeight: cameraImage?.height ?? 0,
      imageWidth: cameraImage?.width ?? 0,
      imageMean: 127.5,
      imageStd: 127.5,
      numResultsPerClass: 1,
      threshold: 0.7,
    ))!;

    setState(() {
      cameraImage;
    });
  }

  Future loadModel() async {
    Tflite.close();
    await Tflite.loadModel(
        model: "assets/model.tflite", labels: "assets/labels.txt");
  }

  @override
  void dispose() {
    super.dispose();

    cameraController?.stopImageStream();
    Tflite.close();
  }

  @override
  void initState() {
    super.initState();

    loadModel();
    initCamera();
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    if (recognitionsList == null) return [];

    double factorX = screen.width - 16;
    double factorY = screen.height - 100;

    return recognitionsList.map((result) {
      Color color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
      return Stack(
        children: [
          Positioned(
            left: result["rect"]["x"] * factorX,
            top: result["rect"]["y"] * factorY,
            width: result["rect"]["w"] * factorX,
            height: result["rect"]["h"] * factorY,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: color, width: 2.0),
              ),
              child: Text(
                "${result['detectedClass']} ${(result['confidenceInClass'] * 100).toStringAsFixed(0)}%",
                style: TextStyle(
                  background: Paint()..color = color,
                  color: color.computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Positioned(
            top: ((result["rect"]["h"] * factorY) / 2) + 38,
            left: result["rect"]["x"] * factorX +
                ((result["rect"]["w"] * factorX) / 2) -
                16,
            child: SizedBox(
              width: 20,
              child: FloatingActionButton(
                backgroundColor: theme.themeData?.canvasColor,
                onPressed: () {
                  String searchQuery = result['detectedClass'].toString();
                  BuildBottomSheetWidget(context, searchQuery);
                },
                child: Icon(
                  CupertinoIcons.add_circled,
                  color: theme.themeData?.primaryColor,
                ),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> list = [];

    list.add(
      Container(
        height: size.height - 100,
        child: (!(cameraController?.value.isInitialized ?? false))
            ? new Container()
            : AspectRatio(
                aspectRatio: cameraController?.value.aspectRatio ?? 0,
                child: CameraPreview(cameraController!),
              ),
      ),
    );

    if (cameraImage != null) {
      list.addAll(displayBoxesAroundRecognizedObjects(size));
    }

    return Stack(
      children: list,
    );
  }
}
