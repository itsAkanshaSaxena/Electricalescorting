import 'package:flutter/material.dart';

class OverlayProgress extends StatelessWidget {
  const OverlayProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightForFinite(),
      child: const Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.5,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.blueGrey,
            ),
          ),
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}
