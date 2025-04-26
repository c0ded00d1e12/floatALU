/****************************************************************************************
 *	Description: Does addition of floating point numbers
 *		Uses 8-bit floats
 *
 ***************************************************************************************/

/* Notes:
 * - sign,exp,mantissa
 * - 1, 4, 3 bits
 * - exp bias = 2^(n-1)-1
 * - normally number is +-1.mantissa * 2^(biased exp)
 * - if exp = 0 then exp=1-bias and 0.mantissa is used instead (if val is +-0, still works
 * - +-inf has highest exp. and a mantissa of 0
 * - NaN has highest exp. and non-zero mantissa
 */

module fAdder #(parameter WIDTH=8, EXP_W=4, MANTISSA_W=3) (
	output logic[WIDTH-1:0] sum,
	input logic[WIDTH-1:0] a, b,
	input logic sub
	);

	always_comb begin
		sum = 0;
		// -- Edge cases: NaN or +/- infinity -- \\
		if (a[WIDTH-2:MANTISSA_W] == {EXP_W{1'b1}}) begin // exp all 1s
			// a is NaN => sum should be NaN
			if (|a[MANTISSA_W-1:0]) begin
				sum = a;
			end else if (b[WIDTH-2:MANTISSA_W] == {EXP_W{1'b1}}) begin
				// b is NaN => sum should be NaN
				if (|b[MANTISSA_W-1:0]) begin
					sum = b;
				// a and b are infinities
				end else begin
					if (|a[WIDTH-1]) begin
						if (sub == b[WIDTH-1]) sum = {a[WIDTH-1:MANTISSA_W], {MANTISSA_W{1'b1}}}; // NaN. -inf+inf
						else sum = a; //-inf
					end else if (sub == b[WIDTH-1]) sum = a; // inf
					else sum = {a[WIDTH-1:MANTISSA_W], {MANTISSA_W{1'b1}}}; // NaN. inf-inf
				end
			// A is an infinity, b is finite
			end else sum = a; // +/- inf
		// b is +/- inf or NaN, but a is finite
		end else if (b[WIDTH-2:MANTISSA_W] == {EXP_W{1'b1}}) sum = {b[WIDTH-1] ^ sub, b[WIDTH-2:0]};
	end

/*
	logic[3:0] signed_a_mantissa;
	logic[3:0] signed_b_mantissa;
	signed_a_mantissa[3] = sub ? a[6:3] != 0 : a[b:3] == 0;
	signed_b_mantissa[3] = sub ? b[6:3] != 0 : b[b:3] == 0;

	assign signed_mantissa = 
*/

	
endmodule
