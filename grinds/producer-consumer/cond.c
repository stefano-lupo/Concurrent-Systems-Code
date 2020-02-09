
// S: is n odd?
int cond1(int n) { return ((n/2)*2!=n); }

// S: Is n even?
int cond2(int n) { return ((n/2)*2==n); }

// S: Is n divisible by 3
int cond3(int n) { return ( n % 3 == 0 ); }

// S: Handy for debugging
int alwaysTrue(int n) { return 1; }
