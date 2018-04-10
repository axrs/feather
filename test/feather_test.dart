import 'package:feather/feather.dart' as u;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("set", () {
    test("New keys can be added", () async {
      Map base = {};
      Map expectedNext = {'this': 'that', 'count': 1};
      Map updated = u.set(base, 'this', 'that');
      Map next = u.set(updated, 'count', (c) => (c ?? 0) + 1);
      expect(updated, isNot(base));
      expect(next, isNot(base));
      expect(next, isNot(updated));
      expect(next, expectedNext);
    });

    test("First keys can also be used", () async {
      Map base = {
        'this': {
          'value': {'updated': null}
        }
      };
      Map expectedUpdated = {'this': null};
      Map updated = u.set(base, 'this', null);
      expect(updated, isNot(base));
      expect(updated, expectedUpdated);
    });

    test("First keys with a function can be used if they key doesn't exists",
        () async {
      Map base = {};
      Map expectedUpdated = {'count': 1};
      Map updated = u.set(base, 'count', (c) => (c ?? 0) + 1);
      expect(updated, isNot(base));
      expect(updated, expectedUpdated);
    });

    test("A function can be used in place of a fixed value", () async {
      Map base = {'this': 123};
      Map expectedUpdated = {'this': 246};
      Map updated = u.set(base, 'this', (v) => v * 2);
      expect(updated, isNot(base));
      expect(updated, expectedUpdated);
    });
  });

  group("setIn", () {
    test("Nested values can be changed without modifying their original",
        () async {
      Map base = {
        'this': {
          'value': {'updated': null}
        }
      };
      Map expectedUpdated = {
        'this': {
          'value': {'updated': 123}
        }
      };
      Map updatedIn = u.setIn(base, ['this', 'value', 'updated'], 123);
      expect(updatedIn, isNot(base));
      expect(updatedIn, expectedUpdated);

      final Map expectedNew = {
        'this': {
          'value': {
            'updated': null,
            'does': {
              'not': {'exist': false}
            }
          }
        }
      };
      var newMapIn =
          u.setIn(base, ['this', 'value', 'does', 'not', 'exist'], false);
      expect(newMapIn, isNot(expectedUpdated));
      expect(newMapIn, expectedNew);
    });

    test("First keys can also be used", () async {
      Map base = {
        'this': {
          'value': {'updated': null}
        }
      };
      Map expectedUpdated = {'this': null};
      Map updatedIn = u.setIn(base, ['this'], null);
      expect(updatedIn, isNot(base));
      expect(updatedIn, expectedUpdated);
    });

    test("First keys with a function can be used if they key doesn't exists",
        () async {
      Map base = {};
      Map expectedUpdated = {'count': 1};
      Map updatedIn = u.setIn(base, ['count'], (c) => (c ?? 0) + 1);
      expect(updatedIn, isNot(base));
      expect(updatedIn, expectedUpdated);
    });

    test("A function can be used in place of a fixed value", () async {
      Map base = {
        'this': {
          'value': 123,
        }
      };
      Map expectedUpdated = {
        'this': {'value': 246}
      };
      Map updatedIn = u.setIn(base, ['this', 'value'], (v) => v * 2);
      expect(updatedIn, isNot(base));
      expect(updatedIn, expectedUpdated);
    });
  });
  group("remove", () {
    test("Removes a root level value", () async {
      Map base = {
        'this': {
          'value': {'updated': null, 'removed': null}
        }
      };
      Map updated = u.remove(base, 'this');
      expect(updated, isNot(base));
      expect(updated, {});
    });
  });

  group("removeIn", () {
    test("Removes a nested value from a map", () async {
      Map base = {
        'this': {
          'value': {'updated': null, 'removed': null}
        }
      };
      Map expectedUpdated = {
        'this': {
          'value': {'updated': null}
        }
      };
      Map updatedIn = u.removeIn(base, ['this', 'value', 'removed']);
      expect(updatedIn, isNot(base));
      expect(updatedIn, expectedUpdated);
    });
  });

  group("contains", () {
    test("Returns true if a map or IMap contains a key", () async {
      final String quote = 'Believe you can, then you will.';
      final Map m = {'quote': quote};

      expect(u.contains(m, 'quote'), true);
      expect(u.contains(m, 'notFound'), false);
    });
  });
  group("get", () {
    test("Returns value, null, or not found", () async {
      final String expected =
          "Venture outside your comfort zone. The rewards are worth it.";
      final Map m = {"quote": expected};
      expect(u.get(m, 'quote'), expected);
      expect(u.get(m, 'quote', null), expected);
      expect(u.get(m, 'notFound'), null);
      expect(u.get(m, 'notFound', "Quoted Value"), "Quoted Value");
    });
  });

  group("getIn", () {
    test("Returns value, null, or not found", () async {
      final String expected =
          "Venture outside your comfort zone. The rewards are worth it.";
      final Map m = {"quote": expected};
      expect(u.getIn(m, ['quote']), expected);
      expect(u.getIn(m, ['quote'], null), expected);
      expect(u.getIn(m, ['notFound']), null);
      expect(u.getIn(m, ['notFound'], "Quoted Value"), "Quoted Value");
    });

    test("Gets nested values, null, or not found", () async {
      final String expected = "All it takes is faith and trust.";
      final Map m = {
        "peterPan": {"quote": expected}
      };
      expect(u.getIn(m, ['peterPan', 'quote']), expected);
      expect(u.getIn(m, ['peterPan', 'quote'], null), expected);
      expect(u.getIn(m, ['peterPan', 'notFound']), null);
      expect(u.getIn(m, ['peterPan', 'notFound'], "Value"), "Value");
    });
  });

  group("merge", () {
    test("Acceps null values, replacing with empty maps", () async {
      expect(u.merge(null, null), {});
      expect(u.merge({}, null), {});
      expect(u.merge(null, {}), {});
    });
    test("Preserves existing values", () async {
      final Map m = {"existing": "value"};
      final Map n = {"new": "value"};
      final Map expected = {"existing": "value", "new": "value"};
      expect(u.merge(m, n), expected);
      expect(u.merge(n, m), expected);
      expect(u.merge(m, null), m);
      expect(u.merge(null, m), m);
    });
  });

  group("asX", () {
    test("asWidgets: returns a list of widgets", () async {
      Widget a = ErrorWidget(null);
      Widget b;
      List<Widget> actual = u.asWidgets([a, b, b, a]);
      expect(actual, [a, null, null, a]);
    });
    test("asMaps:  returns a list of Maps", () async {
      Map a = {"a": 1};
      Map b = {"b": 2};
      List<Map> actual = u.asMaps([a, b]);
      expect(actual, [a, b]);
    });
  });

  group("nonNullX", () {
    test("Widgets: returns a list of widgets", () async {
      Widget a = ErrorWidget(null);
      Widget b;
      List<Widget> actual = u.nonNullWidgets([a, b, b, a]);
      expect(actual, [a, a]);
    });
    test("asMaps:  returns a list of Maps", () async {
      Map a = {"a": 1};
      Map b = {"b": 2};
      Map c;
      List<Map> actual = u.nonNullMaps([a, c, c, b]);
      expect(actual, [a, b]);
    });
  });

  group("when", () {
    test("returns null if not truthy", () async {
      expect(u.when(false, true), null);
      expect(u.when(null, true), null);
      expect(u.when(0, true), null);
      expect(u.when({}, true), null);
      expect(u.when([], true), null);
      expect(u.when(true, true), true);
      expect(u.when([1], true), true);
      expect(u.when({"a": 1}, true), true);
    });

    test("invokes a function with val when truthy", () async {
      expect(u.when(0, (v) => v + 10), null);
      expect(u.when(1, (v) => v + 10), 11);
    });
  });
  group("ifVal", () {
    test("returns true or false path", () async {
      expect(u.ifVal(false, 1, -1), -1);
      expect(u.ifVal(null, 1, -1), -1);
      expect(u.ifVal(0, 1, -1), -1);
      expect(u.ifVal({}, 1, -1), -1);
      expect(u.ifVal([], 1, -1), -1);
      expect(u.ifVal(true, 1, -1), 1);
      expect(u.ifVal([1], 1, -1), 1);
      expect(u.ifVal({"a": 1}, 1, -1), 1);
    });
  });

  group("isNotNull", () {
    test("returns true if not null", () async {
      expect(u.isNotNull(null), false);
      expect(u.isNotNull(true), true);
      expect(u.isNotNull(0), true);
      expect(u.isNotNull({}), true);
    });
  });
}
