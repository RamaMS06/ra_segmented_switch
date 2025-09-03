import 'package:flutter/material.dart';

/// A model to accommodate data from segmented switch items.
class RASegmentedSwitchItem {
  /// Call the segmented switch item.
  RASegmentedSwitchItem({
    required this.label,
    this.leftIcon,
    this.rightIcon,
  }) : icon = null;

  /// Information for each item.
  final String label;

  /// Displays the icon to the left of [label].
  final IconData? leftIcon;

  /// Displays the icon to the right of [label].
  final IconData? rightIcon;

  /// Only displays the icon in the center.
  final IconData? icon;
}
