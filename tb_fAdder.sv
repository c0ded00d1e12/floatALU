module tb_fAdder();
	logic[7:0] sum, a, b;
	logic[7:0] finite = 8'b01010100;
	logic[7:0] posinf = 8'b01111000;
	logic[7:0] neginf = 8'b11111000;
	logic[7:0] nan    = 8'b01111111;
	logic[7:0] negnan = 8'b11111111;
	logic sub;
	int errorcount = 0;

	fAdder Adder(.sum(sum), .a(a), .b(b), .sub(sub));

	function int outcome(logic[7:0] expected);
		if (expected == nan) begin
			if (sum != expected && sum != negnan) begin
				$display("FAILED: Expected %0d, got %0d", expected, sum);
				outcome = 1;
			end else outcome = 0;
		end else if (sum != expected) begin
			$display("FAILED: Expected %0d, got %0d", expected, sum);
			outcome = 1;
		end else outcome = 0;
	endfunction

	initial begin

		// -- INF ADDITION -- \\
		assign sub = 0;

		$display("Testing inf + inf...");
		assign a = posinf;
		assign b = posinf;
		#10ns;
		errorcount = errorcount + outcome(posinf);

		$display("Testing inf + -inf...");
		assign a = posinf;
		assign b = neginf;
		#10ns;
		errorcount = errorcount + outcome(nan);

		$display("Testing -inf + inf...");
		assign a = neginf;
		assign b = posinf;
		#10ns;
		errorcount = errorcount + outcome(nan);

		$display("Testing -inf + -inf...");
		assign a = neginf;
		assign b = neginf;
		#10ns;
		errorcount = errorcount + outcome(neginf);

		$display("Testing inf + finite...");
		assign a = posinf;
		assign b = finite;
		#10ns;
		errorcount = errorcount + outcome(posinf);

		$display("Testing -inf + finite...");
		assign a = neginf;
		assign b = finite;
		#10ns;
		errorcount = errorcount + outcome(neginf);

		$display("Testing finite + inf...");
		assign a = finite;
		assign b = posinf;
		#10ns;
		errorcount = errorcount + outcome(posinf);

		$display("Testing finite + -inf...");
		assign a = finite;
		assign b = neginf;
		#10ns;
		errorcount = errorcount + outcome(neginf);

		// -- INF SUBTRACTION -- \\
		assign sub = 1;

		$display("Testing inf - inf...");
		assign a = posinf;
		assign b = posinf;
		#10ns;
		errorcount = errorcount + outcome(nan);

		$display("Testing inf - -inf...");
		assign a = posinf;
		assign b = neginf;
		#10ns;
		errorcount = errorcount + outcome(posinf);

		$display("Testing -inf - inf...");
		assign a = neginf;
		assign b = posinf;
		#10ns;
		errorcount = errorcount + outcome(neginf);

		$display("Testing -inf - -inf...");
		assign a = neginf;
		assign b = neginf;
		#10ns;
		errorcount = errorcount + outcome(nan);

		$display("Testing -inf - finite...");
		assign a = neginf;
		assign b = finite;
		#10ns;
		errorcount = errorcount + outcome(neginf);

		$display("Testing inf - finite...");
		assign a = posinf;
		assign b = finite;
		#10ns;
		errorcount = errorcount + outcome(posinf);

		$display("Testing finite - inf...");
		assign a = finite;
		assign b = posinf;
		#10ns;
		errorcount = errorcount + outcome(neginf);

		$display("Testing finite - -inf...");
		assign a = finite;
		assign b = neginf;
		#10ns;
		errorcount = errorcount + outcome(posinf);

		// -- NAN -- \\
		sub = 0;
		$display("Testing NaN + inf...");
		assign a = nan;
		assign b = posinf;
		#10ns;
		errorcount = errorcount + outcome(nan);

		$display("Testing NaN + -inf...");
		assign a = nan;
		assign b = neginf;
		#10ns;
		errorcount = errorcount + outcome(nan);

		$display("Testing NaN + NaN...");
		assign a = nan;
		assign b = nan;
		#10ns;
		errorcount = errorcount + outcome(nan);

		$display("Testing inf + NaN...");
		assign a = posinf;
		assign b = nan;
		#10ns;
		errorcount = errorcount + outcome(nan);

		$display("Testing -inf + NaN...");
		assign a = neginf;
		assign b = nan;
		#10ns;
		errorcount = errorcount + outcome(nan);

		$display("Testing NaN + finite...");
		assign a = nan;
		assign b = finite;
		#10ns;
		errorcount = errorcount + outcome(nan);

		$display("Testing finite + NaN...");
		assign a = finite;
		assign b = nan;
		#10ns;
		errorcount = errorcount + outcome(nan);

		assign sub = 1;
		$display("Testing NaN - -inf...");
		assign a = nan;
		assign b = neginf;
		#10ns;
		errorcount = errorcount + outcome(nan);

		$display("Testing NaN - inf...");
		assign a = nan;
		assign b = posinf;
		#10ns;
		errorcount = errorcount + outcome(nan);

		$display("Testing NaN - NaN...");
		assign a = nan;
		assign b = nan;
		#10ns;
		errorcount = errorcount + outcome(nan);

		$display("Testing inf - NaN...");
		assign a = posinf;
		assign b = nan;
		#10ns;
		errorcount = errorcount + outcome(nan);

		$display("Testing -inf - NaN...");
		assign a = neginf;
		assign b = nan;
		#10ns;
		errorcount = errorcount + outcome(nan);

		$display("Testing finite - NaN...");
		assign a = finite;
		assign b = nan;
		#10ns;
		errorcount = errorcount + outcome(nan);

		$display("Testing NaN - finite...");
		assign a = nan;
		assign b = finite;
		#10ns;
		errorcount = errorcount + outcome(nan);

		$display("-----");
		$display("Tests completed with %0d errors", errorcount);
		$finish;
	end
endmodule
