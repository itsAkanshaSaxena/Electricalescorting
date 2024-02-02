import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton(this._label, this._onPressed, {Key? key}) : super(key: key);
  final String _label;
  final VoidCallback _onPressed;

  final TextStyle textStyle = const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 20.0,
      color: Colors.white,
      fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return  Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.orangeAccent.shade400,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: _onPressed,
        child: Text(
          _label,
          textAlign: TextAlign.center,
          style: textStyle,
        ),
      ),
    );
  }
}
