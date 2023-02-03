<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A fancy and highly customizable date picker for Flutter.

<p align="center">
    <img src="document/v0.1.0.gif" height="500"/>
</p>

## Features

Supports manual input with format checking and picking a date from the provided calendar.

***flutter_modal_date_picker is still on the development phase and customization features are yet to be added to this package.***

## Getting started

Supports all platforms.

## Usage

Just call the <code>showModalDatePicker</code> function and 
wait for it to return an string.

```dart
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ElevatedButton(
                child: Text(
                    'show date picker',
                    style: TextStyle(fontSize: 30),
                ),
                onPressed: () async {
                    String chosenDate =
                        await showModalDatePicker(context, DateTime.now());
                    print(chosenDate);
                },
            ), 
        ),
    );
  }
}

```

## Additional information

For more info on this package, head onto our github repository. Feel free to open issues and request additional features.
