import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

import 'package:idsr/data/entity/models/tracked_entity.dart';

import '../routes/routes_name.dart';

class InfiniteScrollRow extends StatefulWidget {
  final List<TrackedEntity> trackedEntity;

  InfiniteScrollRow(this.trackedEntity);

  @override
  _InfiniteScrollRowState createState() => _InfiniteScrollRowState();
}

class _InfiniteScrollRowState extends State<InfiniteScrollRow> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
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
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScrolling());
  }

  @override
  void dispose() {
    _stopScrolling();
    _scrollController.dispose();
    super.dispose();
  }

  void _startScrolling() {
    if (_timer?.isActive ?? false) {
      return; // Timer is already running
    }
    _timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.offset;

        double newOffset =
            currentScroll + _scrollSpeed * 16 / 1000; // px per frame

        if (newOffset >= maxScroll) {
          // Loop back to start
          _scrollController.jumpTo(0);
        } else {
          _scrollController.jumpTo(newOffset);
        }
      }
    });
  }

  void _stopScrolling() {
    _timer?.cancel();
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
        itemCount: widget.trackedEntity.length,
        itemBuilder: (context, index) {
          Enrollment enrollment = widget.trackedEntity[index].enrollments[0];
          TeiAttribute? eventNameAttribute =
              widget.trackedEntity[index].attributes.firstWhereOrNull(
                    (attr) => attr.attribute == "LEAwqoW5Rtc",
                    // orElse: () => null,
                  );
          final eventname = eventNameAttribute?.value;
          return InkWell(
            onTap: () {
              // Handle click, for example, show a dialog or navigate
              print('Tapped on: $eventname');
              context.pushNamed(SIGNAL_DETAILS,
                  extra: {
                    "entity": widget.trackedEntity[index],
                  });
            },
            onHighlightChanged: (isHighlighted) {
              if (isHighlighted) {
                _stopScrolling();
              } else {
                _startScrolling();
              }
            },
            child: Container(
              // width: 200,
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16), // rounded corners
              ),
              child: Center(
                child: Text(
                  '$eventname | ${enrollment.orgUnitName}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
