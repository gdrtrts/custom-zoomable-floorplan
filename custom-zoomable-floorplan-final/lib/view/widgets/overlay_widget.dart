import 'package:custom_zoomable_floorplan/view/shared/global.dart';
import 'package:flutter/material.dart';

class OverlayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: Container(
        color: Global.blue.withOpacity(0.85),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.touch_app,
                color: Colors.white,
                size: 40.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Start by dragging with your fingers',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
