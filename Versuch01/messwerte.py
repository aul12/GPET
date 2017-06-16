from praktikum import *

rm = resourceManager()

instrlist = instr find(rm)

#Hier Device ID einfügen
instr = connect Instrument(rm, "ASRL6::INSTR")

read = query cmd(var instr,"READ?")
'+2.11000000E−03\r\n'

close_Instrument(instr)
close_ResourceManager(rm)
