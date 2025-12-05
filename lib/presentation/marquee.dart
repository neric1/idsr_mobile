import 'package:flutter/material.dart';
import 'dart:async';

class InfiniteScrollRow extends StatefulWidget {
  @override
  _InfiniteScrollRowState createState() => _InfiniteScrollRowState();
}

class _InfiniteScrollRowState extends State<InfiniteScrollRow> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;
  double _scrollSpeed = 50; // pixels per second

  // Sample data
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];

  @override
  void initState() {
    super.initState();

    // Start the auto-scrolling
    _timer = Timer.periodic(Duration(milliseconds: 16), (_) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.offset;

        double newOffset = currentScroll + _scrollSpeed * 16 / 1000; // px per frame

        if (newOffset >= maxScroll) {
          // Loop back to start
          _scrollController.jumpTo(0);
        } else {
          _scrollController.jumpTo(newOffset);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Duplicate the list to make looping smooth
    final extendedColors = [...colors, ...colors];

    return SizedBox(
      height: 20,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: extendedColors.length,
        itemBuilder: (context, index) {
          return Container(
            // width: 200,
            margin: EdgeInsets.symmetric(horizontal: 8),
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(16), // rounded corners
            ),
            child: Center(
              child: Text(
                'Measles | UGANDA',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}


