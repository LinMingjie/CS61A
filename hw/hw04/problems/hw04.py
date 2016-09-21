HW_SOURCE_FILE = 'hw04.py'


def g(n):
    """Return the value of G(n), computed recursively.

    >>> g(1)
    1
    >>> g(2)
    2
    >>> g(3)
    3
    >>> g(4)
    10
    >>> g(5)
    22
    >>> g(9)
    696
    >>> from construct_check import check
    >>> check(HW_SOURCE_FILE, 'g', ['While', 'For'])
    True
    """
    if n <= 3:
        return n
    return g(n - 1) + 2 * g(n - 2) + 3 * g(n - 3)


def g_iter(n):
    """Return the value of G(n), computed iteratively.

    >>> g_iter(1)
    1
    >>> g_iter(2)
    2
    >>> g_iter(3)
    3
    >>> g_iter(4)
    10
    >>> g_iter(5)
    22
    >>> g_iter(9)
    696
    >>> from construct_check import check
    >>> check(HW_SOURCE_FILE, 'g_iter', ['Recursion'])
    True
    """
    if n <= 3:
        return n
    n_1, n_2, n_3 = 3, 2, 1
    for i in range(4, n):
        next_n_1 = n_1 + 2 * n_2 + 3 * n_3
        next_n_2 = n_1
        next_n_3 = n_2
        n_1, n_2, n_3 = next_n_1, next_n_2, next_n_3
    return n_1 + 2 * n_2 + 3 * n_3


def pingpong(n):
    """Return the nth element of the ping-pong sequence.

    >>> pingpong(1)
    1
    >>> pingpong(2)
    2
    >>> pingpong(7)
    7
    >>> pingpong(8)
    6
    >>> pingpong(15)
    1
    >>> pingpong(21)
    -1
    >>> pingpong(22)
    0
    >>> pingpong(30)
    6
    >>> pingpong(68)
    2
    >>> pingpong(69)
    1
    >>> pingpong(70)
    0
    >>> pingpong(71)
    1
    >>> pingpong(72)
    0
    >>> pingpong(100)
    2
    >>> from construct_check import check
    >>> check(HW_SOURCE_FILE, 'pingpong', ['Assign', 'AugAssign'])
    True
    """
    """
    # iterative version
    up = True
    ret = 0
    for i in range(1, n + 1):
        if up:
            ret += 1
        else:
            ret -= 1
        if i % 7 == 0 or has_seven(i):
            up = not up
    """
    def is_up(k):
        if k == 1:
            return True
        if (k - 1) % 7 == 0 or has_seven(k - 1):
            return not is_up(k - 1)
        else:
            return is_up(k - 1)
    if n == 1:
        return 1
    if is_up(n):
        return pingpong(n - 1) + 1
    else:
        return pingpong(n - 1) - 1


def has_seven(k):
    """Returns True if at least one of the digits of k is a 7, False otherwise.

    >>> has_seven(3)
    False
    >>> has_seven(7)
    True
    >>> has_seven(2734)
    True
    >>> has_seven(2634)
    False
    >>> has_seven(734)
    True
    >>> has_seven(7777)
    True
    """
    if k % 10 == 7:
        return True
    elif k < 10:
        return False
    else:
        return has_seven(k // 10)


def count_change(amount):
    """Return the number of ways to make change for amount.

    >>> count_change(4)
    4
    >>> count_change(7)
    6
    >>> count_change(10)
    14
    >>> count_change(20)
    60
    >>> count_change(100)
    9828
    """
    def max_part(n):
        i = 1
        while i <= n:
            i *= 2
        return i // 2

    def count_partitions(n, m):
        """Count the ways to partition n using parts up to m."""
        if n == 0:
            return 1
        elif n < 0:
            return 0
        elif m == 0:
            return 0
        else:
            return count_partitions(n - m, m) + count_partitions(n, m // 2)
    return count_partitions(amount, max_part(amount))

###################
# Extra Questions #
###################

from operator import sub, mul


def make_anonymous_factorial():
    """Return the value of an expression that computes factorial.

    >>> make_anonymous_factorial()(5)
    120
    >>> from construct_check import check
    >>> check(HW_SOURCE_FILE, 'make_anonymous_factorial', ['Assign', 'AugAssign', 'FunctionDef', 'Recursion'])
    True
    """
    return 'YOUR_EXPRESSION_HERE'
