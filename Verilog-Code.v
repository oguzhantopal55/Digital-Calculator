module calculator(
  input wire [9:0] number,
  input wire reset,
  input wire enter,
  input wire start,
  input wire add,
  input wire sub,
  input wire mult,
  input wire div,
  output reg err,
  output reg sign,
  output reg regadd,
  output reg regsub,
  output reg regmult,
  output reg regdiv,
  output reg [6:0] display0,
  output reg [6:0] display1,
  output reg [6:0] display2,
  output reg [6:0] display3,
  output reg [6:0] display4,
  output reg [6:0] display5,
  output reg [6:0] display6,
  output reg [6:0] display7,
  output reg [6:0] display8,
  output reg [6:0] display9,
  output reg [6:0] display10,
  output reg [6:0] display11
);
  reg [3:0] d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11;
  reg [15:0] n1, n2, n3;
always @(posedge reset)begin
      display0 <= 7'b1111110;
      display1 <= 7'b1111110;
      display2 <= 7'b1111110;
      display3 <= 7'b1111110;
      display4 <= 7'b1111110;
      display5 <= 7'b1111110;
      display6 <= 7'b1111110;
      display7 <= 7'b1111110;
      display8 <= 7'b1111110;
      display9 <= 7'b1111110;
      display10 <= 7'b1111110;
      display11 <= 7'b1111110;
      regadd <= 0;
      regsub <= 0;
      regmult <= 0;
      regdiv <= 0;
      d0 <= 4'b0;
      d1 <= 4'b0;
      d2 <= 4'b0;
      d3 <= 4'b0;
      d4 <= 4'b0;
      d5 <= 4'b0;
      d6 <= 4'b0;
      d7 <= 4'b0;
      d8 <= 4'b0;
      d9 <= 4'b0;
      d10 <= 4'b0;
      d11 <= 4'b0;
      n1 <= 16'b0;
      n2 <= 16'b0;
      n3 <= 16'b0;
      err <= 0;
      sign <= 0;
end
always @(posedge add or posedge sub or posedge mult or posedge div)begin
	if (add) begin
	regadd <=1;
	end
	else if (sub) begin
	regsub <=1;
	end
	else if (mult) begin
	regmult <=1;
	end
	else if (div) begin
	regdiv <=1;
	end
end
always @(posedge start) begin
     if (regadd == 1 || regsub == 1 || regmult == 1 || regdiv == 1) begin
      display5 <= display4;
      display6 <= display5;
      display7 <= display6;
      d5 <= d4;
      d6 <= d5;
      d7 <= d6;
      case (number)
        10'b0000000001: begin display4 <= 7'b1111110; d4 <= 4'b0000; end
        10'b0000000010: begin display4 <= 7'b0110000; d4 <= 4'b0001; end
        10'b0000000100: begin display4 <= 7'b1101101; d4 <= 4'b0010; end
        10'b0000001000: begin display4 <= 7'b1111001; d4 <= 4'b0011; end
        10'b0000010000: begin display4 <= 7'b0110011; d4 <= 4'b0100; end
        10'b0000100000: begin display4 <= 7'b1011011; d4 <= 4'b0101; end
        10'b0001000000: begin display4 <= 7'b1011111; d4 <= 4'b0110; end
        10'b0010000000: begin display4 <= 7'b1110000; d4 <= 4'b0111; end
        10'b0100000000: begin display4 <= 7'b1111111; d4 <= 4'b1000; end
        10'b1000000000: begin display4 <= 7'b1111011; d4 <= 4'b1001; end
      endcase
    end
    else begin
      display1 <= display0;
      display2 <= display1;
      display3 <= display2;
      d1 <= d0;
      d2 <= d1;
      d3 <= d2;
      case (number)
        10'b0000000001: begin display0 <= 7'b1111110; d0 <= 4'b0000; end
        10'b0000000010: begin display0 <= 7'b0110000; d0 <= 4'b0001; end
        10'b0000000100: begin display0 <= 7'b1101101; d0 <= 4'b0010; end
        10'b0000001000: begin display0 <= 7'b1111001; d0 <= 4'b0011; end
        10'b0000010000: begin display0 <= 7'b0110011; d0 <= 4'b0100; end
        10'b0000100000: begin display0 <= 7'b1011011; d0 <= 4'b0101; end
        10'b0001000000: begin display0 <= 7'b1011111; d0 <= 4'b0110; end
        10'b0010000000: begin display0 <= 7'b1110000; d0 <= 4'b0111; end
        10'b0100000000: begin display0 <= 7'b1111111; d0 <= 4'b1000; end
        10'b1000000000: begin display0 <= 7'b1111011; d0 <= 4'b1001; end
      endcase
