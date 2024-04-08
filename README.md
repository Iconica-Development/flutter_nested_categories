# flutter_nested_categories

This Flutter component allows you to easily create nested categories that are very
customizable.

## Features

* Nested Categories
* Collapsible Categories

## Usage

You can build a nested category using the `CategoryList` class, like this:

```dart
CategoryList(
    content: [
        Category(
            name: "Category 1",
            content: [
                const Text("Content 1"),
                const Text("Content 2"),
            ],
            nestedCategories: [
                Category(
                    name: "Category 1.1",
                    content: [
                    const Text("Content 1.1"),
                    const Text("Content 1.2"),
                    ],
                ),
            ],
        ),
    ],
),
```

You have a bunch of customization options available as well, such as:

* Setting a (text)title (and title styling/center),
* Setting a custom title,
* Collapsible categories,
* Header styling.

For a more detailed example you can see the [example](https://github.com/Iconica-Development/flutter_nested_categories/tree/main/example).

Or, you could run the example yourself:
```
git clone https://github.com/Iconica-Development/flutter_nested_categories.git

cd flutter_nested_categories

cd example

flutter run
```

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Iconica-Development/flutter_nested_categories) page. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute

If you would like to contribute to the component (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](./CONTRIBUTING.md) and send us your [pull request](https://github.com/Iconica-Development/flutter_nested_categories/pulls).

## Author

This flutter_thermal_printer for Flutter is developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>
