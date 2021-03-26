import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swallowing_app/models/thumbnail.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class GenThumbnailImage extends StatefulWidget {
  final ThumbnailRequest thumbnailRequest;
  final String parentWidget;

  const GenThumbnailImage({Key key, this.thumbnailRequest, this.parentWidget}) : super(key: key);

  @override
  _GenThumbnailImageState createState() => _GenThumbnailImageState();
}

class _GenThumbnailImageState extends State<GenThumbnailImage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThumbnailResult>(
      future: genThumbnail(widget.thumbnailRequest),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final _image = snapshot.data.image;
          return FittedBox(
            fit: BoxFit.cover,
            child: _image,
          );
        } else if (snapshot.hasError) {
          return (widget.parentWidget == 'VideoWidget')
          ? Center(
            child: Icon(
              Icons.no_photography_outlined,
              size: 40,
              color: Colors.white,
            )
          )
          : SizedBox.shrink();
        } else {
          return (widget.parentWidget == 'VideoWidget')
            ? Center(
              child: CircularProgressIndicator()
            )
            : SizedBox.shrink();
        }
      },
    );
  }
}

Future<ThumbnailResult> genThumbnail(ThumbnailRequest r) async {
  Uint8List bytes;
  final Completer<ThumbnailResult> completer = Completer();

  if (r.thumbnailPath != null) {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: r.video,
        thumbnailPath: r.thumbnailPath,
        imageFormat: r.imageFormat,
        maxHeight: r.maxHeight,
        maxWidth: r.maxWidth,
        timeMs: r.timeMs,
        quality: r.quality);
    final file = File(thumbnailPath);
    bytes = file.readAsBytesSync();
  } else {
    bytes = await VideoThumbnail.thumbnailData(
        video: r.video,
        imageFormat: r.imageFormat,
        maxHeight: r.maxHeight,
        maxWidth: r.maxWidth,
        timeMs: r.timeMs,
        quality: r.quality);
  }

  int _imageDataSize = bytes.length;
  final _image = Image.memory(bytes);

  _image.image
      .resolve(ImageConfiguration())
      .addListener(ImageStreamListener((ImageInfo info, bool _) {
    completer.complete(ThumbnailResult(
      image: _image,
      dataSize: _imageDataSize,
      height: info.image.height,
      width: info.image.width,
    ));
  }));

  return completer.future;
}