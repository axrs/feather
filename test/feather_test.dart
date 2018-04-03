import 'package:feather/feather.dart' as u;
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
}
