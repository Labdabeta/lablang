#ifndef TEST_H
#define TEST_H

#define THING ABC
#define THING2(A,B,C) ((A ## B) * (C))
#define OTHER(X) (#X)

#define FL __FILE__ __LINE__ __DATE__

#endif /* TEST_H */
