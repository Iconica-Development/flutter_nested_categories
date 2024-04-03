import "package:flutter/material.dart";
import "package:flutter_nested_categories/flutter_nested_categories.dart";

/// This widget displays a list of categories. Each category can contain
/// content, which can be an empty list, but also nested categories. The
/// nested categories are the same type as the parent category which allows
/// for infinite nesting.
///
/// The content of the categories is displayed in the order it is given in
/// the list. If a category has nested categories, the content of the nested
/// categories is displayed after the content of the parent category.
class CategoryList extends StatelessWidget {
  const CategoryList({
    /// The content of the category list. This is a list of categories.
    required this.content,

    /// Optional header styling for the categories. This will be applied to
    /// the name of the categories. If not set, the default text style will
    /// be used.
    this.headerStyling,

    /// Configure if the category header should be centered.
    ///
    /// Default is false.
    this.headerCentered = false,

    /// Optional custom title widget for the category list. This will be
    /// displayed at the top of the list. If set, the text title will be
    /// ignored.
    this.customTitle,

    /// Optional title for the category list. This will be displayed at the
    /// top of the list.
    this.title,

    /// Optional title style for the title of the category list. This will
    /// be applied to the title of the category list. If not set, the default
    /// text style will be used.
    this.titleStyle,

    /// Configure if the title should be centered.
    ///
    /// Default is false.
    this.titleCentered = false,

    /// Configure if the category should be collapsible.
    ///
    /// Default is true.
    this.isCategoryCollapsible = true,

    /// The depth of the category list. This is used to keep track of
    /// the depth of the categories. This is used internally and should
    /// not be set manually.
    this.categoryDepth = 0,

    /// The key for this widget.
    super.key,
  });

  final String? title;
  final Widget? customTitle;
  final TextStyle? titleStyle;
  final bool titleCentered;

  final CategoryHeaderStyling? headerStyling;
  final bool headerCentered;

  final bool isCategoryCollapsible;
  final int categoryDepth;

  final List<Category> content;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null || customTitle != null)
              titleCentered
                  ? Center(
                      child: _CategoryTitle(
                        title: title,
                        titleStyle: titleStyle,
                        customTitle: customTitle,
                      ),
                    )
                  : _CategoryTitle(
                      title: title,
                      titleStyle: titleStyle,
                      customTitle: customTitle,
                    ),
            ...content.map(
              (category) => _CategoryColumn(
                category: category,
                headerCentered: headerCentered,
                headerStyling: headerStyling,
                collapsible: isCategoryCollapsible,
                categoryDepth: categoryDepth,
              ),
            ),
          ].toList(),
        ),
      );
}

class _CategoryTitle extends StatelessWidget {
  const _CategoryTitle({
    this.customTitle,
    this.title,
    this.titleStyle,
  }) : assert(
          customTitle != null || title != null,
          "Either customTitle or title must be set.",
        );

  final String? title;
  final Widget? customTitle;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var styleOfTitle = titleStyle ?? theme.textTheme.titleLarge;

    if (customTitle != null) {
      return customTitle!;
    } else {
      return Text(
        title!,
        style: styleOfTitle,
      );
    }
  }
}

class _CategoryColumn extends StatefulWidget {
  const _CategoryColumn({
    required this.category,
    required this.categoryDepth,
    required this.headerCentered,
    this.headerStyling,
    this.collapsible = true,
  });

  final Category category;
  final CategoryHeaderStyling? headerStyling;
  final bool headerCentered;
  final int categoryDepth;
  final bool collapsible;

  @override
  State<_CategoryColumn> createState() => _CategoryColumnState();
}

class _CategoryColumnState extends State<_CategoryColumn> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var styleOfCategory =
        widget.headerStyling?.headerStyles[widget.categoryDepth] ??
            widget.headerStyling?.defaultStyle ??
            theme.textTheme.titleMedium ??
            const TextStyle();

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.collapsible) _buildCollapsibleHeader(styleOfCategory),
          if (!widget.collapsible) _buildNonCollapsibleHeader(styleOfCategory),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.category.content.isNotEmpty)
                  ...widget.category.content,
                if (widget.category.nestedCategories.isNotEmpty)
                  _buildNestedCategoryList(),
              ],
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }

  Widget _buildCollapsibleHeader(TextStyle styleOfCategory) => InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Row(
          mainAxisAlignment: widget.headerCentered
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            ExpandIcon(
              onPressed: (value) => setState(() {
                _isExpanded = !_isExpanded;
              }),
              isExpanded: _isExpanded,
              padding: EdgeInsets.zero,
            ),
            const SizedBox(width: 8),
            Text(
              widget.category.name,
              style: styleOfCategory,
            ),
          ],
        ),
      );

  Widget _buildNonCollapsibleHeader(TextStyle styleOfCategory) =>
      widget.headerCentered
          ? Center(
              child: Text(
                widget.category.name,
                style: styleOfCategory,
              ),
            )
          : Text(
              widget.category.name,
              style: styleOfCategory,
            );

  Widget _buildNestedCategoryList() => CategoryList(
        content: widget.category.nestedCategories,
        headerCentered: widget.headerCentered,
        headerStyling: widget.headerStyling,
        isCategoryCollapsible: widget.collapsible,
        categoryDepth: widget.categoryDepth + 1,
      );
}
