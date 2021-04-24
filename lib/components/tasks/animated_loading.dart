import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedLoading extends StatelessWidget {
  final String _textoStatus;
  const AnimatedLoading(this._textoStatus);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text(_textoStatus),
        ],
      ),
    );
  }
}