end
end
always @(posedge enter) begin
n1 = d0 + 10 * d1 + 100 * d2 + 1000 * d3;
n2 = d4 + 10 * d5 + 100 * d6 + 1000 * d7;
if (n1 >= n2 && regsub == 1) begin
     n3 = n1 - n2;
     d8 = n3 % 10;
     d9 = (n3 % 100) / 10;
     d10 = (n3 % 1000) / 100;
     d11 = (n3 % 10000) / 1000;
     sign = 0;
     end
if (n2 >= n1 && regsub == 1) begin
     n3 = n2 - n1;
     d8 = n3 % 10;
     d9 = (n3 % 100) / 10;
     d10 = (n3 % 1000) / 100;
     d11 = (n3 % 10000) / 1000;
     sign = 1;
     end
if (regadd == 1) begin
     n3 = n1 + n2;
     if (n3 > 9999)begin
	err <= 1;
	n3 = 16'b0;
	end
     d8 = n3 % 10;
     d9 = (n3 % 100) / 10;
     d10 = (n3 % 1000) / 100;
     d11 = (n3 % 10000) / 1000;
     end
if (regmult == 1) begin
     n3 = n1 * n2;
     if (n3 > 9999)begin
	err <= 1;
	n3 = 16'b0;
	end
     d8 = n3 % 10;
     d9 = (n3 % 100) / 10;
     d10 = (n3 % 1000) / 100;
     d11 = (n3 % 10000) / 1000;
     end
if (regdiv == 1 && n2 != 0) begin
     n3 = n1 / n2;
     d8 = n3 % 10;
     d9 = (n3 % 100) / 10;
     d10 = (n3 % 1000) / 100;
     d11 = (n3 % 10000) / 1000; 
     end
if (regdiv == 1 && n2 == 0)begin
     err <= 1;
     end
if (err == 0) begin
	case (d8)
	4'b0000: begin display8 <= 7'b1111110; end
	4'b0001: begin display8 <= 7'b0110000; end
	4'b0010: begin display8 <= 7'b1101101; end
	4'b0011: begin display8 <= 7'b1111001; end
	4'b0100: begin display8 <= 7'b0110011; end
	4'b0101: begin display8 <= 7'b1011011; end
	4'b0110: begin display8 <= 7'b1011111; end
	4'b0111: begin display8 <= 7'b1110000; end
	4'b1000: begin display8 <= 7'b1111111; end
	4'b1001: begin display8 <= 7'b1111011; end
	endcase
        case(d9)
	4'b0000: begin display9 <= 7'b1111110; end
	4'b0001: begin display9 <= 7'b0110000; end
	4'b0010: begin display9 <= 7'b1101101; end
	4'b0011: begin display9 <= 7'b1111001; end
	4'b0100: begin display9 <= 7'b0110011; end
	4'b0101: begin display9 <= 7'b1011011; end
	4'b0110: begin display9 <= 7'b1011111; end
	4'b0111: begin display9 <= 7'b1110000; end
	4'b1000: begin display9 <= 7'b1111111; end
	4'b1001: begin display9 <= 7'b1111011; end
	endcase
        case(d10)
	4'b0000: begin display10 <= 7'b1111110; end
	4'b0001: begin display10 <= 7'b0110000; end
	4'b0010: begin display10 <= 7'b1101101; end
	4'b0011: begin display10 <= 7'b1111001; end
	4'b0100: begin display10 <= 7'b0110011; end
	4'b0101: begin display10 <= 7'b1011011; end
	4'b0110: begin display10 <= 7'b1011111; end
	4'b0111: begin display10 <= 7'b1110000; end
	4'b1000: begin display10 <= 7'b1111111; end
	4'b1001: begin display10 <= 7'b1111011; end
	endcase
        case(d11)
	4'b0000: begin display11 <= 7'b1111110; end
	4'b0001: begin display11 <= 7'b0110000; end
	4'b0010: begin display11 <= 7'b1101101; end
	4'b0011: begin display11 <= 7'b1111001; end
	4'b0100: begin display11 <= 7'b0110011; end
	4'b0101: begin display11 <= 7'b1011011; end
	4'b0110: begin display11 <= 7'b1011111; end
	4'b0111: begin display11 <= 7'b1110000; end
	4'b1000: begin display11 <= 7'b1111111; end
	4'b1001: begin display11 <= 7'b1111011; end
	endcase
end
end
endmodule