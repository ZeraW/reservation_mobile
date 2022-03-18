import 'package:flutter/material.dart';

class GridWidget extends StatefulWidget {
  final List<Widget> children;
  final double? aspectRatio;
  final int? crossAxisCount;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final bool? isLoading;
  final bool? isEnableLoadMore;
  final bool? isLoadingMore;
  final VoidCallback? readMore;
  GridWidget(
    this.children,
    this.aspectRatio,
    this.crossAxisCount,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
    this.isLoading, {
    this.isEnableLoadMore = false,
    this.isLoadingMore=false,
    this.readMore,
    Key? key,
  }) : super(key: key);

  @override
  State<GridWidget> createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  ScrollController scrollController = ScrollController(initialScrollOffset: 0);

  Widget getList() {
    Widget current = Container();

    if (widget.isLoading!) {
      current = const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      current = Column(
        children: [
          Expanded(
            child: GridView.count(
              physics: const ScrollPhysics(),
              controller: scrollController,
              childAspectRatio: widget.aspectRatio!,
              crossAxisCount: widget.crossAxisCount!,
              crossAxisSpacing: widget.crossAxisSpacing!,
              mainAxisSpacing: widget.mainAxisSpacing!,
              shrinkWrap: true,
              children: List.generate(
                widget.children.length,
                (index) {
                  return widget.children[index];
                },
              ),
            ),
          ),
          widget.isLoadingMore!
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container()
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
      ),
      child: current,
    );
  }

  Widget getContent() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: getList(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEnableLoadMore!) {
      scrollController.addListener(
        () {
          if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels) {
            widget.readMore!();
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return getContent();
  }
}
