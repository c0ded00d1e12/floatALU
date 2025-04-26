help: echo "help"
	echo "test_fAdder"

fAdder.sv:
	echo "module fAdder(); endmodule" > fAdder.sv


test_fAdder: fAdder.sv tb_fAdder.sv
	xvlog $^ -sv --nolog
	xelab tb_fAdder --debug typical --nolog
	xsim tb_fAdder -runall

clean:
	rm -rf *.jou *.log *.pb *.wdb xsim.dir
