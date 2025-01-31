#include <stdint.h>
#include <stdio.h>

// CRC-32 Polynomial (0x04C11DB7)
#define CRC32_POLY 0x04C11DB7

// Function to compute CRC32 with 8-bit input
uint32_t crc32_update(uint32_t crc, uint8_t data) {
    crc ^= ((uint32_t)data << 24); // Align data to the highest byte

    for (int i = 0; i < 8; i++) { // Process 8 bits
        if (crc & 0x80000000) {   // Check MSB
            crc = (crc << 1) ^ CRC32_POLY;
        } else {
            crc <<= 1;
        }
    }
    return crc;
}

// Function to compute CRC32 over a full data buffer
uint32_t crc32_compute(uint8_t *data, size_t length) {
    uint32_t crc = 0xFFFFFFFF; // Initial value (standard CRC-32 start)

    for (size_t i = 0; i < length; i++) {
        crc = crc32_update(crc, data[i]);
    }

    return crc; // No final XOR, per the requirements
}

// Test the CRC32 function
int main() {
    uint8_t test_data[] = {1,2,3,4,5,6,7,8,9}; // Example input
    size_t length = sizeof(test_data) / sizeof(test_data[0]);

    uint32_t crc_result = crc32_compute(test_data, length);
    printf("CRC32: 0x%08X\n", crc_result);

    return 0;
}

