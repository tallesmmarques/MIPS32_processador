vsim work.register_file
add wave -position insertpoint sim:/register_file/*
force -freeze sim:/register_file/CLK 0 0, 1 {50000 ps} -r {100 ns}
force -freeze sim:/register_file/WE3 0 0
force -freeze sim:/register_file/A1 10000 0
force -freeze sim:/register_file/A2 10001 0
force -freeze sim:/register_file/A3 10010 0
force -freeze sim:/register_file/WD3 00000000000000000000000000000111 0
run
force -freeze sim:/register_file/WE3 1 0
run
force -freeze sim:/register_file/WE3 0 0
run
force -freeze sim:/register_file/A1 10010 0
run
force -freeze sim:/register_file/CLK 0 0, 1 {50 ps} -r 100
run
force -freeze sim:/register_file/WE3 1 0
run
force -freeze sim:/register_file/WE3 0 0
run