/****************************************************************************************
 *	Description: Takes an op code and two registers to perform operations
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

module floatALU #(parameter WIDTH=8, EXP_W=4, MANTISSA_W=3) (
	output logic[WIDTH-1:0] result,
	output logic[2:0] flags, // Carry-out, zero, negative, overflow, parity
	input logic[WIDTH-1:0] a, b,
	input logic[3:0] op, // Allow for 16 operations. Suggested: +,-,*,/,>,<,>=,<=,
	input logic cin; // carry-in flag from previous ALU op
	);

endmodule
