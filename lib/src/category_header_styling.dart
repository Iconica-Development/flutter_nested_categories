import "package:flutter/widgets.dart";
import "package:flutter_nested_categories/src/category_header_capitalization.dart";

/// This class is used to style the headers of the categories in the list.
/// The headers are the names of the categories.
class CategoryHeaderStyling {
  const CategoryHeaderStyling({
    required this.defaultStyle,
    this.capitalization = CategoryHeaderCapitalization.none,
    this.headerStyles = const {},
  });

  /// The styles for the headers. The key is the depth of the category.
  /// The value is the text style for the header.
  final Map<int, TextStyle?> headerStyles;

  /// The capitalization of the headers. This is used to determine how the
  /// headers should be displayed.
  final CategoryHeaderCapitalization capitalization;

  /// The default style for the headers. This will be used if the depth
  /// is not found in the [headerStyles].
  final TextStyle defaultStyle;
}
