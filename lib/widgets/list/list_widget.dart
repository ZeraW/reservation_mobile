import 'package:flutter/material.dart';
import 'package:reservation_mobile/constants/constants.dart';

class ListWidget extends StatefulWidget {
  final List<Widget> children;
  final bool? isLoading;
  final bool? isEnableLoadMore;
  final bool? isLoadingMore;
  final VoidCallback? readMore;
  const ListWidget(
    this.children,
     {this.isLoading = false,
    this.isEnableLoadMore = false,
    this.isLoadingMore = false,
    this.readMore,
    Key? key,
  }) : super(key: key);

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  ScrollController scrollController = ScrollController(initialScrollOffset: 0);

  Widget getList() {
    Widget current = Container();

    if (widget.isLoading!) {
      current = const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (widget.children.isNotEmpty) {
        current = ListView.builder(
          physics: const ScrollPhysics(),
          itemCount: (widget.isLoadingMore!
              ? widget.children.length + 1
              : widget.children.length),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return (index == widget.children.length
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : widget.children[index]);
          },
        );
      } else {
        current = const Center(
          child: Text(
            'nothing Found',
            style:  TextStyle(
                fontWeight: fontWeight600,
                fontSize: fontSize15,
                color: blackFontColor),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
      ),
      child: current,
    );
  }

  Widget getContent() {
    return getList();
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
