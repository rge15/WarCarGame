#include "tanque.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2017
// Tile tanque_0: 12x16 pixels, 6x16 bytes.
const u8 tanque_0[6 * 16] = {
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xa1, 0x52, 0x03, 0xf1, 0xf3,
	0xf3, 0xa1, 0x52, 0x03, 0xf1, 0xf3,
	0xf3, 0xe1, 0xc3, 0xc3, 0xf1, 0xf3,
	0xf3, 0xe3, 0xc3, 0xc3, 0xf3, 0xf3,
	0xf3, 0xe3, 0xc3, 0xc3, 0xe3, 0xf3,
	0xf3, 0xe3, 0xc3, 0xc3, 0xc3, 0xf3,
	0xf3, 0xe3, 0xc3, 0xc3, 0xc3, 0xf3,
	0xf3, 0xe3, 0xc3, 0xc3, 0xe3, 0xf3,
	0xf3, 0xe3, 0xc3, 0xc3, 0xf3, 0xf3,
	0xf3, 0xe1, 0xc3, 0xc3, 0xf1, 0xf3,
	0xf3, 0xa1, 0x52, 0x03, 0xf1, 0xf3,
	0xf3, 0xa1, 0x52, 0x03, 0xf1, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3
};

// Tile tanque_1: 12x16 pixels, 6x16 bytes.
const u8 tanque_1[6 * 16] = {
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xc3, 0xc3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xe3, 0xd3, 0xf3, 0xf3,
	0xf3, 0xf0, 0xe1, 0xd2, 0xf0, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0xf0, 0xc3, 0xc3, 0xf0, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0xf0, 0xf1, 0xf2, 0xf0, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3
};

// Tile tanque_2: 12x16 pixels, 6x16 bytes.
const u8 tanque_2[6 * 16] = {
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0x52, 0x03, 0x52, 0x53, 0xf3,
	0xf3, 0x52, 0x03, 0x52, 0x53, 0xf3,
	0xf3, 0x43, 0xc3, 0xc3, 0x53, 0xf3,
	0xf3, 0xe3, 0xc3, 0xc3, 0xf3, 0xf3,
	0xf3, 0xe3, 0xc3, 0xc3, 0xe3, 0xf3,
	0xf3, 0xe3, 0xc3, 0xc3, 0xc3, 0xf3,
	0xf3, 0xe3, 0xc3, 0xc3, 0xc3, 0xf3,
	0xf3, 0xe3, 0xc3, 0xc3, 0xe3, 0xf3,
	0xf3, 0xe3, 0xc3, 0xc3, 0xf3, 0xf3,
	0xf3, 0x43, 0xc3, 0xc3, 0x53, 0xf3,
	0xf3, 0x52, 0x03, 0x52, 0x53, 0xf3,
	0xf3, 0x52, 0x03, 0x52, 0x53, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3
};

// Tile tanque_3: 12x16 pixels, 6x16 bytes.
const u8 tanque_3[6 * 16] = {
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xc3, 0xc3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xe3, 0xd3, 0xf3, 0xf3,
	0xf3, 0x03, 0x43, 0x83, 0x03, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0xf0, 0xc3, 0xc3, 0xf0, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0xf0, 0xc3, 0xc3, 0xf0, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0x03, 0x53, 0xa3, 0x03, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3
};

// Tile tanque_4: 12x16 pixels, 6x16 bytes.
const u8 tanque_4[6 * 16] = {
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf2, 0x03, 0xa1, 0x52, 0xf3,
	0xf3, 0xf2, 0x03, 0xa1, 0x52, 0xf3,
	0xf3, 0xf2, 0xc3, 0xc3, 0xd2, 0xf3,
	0xf3, 0xf3, 0xc3, 0xc3, 0xd3, 0xf3,
	0xf3, 0xd3, 0xc3, 0xc3, 0xd3, 0xf3,
	0xf3, 0xc3, 0xc3, 0xc3, 0xd3, 0xf3,
	0xf3, 0xc3, 0xc3, 0xc3, 0xd3, 0xf3,
	0xf3, 0xd3, 0xc3, 0xc3, 0xd3, 0xf3,
	0xf3, 0xf3, 0xc3, 0xc3, 0xd3, 0xf3,
	0xf3, 0xf2, 0xc3, 0xc3, 0xd2, 0xf3,
	0xf3, 0xf2, 0x03, 0xa1, 0x52, 0xf3,
	0xf3, 0xf2, 0x03, 0xa1, 0x52, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3
};

// Tile tanque_5: 12x16 pixels, 6x16 bytes.
const u8 tanque_5[6 * 16] = {
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf0, 0xf1, 0xf2, 0xf0, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0xf0, 0xc3, 0xc3, 0xf0, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0xf0, 0xe1, 0xd2, 0xf0, 0xf3,
	0xf3, 0xf3, 0xe3, 0xd3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xc3, 0xc3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3
};

// Tile tanque_6: 12x16 pixels, 6x16 bytes.
const u8 tanque_6[6 * 16] = {
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xa3, 0xa1, 0x03, 0xa1, 0xf3,
	0xf3, 0xa3, 0xa1, 0x03, 0xa1, 0xf3,
	0xf3, 0xa3, 0xc3, 0xc3, 0x83, 0xf3,
	0xf3, 0xf3, 0xc3, 0xc3, 0xd3, 0xf3,
	0xf3, 0xd3, 0xc3, 0xc3, 0xd3, 0xf3,
	0xf3, 0xc3, 0xc3, 0xc3, 0xd3, 0xf3,
	0xf3, 0xc3, 0xc3, 0xc3, 0xd3, 0xf3,
	0xf3, 0xd3, 0xc3, 0xc3, 0xd3, 0xf3,
	0xf3, 0xf3, 0xc3, 0xc3, 0xd3, 0xf3,
	0xf3, 0xa3, 0xc3, 0xc3, 0x83, 0xf3,
	0xf3, 0xa3, 0xa1, 0x03, 0xa1, 0xf3,
	0xf3, 0xa3, 0xa1, 0x03, 0xa1, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3
};

// Tile tanque_7: 12x16 pixels, 6x16 bytes.
const u8 tanque_7[6 * 16] = {
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0x03, 0x53, 0xa3, 0x03, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0xf0, 0xc3, 0xc3, 0xf0, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0xf0, 0xc3, 0xc3, 0xf0, 0xf3,
	0xf3, 0x03, 0xc3, 0xc3, 0x03, 0xf3,
	0xf3, 0x03, 0x43, 0x83, 0x03, 0xf3,
	0xf3, 0xf3, 0xe3, 0xd3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xc3, 0xc3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3, 0xf3, 0xf3
};

