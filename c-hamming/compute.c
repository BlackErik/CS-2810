#include "compute.h"
#include <string.h>

int compute( char *a, char *b ){
    int a_len = strlen( a );
    int b_len = strlen( b );
    
    int distance = 0;

    if( a_len != b_len ){
        distance = -1;
    } else {
        for( int i = 0; i < a_len; i++ ){
            if( a[i] != b[i] ){
                distance++;
            }

        }
    }
    return distance;

}