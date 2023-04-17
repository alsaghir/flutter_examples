import 'package:flutter/material.dart';
import 'package:flutter_work/apps/button_counter.dart';
import 'package:flutter_work/apps/color_tabs.dart';
import 'package:flutter_work/apps/random_words.dart';

/// Use --dart-define="APP=RandomWordsAPP"
/// as parameter to flutter run to specify which app to run
void main() {
  const appName = String.fromEnvironment('APP', defaultValue: 'ButtonCounter');
  switch (appName) {
    case 'ButtonCounterApp':
      runApp(const ButtonCounterApp());
      break;
    case 'RandomWordsAPP':
      runApp(const RandomWordsAPP());
      break;
    case 'ColorTabsApp':
      runApp(const ColorTabsApp());
      break;
    default:
      throw UnsupportedError('Unsupported app name');
  }
}
