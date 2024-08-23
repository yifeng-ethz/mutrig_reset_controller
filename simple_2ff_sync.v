/*
* Copyright 2019 Tomas Brabec
* 
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
* 
*     http://www.apache.org/licenses/LICENSE-2.0
*     
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

module simple_2ff_sync (a,q,ck_src,ck_tgt);
input a, ck_src, ck_tgt;
output q;
wire n1, n2;
dffrx1 src(.CK(ck_src),.D(a),.RB(1'b1),.Q(n1));
dffrx1 st0(.CK(ck_tgt),.D(n1),.RB(1'b1),.Q(n2));
dffrx1 st1(.CK(ck_tgt),.D(n2),.RB(1'b1),.Q(q));
endmodule

module circ_cdc (a,b,p,q,rdyA,rdyB,ackA,ackB,clkA,clkB);
input a;
input b;
output p;
output q;
input clkA;
input clkB;
input rdyA,ackB;
output rdyB,ackA;

wire n1,n2,n3,n4;

wire clkA_i;
wire clkb_i;

bufx1 B1(.A(clkA),.Y(clkA_i));
bufx4 B2(.A(clkB),.Y(clkB_i));

dffrx1 FF1A(.CK(clkA_i),.D(a),.RB(1'b1),.Q(n1));
dffrx1 FF2A(.CK(clkA_i),.D(b),.RB(1'b1),.Q(n2));

mux2x1 G1(.D0(n1),.D1(p),.S(rdyB),.Y(n3));
mux2x1 G2(.D0(n2),.D1(q),.S(rdyB),.Y(n4));

dffrx1 FF1B(.CK(clkB_i),.D(n3),.RB(1'b1),.Q(p));
dffrx1 FF2B(.CK(clkB_i),.D(n4),.RB(1'b1),.Q(q));

sync cdc_rdy(.ck_src(clkA_i), .ck_tgt(clkB_i), .a(rdyA), .q(rdyB));
sync cdc_ack(.ck_src(clkB_i), .ck_tgt(clkA_i), .a(ackB), .q(ackA));
endmodule 
