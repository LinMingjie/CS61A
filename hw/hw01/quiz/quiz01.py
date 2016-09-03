def multiple(a, b):
    """Return the smallest number n that is a multiple of both a and b.

    >>> multiple(3, 4)
    12
    >>> multiple(14, 21)
    42
    """
    t_a, t_b = a, b
    # gcd
    while b != 0:
        r = b
        b = a % b
        a = r
    # lcm
    return t_a * t_b // a


def unique_digits(n):
    """Return the number of unique digits in positive integer n

    >>> unique_digits(8675309) # All are unique
    7
    >>> unique_digits(1313131) # 1 and 3
    2
    >>> unique_digits(13173131) # 1, 3, and 7
    3
    >>> unique_digits(10000) # 0 and 1
    2
    >>> unique_digits(101) # 0 and 1
    2
    >>> unique_digits(10) # 0 and 1
    2
    """
    is_unique = [True] * 10
    count = 0
    while n > 0:
        if is_unique[n % 10]:
            count += 1
            is_unique[n % 10] = False
        n //= 10
    return count
