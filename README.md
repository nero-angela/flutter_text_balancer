# Text Balancer
Flutter widget that makes text more readable.<br>
It works with fixed-width as well as variable-width fonts.

![line-balancer demo](https://github.com/nero-angela/flutter_text_balancer/assets/26322627/01980ef3-4554-4897-b67d-6f4f86b7fd2c)

## How To Use
```dart
/// Widget
TextBalancer('text');

/// Text Extension
Text('text').balance(
  context,
  maxWidth: constraints.maxWidth,
);

/// String Extension
'text'.balance(
  textStyle: textStyle,
  maxWidth: constrains.maxWidth,
)
```

## Performance
![performance](https://github.com/nero-angela/flutter_text_balancer/assets/26322627/40f1972d-863c-4d79-824a-a897a804043f)

- Time complexity : `O(n * log n)`
- Modified the algorithm to work with variable-width fonts where each character has a different width.

## References
- https://xxyxyz.org/line-breaking