# Read the hex file and generate the txt output
hex_filename = "../../fram_connect_debug/src/servant_1.3.0/sw/zephyr_hello.hex"  # your .hex file
output_filename = "Mem_initialize_zephyr.txt"  # the .txt you want to create

address = 0  # starting address

with open(hex_filename, "r") as hex_file, open(output_filename, "w") as output_file:
    for line in hex_file:
        hex_value = line.strip()
        if hex_value:  # skip empty lines
            output_file.write(f"   data = 0x{hex_value};\n")
            output_file.write(f"   fram.write(0x{address:x}, (uint8_t*)&data, sizeof(data));\n")
            address += 4  # increment address by 4 bytes
