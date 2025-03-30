import numpy as np
from scipy.special import factorial

def DTT(N):
    # Input validation
    if not isinstance(N, int):
        raise ValueError("Input must be an integer")
    if N % 2 != 0:
        raise ValueError("Input must be a multiple of 2")

    # Initialize arrays
    a1 = np.zeros(N)
    a2 = np.zeros(N)
    a3 = np.zeros(N)

    # Compute coefficients a1, a2, a3 for K=1 to N-1
    for K in range(1, N):
        a1[K-1] = (2 / K) * np.sqrt((4 * K**2 - 1) / (N**2 - K**2))
        a2[K-1] = ((1 - N) / K) * np.sqrt((4 * K**2 - 1) / (N**2 - K**2))
        if K == 1:
            a3[K-1] = 0  # Special case to avoid invalid sqrt
        else:
            a3[K-1] = ((1 - K) / K) * np.sqrt((2 * K + 1) / (2 * K - 3)) * np.sqrt((N**2 - (K-1)**2) / (N**2 - K**2))

    # Define first two Tchebichev polynomials
    x = np.arange(N)
    T0 = np.ones(N) / np.sqrt(N)
    T1 = (1 + 2*x - N) * np.sqrt(3 / (N * (N**2 - 1)))
    TT = np.vstack((T0, T1))

    # Compute additional rows for N > 2
    if N > 2:
        for i in range(2, N):
            Ti = (a1[i-1] * x + a2[i-1]) * TT[i-1, :] + a3[i-1] * TT[i-2, :]
            TT = np.vstack((TT, Ti))

    # Compute p array
    p = np.zeros(N)
    for i in range(N):
        if i == 1:
            p[i] = factorial(i) * i
        elif i % 2 == 1:
            p[i] = factorial(i) * (N - i)
        else:
            p[i] = factorial(i) * (i + 1)

    # Compute d array
    d = np.zeros(N)
    for k in range(N):
        d[k] = factorial(k + N) / ((2 * k + 1) * factorial(N - k - 1))
    d = np.sqrt(d)

    # Compute q array
    q = p / d

    # Compute Q as diagonal matrix with 1/q elements
    Q = np.diag(1 / q)

    # Compute T matrix
    T = Q @ TT
    T = np.round(T)

    # Compute Original matrix
    Original = np.diag(q) @ T

    return TT, T, Q, Original

# Test with N = 8
#TT, T, Q, Original = DTT(4)
#print("TT:\n", TT)
#print("T:\n", T)
#print("Q:\n", Q)
#print("Original:\n", Original)
