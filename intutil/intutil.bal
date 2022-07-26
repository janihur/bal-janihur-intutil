public type IntResult record {|
    int value;
|};

public class IntIter {
    int c;
    final int end;
    final int step;
    final function(int, int) returns boolean stopFn;

    function init(int beg, int end, int? step = ()) {
        self.c = beg;
        self.end = end;
        if beg < end { // increment
            self.step = step ?: 1;
            //self.cmp = function (int beg_, int end_) returns boolean { return beg_ >= end_; };
            self.stopFn = (curr, term) => curr >= term;
        } else if beg > end { // decrement
            self.step = step ?: -1;
            //self.stopFn = function (int beg_, int end_) returns boolean { return beg_ <= end_; };
            self.stopFn = (curr, term) => curr <= term;
        } else { // quit
            self.step = 0;
            //self.stopFn = function (int beg_, int end_) returns boolean { return false; };
            self.stopFn = (curr, term) => true;
        }
    }

    // Implements the `next` method
    public function next() returns IntResult? {
        if self.stopFn(self.c, self.end) {
            return ();
        }
        IntResult r = {value: self.c};
        self.c += self.step;
        return r;
    }
}

public class IntIterable {
    // Need to have this type inclusion as to indicate the distinct type relationship
    *object:Iterable;

    final int beg;
    final int end;
    final int? step;

    function init(int beg, int end, int? step = ()) {
        self.beg = beg;
        self.end = end;
        self.step = step;
    }
    
    public function iterator() returns IntIter {
        return new IntIter(self.beg, self.end, self.step);
    }
}

# Returns Ballerina `object:Iterable<int,()>` that represents an integer range.
# 
# The range can be either:
# 
# * incrementing (i.e. 1,2,3...)
# * decrementing (i.e. 3,2,1...)
# 
# The range is incrementing when `beg < end`.
# Increments by `step` (default 1) where `step` has to be greater than zero.
# 
# The range is decrementing when `beg > end`.
# Decrements by `step` (default -1) where `step` has to be less than zero.
# 
# Returns `()` when `beg == end`.
#
# + beg - The first integer value (always inclusive)
# + end - The last integer value (always exclusive)
# + step - The step between the iterations. See above the valid values. The behaviour with invalid values is not defined.
# + return - `object:Iterable<int,()>`
public function range(int beg, int end, int? step = ()) returns IntIterable {
    return new IntIterable(beg, end, step);
}

# Returns Ballerina `object:Iterable<int,()>` that represents an integer range suitable for array indexes.
#
# The function is supposed to be used to iterate over array indexes in both directions:
# ```ballerina
# int[] a = [1,2,3];
# foreach int i in indexRange(0, a.length()) {
#     io:print(i); // 012
# }
# foreach int i in indexRange(a.length(), 0) {
#     io:print(i); // 210
# }
# ```
#
# + beg - The first integer value. Inclusive when `beg < end`, exlusive when `beg > end`.
# + end - The last integer value. Inclusive when `end < beg`, exlusive when `end > beg`.
# + return - `object:Iterable<int,()>`
public function indexRange(int beg, int end) returns IntIterable {
    if beg > end {
        return new IntIterable(beg-1, end-1, -1);
    } else {
        return new IntIterable(beg, end);
    }   
}