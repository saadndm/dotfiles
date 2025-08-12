# bad_code.py


x = 1  # E201: whitespace after '='
y = 2  # E225: missing whitespace around operator


def foo(bar, baz):  # D103: missing docstring
    print("Hello World")  # T201: print statement (if enabled)
    for i in range(55):
        print("hi")
    return bar + baz  # E225: missing whitespace around operator


foo(1, 2)
