## [0.2.0] - Package Upgrade
Upgrade packages and support Dart 2.0.0-dev < 3.0.0

Closes:
* https://github.com/axrs/feather/issues/1

## [0.1.0] - Minor Release
Feather has proven stable enough for a minor release

Fixes:
* Issue with setting the initial AppDb state.

## [0.0.6] - Or->ifVal
Renamed `or` to `ifVal`

## [0.0.5] - Null Checks
Adds `isNull` and `isNotNull`

## [0.0.4] - Conditional Functions
Adds support for `when` and `or` functions with lazyish evaluation

## [0.0.3] - Casting Functions

Adds typecasting functionality for List<dynamic> to:
* Map with `asMaps`
* Widget with `asWidgets`
* `nonNullMaps`
* `nonNullWidgets`

Fixed some Dart 2 assertion checks.

## [0.0.2] - Merge Function

Adds functionality for:
* Utilities
  * `merge`

## [0.0.1] - Initial Release

Provides functionality for:
* Flow
  * AppDb
  * AppDbStream Stream View
* Utilities
  * get/getIn
  * set/setIn
  * remove/removeIn
  * removeNulls
  * contains

