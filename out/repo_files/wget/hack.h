#ifndef HACK_H
#define HACK_H

#ifndef IN6_ARE_ADDR_EQUAL
#define IN6_ARE_ADDR_EQUAL(a,b) \
        ((((__const uint32_t *) (a))[0] == ((__const uint32_t *) (b))[0])     \
         && (((__const uint32_t *) (a))[1] == ((__const uint32_t *) (b))[1])  \
         && (((__const uint32_t *) (a))[2] == ((__const uint32_t *) (b))[2])  \
         && (((__const uint32_t *) (a))[3] == ((__const uint32_t *) (b))[3]))
#endif

#endif
