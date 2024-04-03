import "package:flutter/widgets.dart";

/// This class is used to style the headers of the categories in the list.
/// The headers are the names of the categories.
class CategoryHeaderStyling {
  const CategoryHeaderStyling({
    /// The styles for the headers. The key is the depth of the category.
    /// The value is the text style for the header.
    required this.headerStyles,

    /// The default style for the headers. This will be used if the depth
    /// is not found in the [headerStyles].
    this.defaultStyle,
  });

  final Map<int, TextStyle?> headerStyles;
  final TextStyle? defaultStyle;
}
