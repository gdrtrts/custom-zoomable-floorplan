import 'package:custom_zoomable_floorplan/core/viewmodels/floorplan_model.dart';
import 'package:custom_zoomable_floorplan/view/shared/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class RemoveScrollGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class DragAndScale extends ScaleGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}

class RawGestureDetectorWidget extends StatelessWidget {
  final Widget child;

  RawGestureDetectorWidget({this.child});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final model = Provider.of<FloorPlanModel>(context);

    final _gestures = {
      DragAndScale: GestureRecognizerFactoryWithHandlers<DragAndScale>(
        () => DragAndScale(),
        (DragAndScale instance) {
          instance
            ..onStart = (details) {
              model.handleDragScaleStart(details);
            }
            ..onUpdate = (details) {
              model.handleDragScaleUpdate(details);
            }
            ..onEnd = (_) {
              model.handleDragScaleEnd();
            };
        },
      )
    };

    final AlignmentGeometry _alignment = FractionalOffset.fromOffsetAndRect(
      Offset(
        size.width / 2.0,
        size.height / 2.0,
      ),
      Rect.fromLTRB(
        0.0,
        0.0,
        size.width,
        size.height,
      ),
    );

    final Matrix4 _transform = Matrix4.diagonal3(
      Vector3(
        model.scale,
        model.scale,
        model.scale,
      ),
    )..translate(
        model.pos.x,
        model.pos.y,
      );

    return RawGestureDetector(
      gestures: _gestures,
      child: Container(
        color: Global.blue,
        child: Transform(
          alignment: _alignment,
          transform: _transform,
          child: ScrollConfiguration(
            behavior: RemoveScrollGlow(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
