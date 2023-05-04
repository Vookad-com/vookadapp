import 'package:flutter/material.dart';

const String _imagePath = 'assets/images';

class _Image extends AssetImage {
  const _Image(String fileName) : super('$_imagePath/$fileName');
}

class AppImages {
  static const otpIllus = _Image('verify.png');
  static const loginIllus = _Image('piano.png');
  static const vookadLogo = _Image('vookadlogo.png');
  static const avatar = _Image('avatar.png');
  static const biryani = _Image('biryani1.png');
}
