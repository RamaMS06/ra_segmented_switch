# RA Segmented Switch

A highly customizable, animated segmented switch widget for Flutter applications. Built on top of Flutter's TabBar with a beautiful pill-style indicator, offering smooth animations, extensive theming options, and seamless integration with your app's design system.

<div align="center">
  <img src="https://raw.githubusercontent.com/RamaMS06/ra_segmented_switch/main/assets/example/evidence_ra_segmented.gif" alt="RA Segmented Switch Preview" width="300" height="600">
</div>

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Usage Examples](#usage-examples)
- [API Reference](#api-reference)
- [Customization Guide](#customization-guide)
- [Migration Guide](#migration-guide)
- [Contributing](#contributing)
- [License](#license)

## Features

### Core Features
- **Multiple Size Options**: Three predefined sizes (small, medium, large) with customizable dimensions
- **Flexible Icon Support**: Icons on left, right, or center with full customization
- **Smooth Animations**: Built-in animations with customizable duration and easing curves
- **Auto-Scrolling**: Intelligent scrolling behavior when content exceeds available space
- **Theme Integration**: Seamless integration with Flutter's theme system and Material Design

### Customization Features
- **Custom Colors**: Full control over background, indicator, text, and shadow colors
- **Border Radius**: Adjustable corner radius from sharp to fully rounded
- **Typography**: Custom text styles for selected and unselected states
- **Shadow Effects**: Configurable shadow color and opacity
- **Responsive Design**: Adapts to different screen sizes and orientations

### Developer Experience
- **Type Safety**: Full Dart type safety with comprehensive documentation
- **Performance Optimized**: Efficient rendering with minimal rebuilds
- **Accessibility Ready**: Built-in accessibility support with proper semantics
- **Easy Integration**: Simple API that works with existing Flutter apps
- **Robust Error Handling**: Graceful handling of edge cases and invalid states

## Installation

Add `ra_segmented_switch` to your `pubspec.yaml` file:

```yaml
dependencies:
  ra_segmented_switch: ^0.0.1
```

Then run:

```bash
flutter pub get
```

Import the package in your Dart code:

```dart
import 'package:ra_segmented_switch/ra_segmented_switch.dart';
```

## Quick Start

Here's a simple example to get you started:

```dart
import 'package:flutter/material.dart';
import 'package:ra_segmented_switch/ra_segmented_switch.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: RASegmentedSwitch(
            items: [
              RASegmentedSwitchItem(
                label: 'Home',
                leftIcon: Icons.home,
              ),
              RASegmentedSwitchItem(
                label: 'Search',
                leftIcon: Icons.search,
              ),
              RASegmentedSwitchItem(
                label: 'Profile',
                leftIcon: Icons.person,
              ),
            ],
            onTap: (index) {
              print('Selected: $index');
            },
          ),
        ),
      ),
    );
  }
}
```

## Usage Examples

### Basic Usage

#### Simple Text Segments
```dart
RASegmentedSwitch(
  items: [
    RASegmentedSwitchItem(label: 'Option 1'),
    RASegmentedSwitchItem(label: 'Option 2'),
    RASegmentedSwitchItem(label: 'Option 3'),
  ],
  onTap: (index) {
    print('Selected index: $index');
  },
)
```

#### With Icons
```dart
RASegmentedSwitch(
  items: [
    RASegmentedSwitchItem(
      label: 'Home',
      leftIcon: Icons.home,
    ),
    RASegmentedSwitchItem(
      label: 'Favorites',
      leftIcon: Icons.favorite,
    ),
    RASegmentedSwitchItem(
      label: 'Settings',
      rightIcon: Icons.settings,
    ),
  ],
  initialIndex: 0,
  size: RASegmentedSwitchSize.medium,
  onTap: (index) {
    // Handle selection
  },
)
```

### Advanced Customization

#### Theme Toggle Switch
```dart
class ThemeToggle extends StatefulWidget {
  @override
  _ThemeToggleState createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  int selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final isDark = selectedIndex == 0;
    
    return RASegmentedSwitch(
      items: [
        RASegmentedSwitchItem(
          label: 'Dark',
          leftIcon: Icons.dark_mode,
        ),
        RASegmentedSwitchItem(
          label: 'Light',
          leftIcon: Icons.light_mode,
        ),
      ],
      initialIndex: selectedIndex,
      backgroundColor: isDark 
        ? const Color(0xFF2C2C2E) 
        : const Color(0xFFF2F2F7),
      indicatorColor: isDark 
        ? const Color(0xFF1C1C1E) 
        : Colors.white,
      selectedLabelStyle: TextStyle(
        color: isDark ? Colors.white : Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      unselectedLabelStyle: TextStyle(
        color: isDark ? Colors.grey[400] : Colors.grey[600],
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      shadowColor: isDark 
        ? Colors.black.withOpacity(0.3) 
        : Colors.grey.withOpacity(0.2),
      borderRadius: 12,
      size: RASegmentedSwitchSize.medium,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
        // Apply theme change
      },
    );
  }
}
```

#### Navigation Tabs
```dart
class NavigationExample extends StatefulWidget {
  @override
  _NavigationExampleState createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentIndex = 0;
  
  final List<Widget> pages = [
    HomePage(),
    SearchPage(),
    FavoritesPage(),
    ProfilePage(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Example'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: RASegmentedSwitch(
              items: [
                RASegmentedSwitchItem(
                  label: 'Home',
                  leftIcon: Icons.home_outlined,
                ),
                RASegmentedSwitchItem(
                  label: 'Search',
                  leftIcon: Icons.search_outlined,
                ),
                RASegmentedSwitchItem(
                  label: 'Favorites',
                  leftIcon: Icons.favorite_outline,
                ),
                RASegmentedSwitchItem(
                  label: 'Profile',
                  leftIcon: Icons.person_outline,
                ),
              ],
              initialIndex: currentIndex,
              size: RASegmentedSwitchSize.large,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              indicatorColor: Theme.of(context).primaryColor,
              selectedLabelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
    );
  }
}
```

#### Scrollable Content
```dart
RASegmentedSwitch(
  items: [
    RASegmentedSwitchItem(label: 'All', leftIcon: Icons.all_inclusive),
    RASegmentedSwitchItem(label: 'Documents', leftIcon: Icons.description),
    RASegmentedSwitchItem(label: 'Images', leftIcon: Icons.image),
    RASegmentedSwitchItem(label: 'Videos', leftIcon: Icons.videocam),
    RASegmentedSwitchItem(label: 'Audio', leftIcon: Icons.audiotrack),
    RASegmentedSwitchItem(label: 'Archives', leftIcon: Icons.archive),
    RASegmentedSwitchItem(label: 'Others', leftIcon: Icons.more_horiz),
  ],
  minScrollableItems: 4, // Scrollable when more than 4 items
  size: RASegmentedSwitchSize.small,
  borderRadius: 8,
  onTap: (index) {
    // Filter content based on selection
  },
)
```

### Custom Styling Examples

#### Rounded Corners
```dart
RASegmentedSwitch(
  items: [
    RASegmentedSwitchItem(label: 'Rounded'),
    RASegmentedSwitchItem(label: 'Corners'),
  ],
  borderRadius: 25,
  backgroundColor: Colors.blue[50],
  indicatorColor: Colors.blue[600],
  onTap: (index) => {},
)
```

#### Sharp Edges
```dart
RASegmentedSwitch(
  items: [
    RASegmentedSwitchItem(label: 'Sharp'),
    RASegmentedSwitchItem(label: 'Edges'),
  ],
  borderRadius: 4,
  backgroundColor: Colors.grey[200],
  indicatorColor: Colors.black87,
  onTap: (index) => {},
)
```

#### Custom Colors
```dart
RASegmentedSwitch(
  items: [
    RASegmentedSwitchItem(label: 'Custom'),
    RASegmentedSwitchItem(label: 'Colors'),
  ],
  backgroundColor: Color(0xFFE3F2FD),
  indicatorColor: Color(0xFF1976D2),
  shadowColor: Color(0xFF1976D2).withOpacity(0.3),
  selectedLabelStyle: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  unselectedLabelStyle: TextStyle(
    color: Color(0xFF1976D2),
    fontWeight: FontWeight.w500,
  ),
  onTap: (index) => {},
)
```

## API Reference

### RASegmentedSwitch

The main widget class for creating segmented switches.

#### Constructor

```dart
RASegmentedSwitch({
  Key? key,
  required List<RASegmentedSwitchItem> items,
  required ValueChanged<int> onTap,
  int initialIndex = 0,
  RASegmentedSwitchSize size = RASegmentedSwitchSize.medium,
  TextStyle? selectedLabelStyle,
  TextStyle? unselectedLabelStyle,
  int? minScrollableItems,
  double? borderRadius,
  Color? backgroundColor,
  Color? indicatorColor,
  Color? shadowColor,
})
```

#### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `items` | `List<RASegmentedSwitchItem>` | **required** | List of items to display in the segmented switch |
| `onTap` | `ValueChanged<int>` | **required** | Callback function called when a segment is tapped |
| `initialIndex` | `int` | `0` | Initial selected segment index |
| `size` | `RASegmentedSwitchSize` | `medium` | Size of the segmented switch |
| `selectedLabelStyle` | `TextStyle?` | `null` | Text style for the selected segment label |
| `unselectedLabelStyle` | `TextStyle?` | `null` | Text style for unselected segment labels |
| `minScrollableItems` | `int?` | `4` | Minimum number of items before the switch becomes scrollable |
| `borderRadius` | `double?` | `999` | Border radius of the container (999 = fully rounded) |
| `backgroundColor` | `Color?` | `Color(0xFFD5D9E4)` | Background color of the segmented switch container |
| `indicatorColor` | `Color?` | `Color(0xFFFDFCFF)` | Color of the selection indicator |
| `shadowColor` | `Color?` | `Colors.black` | Shadow color of the selection indicator |

### RASegmentedSwitchItem

Represents an individual segment in the switch.

#### Constructors

```dart
// Regular constructor with label and optional icons
RASegmentedSwitchItem({
  required String label,
  IconData? leftIcon,
  IconData? rightIcon,
})

// Icon-only constructor (planned for future release)
RASegmentedSwitchItem.iconOnly({
  required IconData icon,
})
```

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `label` | `String` | Text label displayed in the segment |
| `leftIcon` | `IconData?` | Icon displayed to the left of the label |
| `rightIcon` | `IconData?` | Icon displayed to the right of the label |
| `icon` | `IconData?` | Icon displayed in the center (for icon-only segments) |

### RASegmentedSwitchSize

Enum defining the available sizes for the segmented switch.

```dart
enum RASegmentedSwitchSize {
  small,   // Height: 38px
  medium,  // Height: 48px
  large,   // Height: 56px
}
```

#### Size Specifications

| Size | Height | Vertical Padding | Use Case |
|------|--------|------------------|----------|
| `small` | 38px | 4px | Compact interfaces, toolbars |
| `medium` | 48px | 8px | Standard UI elements, forms |
| `large` | 56px | 12px | Primary navigation, prominent controls |

## Customization Guide

### Theming Integration

The widget automatically adapts to your app's theme, but you can override specific aspects:

```dart
// Using theme colors
RASegmentedSwitch(
  items: items,
  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
  indicatorColor: Theme.of(context).colorScheme.primary,
  selectedLabelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
    color: Theme.of(context).colorScheme.onPrimary,
    fontWeight: FontWeight.bold,
  ),
  unselectedLabelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
    color: Theme.of(context).colorScheme.onSurfaceVariant,
  ),
  onTap: (index) => {},
)
```

### Responsive Design

Make your segmented switch responsive to different screen sizes:

```dart
class ResponsiveSegmentedSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return RASegmentedSwitch(
      items: items,
      size: screenWidth > 600 
        ? RASegmentedSwitchSize.large 
        : RASegmentedSwitchSize.medium,
      minScrollableItems: screenWidth > 800 ? 6 : 4,
      onTap: (index) => {},
    );
  }
}
```

### Animation Customization

The widget uses an `AnimatedContainer` with customizable animation properties:

- **Duration**: 200 milliseconds
- **Curve**: `Curves.easeInOut`

These values are optimized for the best user experience but can be indirectly influenced through the widget's state changes.

### Accessibility

The widget includes built-in accessibility features:

- Semantic labels for screen readers
- Proper focus management
- Keyboard navigation support
- High contrast support

To enhance accessibility further:

```dart
RASegmentedSwitch(
  items: [
    RASegmentedSwitchItem(label: 'Home'), // Automatically gets semantic label
    RASegmentedSwitchItem(label: 'Search'),
  ],
  // Ensure sufficient color contrast
  backgroundColor: Colors.white,
  indicatorColor: Colors.blue[700],
  selectedLabelStyle: TextStyle(
    color: Colors.white,
    fontSize: 16, // Minimum recommended size
  ),
  onTap: (index) => {},
)
```

## Performance Considerations

### Optimization Tips

1. **Minimize Rebuilds**: Use `const` constructors where possible
2. **Efficient Callbacks**: Keep `onTap` callbacks lightweight
3. **Icon Caching**: Use standard Material icons for better performance
4. **State Management**: Consider using state management solutions for complex scenarios

### Memory Usage

The widget is designed to be memory-efficient:
- Minimal widget tree depth
- Efficient TabController management
- Automatic disposal of resources

## Migration Guide

### From Version 0.0.1

This is the initial release, so no migration is needed.

### Future Versions

Migration guides will be provided for future releases with breaking changes.

## Troubleshooting

### Common Issues

#### TabController Length Mismatch
**Error**: "Controller's length property does not match the number of tabs"

**Solution**: This has been fixed in version 0.0.1 with proper `didUpdateWidget` implementation.

#### Performance Issues with Many Items
**Problem**: Sluggish performance with many segments

**Solution**: The widget automatically becomes scrollable when there are more than the specified `minScrollableItems` (default: 4).

#### Theme Not Applied
**Problem**: Custom theme colors not showing

**Solution**: Ensure you're passing the correct theme colors:

```dart
RASegmentedSwitch(
  backgroundColor: Theme.of(context).colorScheme.surface,
  indicatorColor: Theme.of(context).colorScheme.primary,
  // ... other properties
)
```

### Debug Mode

Enable debug mode to see additional information:

```dart
import 'package:flutter/foundation.dart';

// In debug mode, the widget provides additional assertion checks
assert(() {
  if (kDebugMode) {
    print('RASegmentedSwitch: ${items.length} items loaded');
  }
  return true;
}());
```

## Examples Repository

For more comprehensive examples, check out the `/example` directory in the repository, which includes:

- Basic usage examples
- Theme integration demos
- Navigation implementations
- Custom styling showcases
- Performance benchmarks

## Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Setup

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

### Reporting Issues

Please report issues on our [GitHub Issues](https://github.com/RamaMS06/ra_segmented_switch/issues) page with:

- Flutter version
- Device/platform information
- Minimal reproduction code
- Expected vs actual behavior

## Roadmap

### Upcoming Features

- Icon-only segments
- Vertical orientation support
- Custom animation curves
- Gradient backgrounds
- Badge support
- Haptic feedback

### Version History

See [CHANGELOG.md](CHANGELOG.md) for detailed version history.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- **Documentation**: This README and inline code documentation
- **Issues**: [GitHub Issues](https://github.com/RamaMS06/ra_segmented_switch/issues)
- **Discussions**: [GitHub Discussions](https://github.com/RamaMS06/ra_segmented_switch/discussions)

## Acknowledgments

- Built with Flutter's powerful widget system
- Inspired by iOS UISegmentedControl and Material Design principles
- Thanks to the Flutter community for feedback and contributions

---

**Made with ❤️ for the Flutter community**