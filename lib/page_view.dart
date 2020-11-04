import 'package:flutter/material.dart';
import './background_image.dart';

import './page_ctrl_provider.dart';

class SnapClipPageView extends StatefulWidget {
  final int length;
  final int initialIndex;
  final BackgroundImageWidget Function(BuildContext context, int index)
  backgroundBuilder;
  final PageViewItem Function(BuildContext context, int index) itemBuilder;
//  final void Function(int index) onPageChanged;

  const SnapClipPageView({
    Key key,
//    this.onPageChanged,
    this.initialIndex = 1,
    @required this.backgroundBuilder,
    @required this.itemBuilder,
    @required this.length,
  }) : super(key: key);

  @override
  _SnapClipPageViewState createState() => _SnapClipPageViewState();
}

class _SnapClipPageViewState extends State<SnapClipPageView> {
  PageController ctrl;

  @override
  void initState() {
    ctrl = PageController(viewportFraction: .75);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctrl.jumpToPage(widget.initialIndex);
    });
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageCtrlProvider(
      pageCtrl: ctrl,
      child: Stack(
        children: <Widget>[
          Stack(
            children: List.generate(
              widget.length,
                  (index) => widget.backgroundBuilder(context, index),
            ),
          ),
          PageView.builder(
//            onPageChanged: widget.onPageChanged,
            controller: ctrl,
            itemCount: widget.length,
            itemBuilder: widget.itemBuilder,
          ),
        ],
      ),
    );
  }
}

class PageViewItem extends StatefulWidget {
  final int index;
  final Widget child;
  final AlignmentGeometry alignment;

  const PageViewItem({
    @required this.index,
    @required this.child,
    this.alignment = Alignment.bottomCenter,
    Key key,
  }) : super(key: key);
  @override
  _PageViewItemState createState() => _PageViewItemState();
}

class _PageViewItemState extends State<PageViewItem> {

  PageController pageCtrl;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pageCtrl = PageCtrlProvider.of(context).pageCtrl;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: widget.child,
      ),
    );
  }
}