import 'package:flutter/material.dart';
import 'package:ra_segmented_switch/segmented_switch/enums/segmented.switch.size.dart';
import 'package:ra_segmented_switch/segmented_switch/models/segmented.switch.item.dart';

/// A TabBar-based segmented switch with a pill-style indicator.
///
/// This widget provides a tab interface similar to the standard TabBar but
/// styled as a segmented switch with rounded pill indicators. The TabBar
/// becomes scrollable when there are more than 4 items, otherwise it's fixed.
/// Supports icons, different sizes, and all UISegmentedSwitchItem features.
///
/// Example usage:
/// ```dart
/// RASegmentedSwitch(
///   items: [
///     RASegmentedSwitchItem(
///       label: 'Table View',
///       leftIcon: Icons.list_alt_rounded
///     ),
///     RASegmentedSwitchItem(
///       label: 'Home View',
///       leftIcon: Icons.home
///     ),
///   ],
///   onTap: (index) {
///     // Handle tab selection
///   },
///   initialIndex: 0,
///   size: RASegmentedSwitchSize.medium,
/// )
/// ```
class RASegmentedSwitch extends StatefulWidget {
  const RASegmentedSwitch({
    required this.items,
    required this.onTap,
    this.initialIndex = 0,
    this.size = RASegmentedSwitchSize.medium,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.minScrollableItems,
    this.borderRadius,
    this.backgroundColor,
    this.indicatorColor,
    this.shadowColor,
    super.key,
  });

  /// A collections item of [RASegmentedSwitchItem].
  final List<RASegmentedSwitchItem> items;

  /// A current position for first initialization.
  final int initialIndex;

  /// A type to create padding content spacing.
  final RASegmentedSwitchSize size;

  /// A style to customize the label style.
  final TextStyle? selectedLabelStyle;

  /// A style to customize the unselected label style.
  final TextStyle? unselectedLabelStyle;

  /// A minimum number of items to make the segmented switch scrollable.
  final int? minScrollableItems;

  /// A border radius to customize the segmented switch border radius.
  final double? borderRadius;

  /// A background color to customize the segmented switch background color.
  final Color? backgroundColor;

  /// A indicator color to customize the segmented switch indicator color.
  final Color? indicatorColor;

  /// A shadow color to customize the segmented switch shadow color.
  final Color? shadowColor;

  /// Signature for callbacks that report that an underlying value,
  /// when user pressed item.
  final ValueChanged<int> onTap;

  @override
  State<RASegmentedSwitch> createState() => _RASegmentedSwitchState();
}

