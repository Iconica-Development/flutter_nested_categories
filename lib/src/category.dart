import "package:flutter/widgets.dart";

/// One of the categories in the list. Each category can contain content,
/// which can be an empty list, but also nested categories. The nested
/// categories are the same type as the parent category which allows for
/// infinite nesting.
class Category {
  const Category({
    /// The name of the category.
    required this.name,

    /// The content of the category. This can be anything, but is usually
    /// a list of widgets.
    ///
    /// Default is an empty list.
    ///
    /// If the category has nested categories, it will show this content
    /// before the nested categories.
    this.content = const <Widget>[],

    /// The nested categories of this category. This can be an empty list
    /// if there are no nested categories.
    ///
    /// Default is an empty list.
    this.nestedCategories = const <Category>[],
  });

  final String name;
  final List<Category> nestedCategories;
  final List<Widget> content;
}
