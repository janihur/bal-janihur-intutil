import ballerina/test;

@test:Config {}
function test_range_inc() {
    IntIterable iterable = range(1,3);
    IntIter iterator = iterable.iterator();
    test:assertEquals(iterator.next(), {value: 1});
    test:assertEquals(iterator.next(), {value: 2});
    test:assertEquals(iterator.next(), ());
}

@test:Config {}
function test_range_dec() {
    IntIterable iterable = range(3,1);
    IntIter iterator = iterable.iterator();
    test:assertEquals(iterator.next(), {value: 3});
    test:assertEquals(iterator.next(), {value: 2});
    test:assertEquals(iterator.next(), ());
}

@test:Config {}
function test_range_equ() {
    IntIterable iterable = range(3,3);
    IntIter iterator = iterable.iterator();
    test:assertEquals(iterator.next(), ());
}

@test:Config {}
function test_range_foreach() {
    int[] actual = [];
    foreach int i in range(0,3) {
        actual.push(i);
    }
    foreach int i in range(3,0) {
        actual.push(i);
    }
    test:assertEquals(actual, [0,1,2,3,2,1]);
}

@test:Config {}
function test_indexRange_inc() {
    int[] a = [1,2,3];
    IntIterable iterable = indexRange(0, a.length());
    IntIter iterator = iterable.iterator();
    test:assertEquals(iterator.next(), {value: 0});
    test:assertEquals(iterator.next(), {value: 1});
    test:assertEquals(iterator.next(), {value: 2});
    test:assertEquals(iterator.next(), ());
}

@test:Config {}
function test_indexRange_dec() {
    int[] a = [1,2,3];
    IntIterable iterable = indexRange(a.length(), 0);
    IntIter iterator = iterable.iterator();
    test:assertEquals(iterator.next(), {value: 2});
    test:assertEquals(iterator.next(), {value: 1});
    test:assertEquals(iterator.next(), {value: 0});
    test:assertEquals(iterator.next(), ());
}

@test:Config {}
function test_indexRange_foreach() {
    int[] a = [1,2,3];
    int[] actual = [];
    foreach int i in indexRange(0, a.length()) {
        actual.push(i);
    }
    foreach int i in indexRange(a.length(), 0) {
        actual.push(i);
    }
    test:assertEquals(actual, [0,1,2,2,1,0]);
}