class _RASegmentedSwitchState extends State<RASegmentedSwitch>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    assert(widget.items.isNotEmpty,
        'UISegmentedSwitch must have at least one item');
    _tabController = TabController(
      length: widget.items.length,
      vsync: this,
      initialIndex: widget.initialIndex.clamp(0, widget.items.length - 1),
    );
    _tabController.addListener(_handleTabSelection);
  }

  /// Get height based on size
  double get _height {
    return switch (widget.size) {
      RASegmentedSwitchSize.small => 38.0,
      RASegmentedSwitchSize.medium => 48.0,
      RASegmentedSwitchSize.large => 56.0,
    };
  }

  /// Get content padding based on size
  EdgeInsets get _contentPadding {
    // Use less horizontal padding for fixed tabs to allow more text space
    final horizontalPadding = _isScrollable ? 16.0 : 8.0;

    return switch (widget.size) {
      RASegmentedSwitchSize.small => EdgeInsets.symmetric(
          vertical: 4,
          horizontal: horizontalPadding,
        ),
      RASegmentedSwitchSize.medium => EdgeInsets.symmetric(
          vertical: 8,
          horizontal: horizontalPadding,
        ),
      RASegmentedSwitchSize.large => EdgeInsets.symmetric(
          vertical: 12,
          horizontal: horizontalPadding,
        )
    };
  }

  /// Get icon size based on size
  final double _iconSize = 16;

  /// Check if all items are icon-only
  bool get _isIconOnly {
    return widget.items.every((item) => item.icon != null);
  }

  /// Check if TabBar should be scrollable (more than 4 items)
  bool get _isScrollable {
    return widget.items.length > (widget.minScrollableItems ?? 4);
  }

  /// Get tab alignment based on number of items
  TabAlignment get _tabAlignment {
    return _isScrollable ? TabAlignment.start : TabAlignment.fill;
  }

  @override
  void didUpdateWidget(RASegmentedSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.items.isNotEmpty,
        'UISegmentedSwitch must have at least one item');

    // If the number of items changed, recreate the TabController
    if (oldWidget.items.length != widget.items.length) {
      _tabController.removeListener(_handleTabSelection);
      _tabController.dispose();

      _tabController = TabController(
        length: widget.items.length,
        vsync: this,
        initialIndex: widget.initialIndex.clamp(0, widget.items.length - 1),
      );
      _tabController.addListener(_handleTabSelection);
    }
    // If initial index changed but length is same, update the index
    else if (oldWidget.initialIndex != widget.initialIndex) {
      _tabController.index =
          widget.initialIndex.clamp(0, widget.items.length - 1);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging || !_tabController.index.isNaN) {
      widget.onTap(_tabController.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      height: _height,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? const Color(0xFFD5D9E4),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 999),
      ),
      padding: const EdgeInsets.all(2),
      width: _isIconOnly ? null : double.infinity,
      child: TabBar(
        controller: _tabController,
        isScrollable: _isScrollable,
        tabAlignment: _tabAlignment,
        indicator: _PillTabIndicator(
          color: widget.indicatorColor ?? const Color(0xFFFDFCFF),
          radius: ((widget.borderRadius) ?? 999) - 2.5,
          shadowColor: widget.shadowColor,
        ),
        labelPadding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: widget.selectedLabelStyle?.color ?? Colors.black,
        unselectedLabelColor:
            widget.unselectedLabelStyle?.color ?? Colors.white,
        labelStyle: widget.selectedLabelStyle ??
            const TextStyle(
              fontWeight: FontWeight.w600,
            ),
        unselectedLabelStyle: widget.unselectedLabelStyle ??
            const TextStyle(
              fontWeight: FontWeight.w400,
            ),
        dividerColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        tabs: widget.items
            .map((item) => Tab(
                  child: Padding(
                    padding: _contentPadding,
                    child: _buildTabContent(item),
                  ),
                ))
            .toList(),
      ),
    );
  }

  /// Build tab content based on UISegmentedSwitchItem type
  Widget _buildTabContent(RASegmentedSwitchItem item) {
    // Icon only item
    if (item.icon != null) {
      return Icon(
        item.icon,
        size: _iconSize,
      );
    }

    // Item with label and optional icons
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (item.leftIcon != null)
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(
              item.leftIcon,
              size: _iconSize,
            ),
          ),
        if (item.label.isNotEmpty)
          Flexible(
            child: Text(
              item.label,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        if (item.rightIcon != null)
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Icon(
              item.rightIcon,
              size: _iconSize,
            ),
          ),
      ],
    );
  }
}

/// Custom indicator that creates a pill/rounded rectangle shape
class _PillTabIndicator extends Decoration {
  const _PillTabIndicator({
    required this.color,
    required this.radius,
    this.shadowColor,
  });

  final Color color;
  final double radius;
  final Color? shadowColor;
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _PillPainter(color: color, radius: radius, shadowColor: shadowColor);
  }
}

class _PillPainter extends BoxPainter {
  _PillPainter({
    required this.color,
    required this.radius,
    this.shadowColor,
  });

  final Color color;
  final double radius;
  final Color? shadowColor;
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      configuration.size!.width,
      configuration.size!.height,
    );

    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    // Draw shadow with offset (0, 0)
    canvas.save();
    final shadowPath = Path()..addRRect(rrect.shift(const Offset(0, 0)));
    canvas.drawShadow(
      shadowPath,
      shadowColor?.withOpacity(0.25) ?? Colors.black.withOpacity(0.25),
      4.0,
      false,
    );
    canvas.restore();

    // Draw pill
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rrect, paint);
  }
}
