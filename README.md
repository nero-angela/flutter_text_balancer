Flutter package that makes text more readable.<br>
It works with fixed-width as well as variable-width fonts.

![text balancer](https://github.com/nero-angela/flutter_text_balancer/assets/26322627/d707b1c1-ac54-4460-bf6c-87cb4f09c1ca)

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
![performance](https://github.com/nero-angela/flutter_text_balancer/assets/26322627/17262c38-75e7-469c-9a05-9b61be9248e7)

- Time complexity : `n^2`

## References
- https://xxyxyz.org/line-breaking