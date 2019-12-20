.title 'DADFF_56ps'

* please include the Nangate cell library properly
.include '<dir>/NangateOpenCellLibrary_PDKv1_3_v2009_07/pre_spice/NangateOpenCellLibrary_pre.sp'
.include '<dir>/NangateOpenCellLibrary_PDKv1_3_v2009_07/technology/models/hspice/tran_models/models_nom/NMOS_VTL.inc'
.include '<dir>/NangateOpenCellLibrary_PDKv1_3_v2009_07/technology/models/hspice/tran_models/models_nom/PMOS_VTL.inc'
.include 'DADFF_56ps.sp'

* typical supply voltage of Nangate45
.param VOLT = 1.10

* DAD-FF
XDADFF 	D CLK Di_1 Di_2 Q QN Qo_1 Qo_2 VDD VSS DADFF_56ps

* input data buffer
XBUF_DAD IN D VDD VSS BUF_X1

* input clock buffer
XCLKBUF CLK_i CLK VDD VSS CLKBUF_X1


VVDD VDD VSS VOLT
VVSS VSS 0 0.0
VCLK CLK_i VSS PULSE ( 0.0 VOLT -1.0n 0.05n 0.05n 3.5n 7.1n )
VD IN VSS PWL( 0n   0.0
+           3n      0.0
+           3.05n   VOLT
+			5n 		VOLT
+			5.05n	0.0
+			6.10n	0.0
+			6.105n	VOLT
+			6.14n	VOLT
+			6.145n	0.0
+			12n		0.0
+			12.05n	VOLT
+           16n     VOLT
+           16.05n  0.0
+           30n     0.0    )




.MEASURE TRAN DADFF_fall_delay TRIG v(XDADFF.n07) VAL=VOLT/2 TD=0 FALL=1 TARG v(XDADFF.n17) VAL=VOLT/2 FALL=1
.MEASURE TRAN DADFF_rise_delay TRIG v(XDADFF.n07) VAL=VOLT/2 TD=0 RISE=1 TARG v(XDADFF.n17) VAL=VOLT/2 RISE=1


.option MEASFORM = 3
.option post = 2
.tran 0.1p 20n 

.end
