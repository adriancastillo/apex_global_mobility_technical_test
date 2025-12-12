part of '../ui.dart';

abstract class UIBorderRadius {
  static BorderRadius small = BorderRadius.circular(UIRadius.small);
  static BorderRadius medium = BorderRadius.circular(UIRadius.medium);
  static BorderRadius large = BorderRadius.circular(UIRadius.large);
  static const BorderRadius top_16 = BorderRadius.vertical(
    top: Radius.circular(16),
  );
}
