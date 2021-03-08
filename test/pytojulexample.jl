class MyClass(object):

    def __init__(self, foo, bar):
        self.foo = foo
        self.bar = bar

    def do_something(self):
        return self.foo + self.bar

    def do_something_else(self, num):
        return num * self.bar

my_class = MyClass(1, 10)
my_class.do_something()  # returns 11
my_class.do_something_else(10)  # returns 100



struct State
    foo::Int
    bar::Float64
end

function dosomething(s::State)
    s.foo + s.bar
end

function dosomethingelse(s::State, n::Int)
    n * s.bar
end

s = State(1, 10)
dosomething(s)  # returns 11
dosomethingelse(s, 10)  # returns 100