import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';

import 'gallery_view_model.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  GalleryViewModel _model;

  @override
  void initState() {
    super.initState();
    _model = Provider.of<GalleryViewModel>(context, listen: false);
    _model.loadData();
  }

  @override
  Widget build(BuildContext context) {
    _model = Provider.of<GalleryViewModel>(context);
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
        if (!_model.isLoading) {
          _model.loadData();
        }
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _model.items.length,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                  child: GestureDetector(
                    onTap: () => showFullscreenImage(index),
                    child: Card(
                      child: Column(
                        children: [
                          Stack(alignment: AlignmentDirectional.center, children: [
                            CircularProgressIndicator(),
                            FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: _model.items[index].urls.small,
                            ),
                          ]),
                          Text(_model.items[index].user.name),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _model.isLoading ? LinearProgressIndicator() : Container()
          ],
        ),
      ),
    );
  }

  void showFullscreenImage(int index) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black,
        pageBuilder:
            (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
          return Center(
            child: Container(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  CircularProgressIndicator(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                        _model.items[index].urls.full,
                        fit: BoxFit.contain,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
