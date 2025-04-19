#include "Adafruit_FRAM_SPI.h"
#include <SPI.h>

/* Example code for the Adafruit SPI FRAM breakout */
uint8_t FRAM_CS = 10;

Adafruit_FRAM_SPI fram = Adafruit_FRAM_SPI(FRAM_CS);  // use hardware SPI

uint8_t FRAM_SCK = 13;
uint8_t FRAM_MISO = 12;
uint8_t FRAM_MOSI = 11;
// Or use software SPI, any pins!
// Adafruit_FRAM_SPI fram =
//     Adafruit_FRAM_SPI(FRAM_SCK, FRAM_MISO, FRAM_MOSI, FRAM_CS);

uint16_t addr = 0;



void setup(void) {
  Serial.begin(9600);
  while (!Serial)
    delay(10); // will pause Zero, Leonardo, etc until serial console opens

  if (fram.begin(3)) {
    Serial.println("Found SPI FRAM");
  } else {
    Serial.println("No SPI FRAM found ... check your connections\r\n");
    while (1)
      ;
  }

  Serial.print("Status register: ");
  Serial.println(fram.getStatusRegister(), BIN);

  fram.writeEnable(true);

  Serial.print("Status register: ");
  Serial.println(fram.getStatusRegister(), BIN);

  // Read the first byte
  // uint8_t test = fram.read8(0x0);
  // Serial.print("Restarted ");
  // Serial.print(test);
  // Serial.println(" times");

  // // Test write ++
  // fram.writeEnable(true);
  // fram.write8(0x0, test + 1);
  // fram.writeEnable(false);

  // fram.writeEnable(true);
  // fram.write(0x1, (uint8_t *)"GTW!", 5);
  // fram.writeEnable(false);

  uint32_t data;   // Store the value

   // blinky.hex
   fram.writeEnable(true);
   data = 0x40000537;
   fram.write(0x0, (uint8_t*)&data, sizeof(data));
   data = 0x00050513;
   fram.write(0x4, (uint8_t*)&data, sizeof(data));
   data = 0x00100337;
   fram.write(0x8, (uint8_t*)&data, sizeof(data));
   data = 0x00100293;
   fram.write(0xc, (uint8_t*)&data, sizeof(data));
   data = 0x00550023;
   fram.write(0x10, (uint8_t*)&data, sizeof(data));
   data = 0x0012C293;
   fram.write(0x14, (uint8_t*)&data, sizeof(data));
   data = 0x000073B3;
   fram.write(0x18, (uint8_t*)&data, sizeof(data));
   data = 0x00138393;
   fram.write(0x1c, (uint8_t*)&data, sizeof(data));
   data = 0xFE731EE3;
   fram.write(0x20, (uint8_t*)&data, sizeof(data));
   data = 0xFEDFF06F;
   fram.write(0x24, (uint8_t*)&data, sizeof(data));
   data = 0x00000000;
   fram.write(0x28, (uint8_t*)&data, sizeof(data));
   fram.writeEnable(false);

  // hello_uart.hex
  // fram.writeEnable(true);
  // data = 0x40000537;
  // fram.write(0x0, (uint8_t*)&data, sizeof(data));
  // data = 0x00100293;
  // fram.write(0x4, (uint8_t*)&data, sizeof(data));
  // data = 0x00550023;
  // fram.write(0x8, (uint8_t*)&data, sizeof(data));
  // data = 0x00000597;
  // fram.write(0xc, (uint8_t*)&data, sizeof(data));
  // data = 0x04058593;
  // fram.write(0x10, (uint8_t*)&data, sizeof(data));
  // data = 0x0005C283;
  // fram.write(0x14, (uint8_t*)&data, sizeof(data));
  // data = 0x02028463;
  // fram.write(0x18, (uint8_t*)&data, sizeof(data));
  // data = 0x1002E293;
  // fram.write(0x1c, (uint8_t*)&data, sizeof(data));
  // data = 0x00129293;
  // fram.write(0x20, (uint8_t*)&data, sizeof(data));
  // data = 0x00550023;
  // fram.write(0x24, (uint8_t*)&data, sizeof(data));
  // data = 0x0012D293;
  // fram.write(0x28, (uint8_t*)&data, sizeof(data));
  // data = 0x00000013;
  // fram.write(0x2c, (uint8_t*)&data, sizeof(data));
  // data = 0x00000013;
  // fram.write(0x30, (uint8_t*)&data, sizeof(data));
  // data = 0xFE0298E3;
  // fram.write(0x34, (uint8_t*)&data, sizeof(data));
  // data = 0x00158593;
  // fram.write(0x38, (uint8_t*)&data, sizeof(data));
  // data = 0xFD9FF06F;
  // fram.write(0x3c, (uint8_t*)&data, sizeof(data));
  // data = 0x900002B7;
  // fram.write(0x40, (uint8_t*)&data, sizeof(data));
  // data = 0x0002A023;
  // fram.write(0x44, (uint8_t*)&data, sizeof(data));
  // data = 0xFF9FF06F;
  // fram.write(0x48, (uint8_t*)&data, sizeof(data));
  // data = 0x202C6948;
  // fram.write(0x4c, (uint8_t*)&data, sizeof(data));
  // data = 0x206D2749;
  // fram.write(0x50, (uint8_t*)&data, sizeof(data));
  // data = 0x76726553;
  // fram.write(0x54, (uint8_t*)&data, sizeof(data));
  // data = 0x21746E61;
  // fram.write(0x58, (uint8_t*)&data, sizeof(data));
  // data = 0x0000000A;
  // fram.write(0x5c, (uint8_t*)&data, sizeof(data));
  // fram.writeEnable(false);

  // dump the entire 8K of memory!
  uint8_t value;
  for (uint16_t a = 0; a < 8192; a++) {
    value = fram.read8(a);
    if ((a % 32) == 0) {
      Serial.print("\n 0x");
      Serial.print(a, HEX);
      Serial.print(": ");
    }
    Serial.print("0x");
    if (value < 0x1)
      Serial.print('0');
    Serial.print(value, HEX);
    Serial.print(" ");
  }
}

void loop(void) {}
