import 'package:flutter/material.dart';
import 'package:test_assignment/background_image.dart';
import 'package:test_assignment/page_view.dart';

void main() => runApp(MoviePage());

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  var movieList = <String>[];

  @override
  void initState() {
    movieList.addAll([
        "https://i.picsum.photos/id/100/2500/1656.jpg?hmac=gWyN-7ZB32rkAjMhKXQgdHOIBRHyTSgzuOK6U0vXb1w",
        "https://i.picsum.photos/id/1000/5626/3635.jpg?hmac=qWh065Fr_M8Oa3sNsdDL8ngWXv2Jb-EE49ZIn6c0P-g",
        "https://i.picsum.photos/id/10/2500/1667.jpg?hmac=J04WWC_ebchx3WwzbM-Z4_KC_LeLBWr5LZMaAkWkF68",
        "https://i.picsum.photos/id/1001/5616/3744.jpg?hmac=38lkvX7tHXmlNbI0HzZbtkJ6_wpWyqvkX4Ty6vYElZE",
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: SnapClipPageView(
          backgroundBuilder: buildBackground,
          itemBuilder: buildChild,
          length: movieList.length,
        ),
      ),
    );
  }

  BackgroundImageWidget buildBackground(_, index) {
    String movie = movieList[index];
    return BackgroundImageWidget(
      key: Key(index.toString()),
      child: Image.network(movie, fit: BoxFit.fill),
      index: index,
    );
  }

  PageViewItem buildChild(_, int index) {
    String movie = movieList[index];
    return PageViewItem(
      key: Key(index.toString()),
      child: Image.network(
        movie,
      ),
//      height: 405,
      index: index,
    );
  }
}