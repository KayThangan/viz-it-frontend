import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viz_it_app/models/image.dart';
import 'package:viz_it_app/states/image_search_state.dart';
import 'package:viz_it_app/widgets/build_bottom_nav_bar.dart';
import 'package:viz_it_app/widgets/build_bottom_sheet_widget.dart';
import 'package:viz_it_app/widgets/build_image_picker.dart';
import 'package:viz_it_app/widgets/live_feed_widget.dart';
import 'package:viz_it_app/widgets/toggle_widget.dart';

import '../theme/theme_manager.dart';
import '../widgets/base_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  bool isUploadSelected = false;
  bool isChoiceSelected = false;
  bool isLiveSelected = false;
  BuildImagePicker imageController = BuildImagePicker();

  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    File imagePath = File("");

    return Scaffold(
      backgroundColor: theme.themeData?.canvasColor,
      appBar: AppBar(
        backgroundColor: theme.themeData?.canvasColor,
        elevation: 0,
        title: Image.asset(
          'assets/logo-name.png',
          height: 100,
          fit: BoxFit.fitHeight,
        ),
      ),
      bottomNavigationBar: BuildBottomNavBar(
        onUploadSelected: () {
          isUploadSelected = !isUploadSelected;
          print("isUploadSelected: " + isUploadSelected.toString());
          isLiveSelected = false;
          setState(() {});
        },
        onLiveSelected: () {
          isLiveSelected = !isLiveSelected;
          print("isLiveSelected: " + isLiveSelected.toString());
          isUploadSelected = false;
          setState(() {});
        },
      ),
      floatingActionButton: SizedBox(
        width: 75,
        // height: 20,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: theme.themeData?.canvasColor,
            onPressed: () {},
            child: Image(
              image: AssetImage("assets/logo.png"),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: BaseWidget<ImageSearchState>(
          state: Provider.of<ImageSearchState>(context),
          onStateReady: (state) {},
          builder: (context, state, child) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                child: Stack(
                  children: [
                    ImageSearchState.imageSearch.image == ""
                        ? Center(
                            child: Image(
                              image: AssetImage("assets/logo.png"),
                              width: 200,
                            ),
                          )
                        : ToggleWidget(),
                    Visibility(
                      visible: isUploadSelected,
                      child: Positioned(
                        bottom: 10,
                        right: (screenWidth / 4) - 25,
                        child: SizedBox(
                          width: 50,
                          // height: 20,
                          child: FittedBox(
                            child: FloatingActionButton(
                              backgroundColor: theme.themeData?.canvasColor,
                              onPressed: () async {
                                imagePath = await imageController
                                    .onClickedButton(isGallery: false);
                                print("image Path: " + imagePath.path);
                                final bytes = await imagePath.readAsBytes();
                                ImageSearchState.imageSearch = ImageSearchState
                                    .imageSearch
                                    .setDetails(image: base64.encode(bytes));
                                await state.uploadImage();
                                await state.getResultImage();
                                await state.getImageDatas();
                                isUploadSelected = !isUploadSelected;
                                isChoiceSelected = true;
                                var decodedImage = await decodeImageFromList(
                                    imagePath.readAsBytesSync());
                                ImageSearchState.imageSearch.setImageWidth(
                                    decodedImage.width.toDouble());
                                ImageSearchState.imageSearch.setImageHeight(
                                    decodedImage.height.toDouble());
                                print(ImageSearchState.imageSearch
                                        .getImageWidth()
                                        .toString() +
                                    "       " +
                                    ImageSearchState.imageSearch
                                        .getImageHeight()
                                        .toString());
                                print(screenWidth.toString() +
                                    "       " +
                                    screenHeight.toString());
                                setState(() {});
                                setState(() {});
                              },
                              child: Padding(
                                padding: EdgeInsets.all(2),
                                child: Icon(
                                  CupertinoIcons.camera,
                                  size: 35,
                                  color: theme.themeData?.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isUploadSelected,
                      child: Positioned(
                        bottom: 75,
                        right: (screenWidth / 4) - 25,
                        child: SizedBox(
                          width: 50,
                          // height: 20,
                          child: FittedBox(
                            child: FloatingActionButton(
                              backgroundColor: theme.themeData?.canvasColor,
                              onPressed: () async {
                                imagePath = await imageController
                                    .onClickedButton(isGallery: true);
                                print("image Path: " + imagePath.path);
                                final bytes = await imagePath.readAsBytes();
                                ImageSearchState.imageSearch = ImageSearchState
                                    .imageSearch
                                    .setDetails(image: base64.encode(bytes));
                                await state.uploadImage();
                                await state.getResultImage();
                                await state.getImageDatas();
                                isUploadSelected = !isUploadSelected;
                                isChoiceSelected = true;
                                var decodedImage = await decodeImageFromList(
                                    imagePath.readAsBytesSync());
                                ImageSearchState.imageSearch.setImageWidth(
                                    decodedImage.width.toDouble());
                                ImageSearchState.imageSearch.setImageHeight(
                                    decodedImage.height.toDouble());
                                print(ImageSearchState.imageSearch
                                        .getImageWidth()
                                        .toString() +
                                    "       " +
                                    ImageSearchState.imageSearch
                                        .getImageHeight()
                                        .toString());
                                print(screenWidth.toString() +
                                    "       " +
                                    screenHeight.toString());
                                setState(() {});
                              },
                              child: Padding(
                                padding: EdgeInsets.all(0.5),
                                child: Icon(
                                  CupertinoIcons.photo_on_rectangle,
                                  size: 35,
                                  color: theme.themeData?.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    for (ImageData data
                        in ImageSearchState.imageSearch.imageDatas)
                      Positioned(
                        top: ((data.y1 + ((data.y2 - data.y1) / 2)) /
                                (ImageSearchState.imageSearch.getImageHeight() /
                                    screenWidth)) +
                            38,
                        left: ((data.x1 + ((data.x2 - data.x1) / 2)) /
                                (ImageSearchState.imageSearch.getImageWidth() /
                                    screenWidth)) -
                            16,
                        child: SizedBox(
                          width: 20,
                          child: FloatingActionButton(
                            backgroundColor: theme.themeData?.canvasColor,
                            onPressed: () {
                              String searchQuery =
                                  data.object.replaceAll(" ", "+");
                              BuildBottomSheetWidget(context, searchQuery);
                            },
                            child: Icon(
                              CupertinoIcons.add_circled,
                              color: theme.themeData?.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    Visibility(
                      visible: isChoiceSelected &&
                          ImageSearchState.imageSearch.imageDatas.isEmpty,
                      child: Positioned(
                        top: 38,
                        left: 0,
                        child: Center(
                          child: Container(
                            height: screenWidth + 12,
                            width: screenWidth - 16,
                            child: Center(
                              child: Text(
                                "No Object was Found!",
                                style: theme.themeData?.textTheme.bodyLarge,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                gradient: LinearGradient(
                                    begin: FractionalOffset.topCenter,
                                    end: FractionalOffset.bottomCenter,
                                    colors: [
                                      Colors.grey.withOpacity(0.0),
                                      Colors.black,
                                    ],
                                    stops: [
                                      0.0,
                                      1.0
                                    ])),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isLiveSelected,
                      child: LiveFeedWidget(),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: theme.themeData?.backgroundColor,
                ),
              ),
            );
          }),
    );
  }
}
