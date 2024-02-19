#include <stdint.h>

#define TEA_DELTA 0x9e3779b9
#define TEA_SUM(v, s) ((v) + ((s) * TEA_DELTA))
#define TEA_ROUNDS 32

void tea_encrypt(uint32_t* v, uint32_t* k) {
    uint32_t sum = 0;
    for (int i = 0; i < TEA_ROUNDS; i++) {
        sum = TEA_SUM(sum, 1);
        v[0] += ((v[1] << 4) + k[0]) ^ (v[1] + sum) ^ ((v[1] >> 5) + k[1]);
        v[1] += ((v[0] << 4) + k[2]) ^ (v[0] + sum) ^ ((v[0] >> 5) + k[3]);
    }
}

void tea_decrypt(uint32_t* v, uint32_t* k) {
    uint32_t sum = TEA_DELTA * TEA_ROUNDS;
    for (int i = 0; i < TEA_ROUNDS; i++) {
        v[1] -= ((v[0] << 4) + k[2]) ^ (v[0] + sum) ^ ((v[0] >> 5) + k[3]);
        v[0] -= ((v[1] << 4) + k[0]) ^ (v[1] + sum) ^ ((v[1] >> 5) + k[1]);
        sum = TEA_SUM(sum, -1);
    }
}
