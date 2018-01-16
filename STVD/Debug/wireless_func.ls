   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  18                     .const:	section	.text
  19  0000               L3_ak77dspCRAM:
  20  0000 b4            	dc.b	180
  21  0001 00            	dc.b	0
  22  0002 00            	dc.b	0
  23  0003 20            	dc.b	32
  24  0004 00            	dc.b	0
  25  0005 00            	dc.b	0
  26  0006 7f            	dc.b	127
  27  0007 fc            	dc.b	252
  28  0008 00            	dc.b	0
  29  0009 4b            	dc.b	75
  30  000a 24            	dc.b	36
  31  000b 00            	dc.b	0
  32  000c 7f            	dc.b	127
  33  000d ff            	dc.b	255
  34  000e 00            	dc.b	0
  35  000f 54            	dc.b	84
  36  0010 4f            	dc.b	79
  37  0011 00            	dc.b	0
  38  0012 00            	dc.b	0
  39  0013 00            	dc.b	0
  40  0014 00            	dc.b	0
  41  0015 78            	dc.b	120
  42  0016 00            	dc.b	0
  43  0017 00            	dc.b	0
  44  0018 7f            	dc.b	127
  45  0019 d2            	dc.b	210
  46  001a 00            	dc.b	0
  47  001b 46            	dc.b	70
  48  001c a8            	dc.b	168
  49  001d 00            	dc.b	0
  50  001e 00            	dc.b	0
  51  001f 00            	dc.b	0
  52  0020 00            	dc.b	0
  53  0021 7d            	dc.b	125
  54  0022 63            	dc.b	99
  55  0023 00            	dc.b	0
  56  0024 21            	dc.b	33
  57  0025 f6            	dc.b	246
  58  0026 00            	dc.b	0
  59  0027 7f            	dc.b	127
  60  0028 bb            	dc.b	187
  61  0029 00            	dc.b	0
  62  002a 70            	dc.b	112
  63  002b 09            	dc.b	9
  64  002c 00            	dc.b	0
  65  002d               L5_ak77dspORAM:
  66  002d b2            	dc.b	178
  67  002e 00            	dc.b	0
  68  002f 00            	dc.b	0
 109                     	switch	.data
 110  0000               _Wireless_State:
 111  0000 00            	dc.b	0
 112  0001               _prev_charge_status:
 113  0001 63            	dc.b	99
 114  0002               _factory_test_flag:
 115  0002 00            	dc.b	0
 157                     ; 22 void System_PowerOff(void)
 157                     ; 23 {
 159                     	switch	.text
 160  0000               _System_PowerOff:
 162  0000 5208          	subw	sp,#8
 163       00000008      OFST:	set	8
 166                     ; 25     tx_buff[0]=0x88;
 168  0002 a688          	ld	a,#136
 169  0004 6b01          	ld	(OFST-7,sp),a
 170                     ; 26     I2C_8052_Write_Buf(tx_buff,8);
 172  0006 ae0008        	ldw	x,#8
 173  0009 89            	pushw	x
 174  000a 96            	ldw	x,sp
 175  000b 1c0003        	addw	x,#OFST-5
 176  000e cd0000        	call	_I2C_8052_Write_Buf
 178  0011 85            	popw	x
 179                     ; 27 }
 182  0012 5b08          	addw	sp,#8
 183  0014 81            	ret	
 220                     ; 28 void Notification_PowerOff(void)
 220                     ; 29 {
 221                     	switch	.text
 222  0015               _Notification_PowerOff:
 224  0015 5208          	subw	sp,#8
 225       00000008      OFST:	set	8
 228                     ; 31     tx_buff[0]=0xAA;
 230  0017 a6aa          	ld	a,#170
 231  0019 6b01          	ld	(OFST-7,sp),a
 232                     ; 32     tx_buff[1]=0x01;
 234  001b a601          	ld	a,#1
 235  001d 6b02          	ld	(OFST-6,sp),a
 236                     ; 33     tx_buff[2]=0x02;
 238  001f 4c            	inc	a
 239  0020 6b03          	ld	(OFST-5,sp),a
 240                     ; 34     I2C_8052_Write_Buf(tx_buff,8);
 242  0022 ae0008        	ldw	x,#8
 243  0025 89            	pushw	x
 244  0026 96            	ldw	x,sp
 245  0027 1c0003        	addw	x,#OFST-5
 246  002a cd0000        	call	_I2C_8052_Write_Buf
 248  002d 85            	popw	x
 249                     ; 35 }
 252  002e 5b08          	addw	sp,#8
 253  0030 81            	ret	
 291                     ; 37 void Change_to_Strereo_mode(void)
 291                     ; 38 {
 292                     	switch	.text
 293  0031               _Change_to_Strereo_mode:
 295  0031 5208          	subw	sp,#8
 296       00000008      OFST:	set	8
 299                     ; 40     tx_buff[0]=0x08;
 301  0033 a608          	ld	a,#8
 302  0035 6b01          	ld	(OFST-7,sp),a
 303                     ; 41     I2C_8052_Write_Buf(tx_buff,8);
 305  0037 ae0008        	ldw	x,#8
 306  003a 89            	pushw	x
 307  003b 96            	ldw	x,sp
 308  003c 1c0003        	addw	x,#OFST-5
 309  003f cd0000        	call	_I2C_8052_Write_Buf
 311  0042 85            	popw	x
 312                     ; 43     Wireless_Write_SOD_ConectCode();  //0805
 314  0043 cd02f0        	call	_Wireless_Write_SOD_ConectCode
 316                     ; 44 }
 319  0046 5b08          	addw	sp,#8
 320  0048 81            	ret	
 357                     ; 45 void Ask_Wireless_Rx_Version(void)
 357                     ; 46 {
 358                     	switch	.text
 359  0049               _Ask_Wireless_Rx_Version:
 361  0049 5208          	subw	sp,#8
 362       00000008      OFST:	set	8
 365                     ; 48     tx_buff[0]=0xcc;
 367  004b a6cc          	ld	a,#204
 368  004d 6b01          	ld	(OFST-7,sp),a
 369                     ; 49     I2C_8052_Write_Buf(tx_buff,8);
 371  004f ae0008        	ldw	x,#8
 372  0052 89            	pushw	x
 373  0053 96            	ldw	x,sp
 374  0054 1c0003        	addw	x,#OFST-5
 375  0057 cd0000        	call	_I2C_8052_Write_Buf
 377  005a 85            	popw	x
 378                     ; 50 }
 381  005b 5b08          	addw	sp,#8
 382  005d 81            	ret	
 426                     ; 53 void info_Wireless_Rx_BT_state(u8 bt_sod)
 426                     ; 54 {
 427                     	switch	.text
 428  005e               _info_Wireless_Rx_BT_state:
 430  005e 88            	push	a
 431  005f 5208          	subw	sp,#8
 432       00000008      OFST:	set	8
 435                     ; 56     tx_buff[0]=0x0A;
 437  0061 a60a          	ld	a,#10
 438  0063 6b01          	ld	(OFST-7,sp),a
 439                     ; 57     tx_buff[1]=bt_sod;
 441  0065 7b09          	ld	a,(OFST+1,sp)
 442  0067 6b02          	ld	(OFST-6,sp),a
 443                     ; 58     I2C_8052_Write_Buf(tx_buff,8);
 445  0069 ae0008        	ldw	x,#8
 446  006c 89            	pushw	x
 447  006d 96            	ldw	x,sp
 448  006e 1c0003        	addw	x,#OFST-5
 449  0071 cd0000        	call	_I2C_8052_Write_Buf
 451  0074 85            	popw	x
 452                     ; 59 }
 455  0075 5b09          	addw	sp,#9
 456  0077 81            	ret	
 494                     ; 62 void info_Stereo_Wireless_Rx_OFF(void)
 494                     ; 63 {
 495                     	switch	.text
 496  0078               _info_Stereo_Wireless_Rx_OFF:
 498  0078 5208          	subw	sp,#8
 499       00000008      OFST:	set	8
 502                     ; 65     tx_buff[0]=0x04;
 504  007a a604          	ld	a,#4
 505  007c 6b01          	ld	(OFST-7,sp),a
 506                     ; 66     tx_buff[1]=0x00;
 508  007e 0f02          	clr	(OFST-6,sp)
 509                     ; 67     tx_buff[2]=0x03;
 511  0080 a603          	ld	a,#3
 512  0082 6b03          	ld	(OFST-5,sp),a
 513                     ; 68     I2C_8052_Write_Buf(tx_buff,8);
 515  0084 ae0008        	ldw	x,#8
 516  0087 89            	pushw	x
 517  0088 96            	ldw	x,sp
 518  0089 1c0003        	addw	x,#OFST-5
 519  008c cd0000        	call	_I2C_8052_Write_Buf
 521  008f 85            	popw	x
 522                     ; 69     Wait_For_mSec(200);
 524  0090 ae00c8        	ldw	x,#200
 525  0093 cd0000        	call	_Wait_For_mSec
 527                     ; 70 }
 530  0096 5b08          	addw	sp,#8
 531  0098 81            	ret	
 576                     ; 72 void info_Stereo_Wireless_Rx_mute_OFF(u8 mute)
 576                     ; 73 {
 577                     	switch	.text
 578  0099               _info_Stereo_Wireless_Rx_mute_OFF:
 580  0099 88            	push	a
 581  009a 5208          	subw	sp,#8
 582       00000008      OFST:	set	8
 585                     ; 75     tx_buff[0]=0x02;
 587  009c a602          	ld	a,#2
 588  009e 6b01          	ld	(OFST-7,sp),a
 589                     ; 76     tx_buff[1]=mute;
 591  00a0 7b09          	ld	a,(OFST+1,sp)
 592  00a2 6b02          	ld	(OFST-6,sp),a
 593                     ; 77     tx_buff[2]=mute;
 595  00a4 6b03          	ld	(OFST-5,sp),a
 596                     ; 78     I2C_8052_Write_Buf(tx_buff,8);
 598  00a6 ae0008        	ldw	x,#8
 599  00a9 89            	pushw	x
 600  00aa 96            	ldw	x,sp
 601  00ab 1c0003        	addw	x,#OFST-5
 602  00ae cd0000        	call	_I2C_8052_Write_Buf
 604  00b1 85            	popw	x
 605                     ; 79     Wait_For_mSec(100);
 607  00b2 ae0064        	ldw	x,#100
 608  00b5 cd0000        	call	_Wait_For_mSec
 610                     ; 80 }
 613  00b8 5b09          	addw	sp,#9
 614  00ba 81            	ret	
 658                     ; 83 void info_Tx_Wireless_Sod_BT_mode(u8 ON_OFF)
 658                     ; 84 {
 659                     	switch	.text
 660  00bb               _info_Tx_Wireless_Sod_BT_mode:
 662  00bb 88            	push	a
 663  00bc 5208          	subw	sp,#8
 664       00000008      OFST:	set	8
 667                     ; 87     tx_buff[0]=0xDD;
 669  00be a6dd          	ld	a,#221
 670  00c0 6b01          	ld	(OFST-7,sp),a
 671                     ; 88     tx_buff[1]=ON_OFF;
 673  00c2 7b09          	ld	a,(OFST+1,sp)
 674  00c4 6b02          	ld	(OFST-6,sp),a
 675                     ; 89     I2C_8052_Write_Buf(tx_buff,8);
 677  00c6 ae0008        	ldw	x,#8
 678  00c9 89            	pushw	x
 679  00ca 96            	ldw	x,sp
 680  00cb 1c0003        	addw	x,#OFST-5
 681  00ce cd0000        	call	_I2C_8052_Write_Buf
 683  00d1 85            	popw	x
 684                     ; 91 }
 687  00d2 5b09          	addw	sp,#9
 688  00d4 81            	ret	
 724                     ; 95 void clear_rx_buffuer(void)
 724                     ; 96 {
 725                     	switch	.text
 726  00d5               _clear_rx_buffuer:
 728  00d5 5208          	subw	sp,#8
 729       00000008      OFST:	set	8
 732                     ; 98     tx_buff[0]=0x66;
 734  00d7 a666          	ld	a,#102
 735  00d9 6b01          	ld	(OFST-7,sp),a
 736                     ; 100     if(I2C_8052_Write_Buf(tx_buff,8))
 738  00db ae0008        	ldw	x,#8
 739  00de 89            	pushw	x
 740  00df 96            	ldw	x,sp
 741  00e0 1c0003        	addw	x,#OFST-5
 742  00e3 cd0000        	call	_I2C_8052_Write_Buf
 744  00e6 4d            	tnz	a
 745  00e7 85            	popw	x
 746                     ; 106 }
 749  00e8 5b08          	addw	sp,#8
 750  00ea 81            	ret	
 786                     ; 109 void info_FCC_mode(void)
 786                     ; 110 {
 787                     	switch	.text
 788  00eb               _info_FCC_mode:
 790  00eb 5208          	subw	sp,#8
 791       00000008      OFST:	set	8
 794                     ; 112     tx_buff[0]=0x12;
 796  00ed a612          	ld	a,#18
 797  00ef 6b01          	ld	(OFST-7,sp),a
 798                     ; 113     I2C_8052_Write_Buf(tx_buff,8);
 800  00f1 ae0008        	ldw	x,#8
 801  00f4 89            	pushw	x
 802  00f5 96            	ldw	x,sp
 803  00f6 1c0003        	addw	x,#OFST-5
 804  00f9 cd0000        	call	_I2C_8052_Write_Buf
 806  00fc 85            	popw	x
 807                     ; 114 }
 810  00fd 5b08          	addw	sp,#8
 811  00ff 81            	ret	
 852                     ; 115 void Save_Connect_Code_To_Eeprom(u8 *rx_code)
 852                     ; 116 {
 853                     	switch	.text
 854  0100               _Save_Connect_Code_To_Eeprom:
 856  0100 89            	pushw	x
 857       00000000      OFST:	set	0
 860                     ; 117     FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
 862  0101 4f            	clr	a
 863  0102 cd0000        	call	_FLASH_SetProgrammingTime
 865                     ; 119     FLASH_Unlock(FLASH_MEMTYPE_PROG);
 867  0105 4f            	clr	a
 868  0106 cd0000        	call	_FLASH_Unlock
 870                     ; 120     FLASH_Unlock(FLASH_MEMTYPE_DATA);
 872  0109 a601          	ld	a,#1
 873  010b cd0000        	call	_FLASH_Unlock
 875                     ; 122     FLASH_ProgramByte((0x4000), rx_code[1]);
 877  010e 1e01          	ldw	x,(OFST+1,sp)
 878  0110 e601          	ld	a,(1,x)
 879  0112 88            	push	a
 880  0113 ae4000        	ldw	x,#16384
 881  0116 89            	pushw	x
 882  0117 5f            	clrw	x
 883  0118 89            	pushw	x
 884  0119 cd0000        	call	_FLASH_ProgramByte
 886  011c 5b05          	addw	sp,#5
 887                     ; 124     FLASH_ProgramByte((0x4001), rx_code[2]);
 889  011e 1e01          	ldw	x,(OFST+1,sp)
 890  0120 e602          	ld	a,(2,x)
 891  0122 88            	push	a
 892  0123 ae4001        	ldw	x,#16385
 893  0126 89            	pushw	x
 894  0127 5f            	clrw	x
 895  0128 89            	pushw	x
 896  0129 cd0000        	call	_FLASH_ProgramByte
 898  012c 5b05          	addw	sp,#5
 899                     ; 126     FLASH_ProgramByte((0x4002), rx_code[3]);
 901  012e 1e01          	ldw	x,(OFST+1,sp)
 902  0130 e603          	ld	a,(3,x)
 903  0132 88            	push	a
 904  0133 ae4002        	ldw	x,#16386
 905  0136 89            	pushw	x
 906  0137 5f            	clrw	x
 907  0138 89            	pushw	x
 908  0139 cd0000        	call	_FLASH_ProgramByte
 910  013c 5b05          	addw	sp,#5
 911                     ; 128     FLASH_Lock(FLASH_MEMTYPE_PROG);
 913  013e 4f            	clr	a
 914  013f cd0000        	call	_FLASH_Lock
 916                     ; 129     FLASH_Lock(FLASH_MEMTYPE_DATA);
 918  0142 a601          	ld	a,#1
 919  0144 cd0000        	call	_FLASH_Lock
 921                     ; 131     Wait_For_mSec(200);
 923  0147 ae00c8        	ldw	x,#200
 924  014a cd0000        	call	_Wait_For_mSec
 926                     ; 132 }
 929  014d 85            	popw	x
 930  014e 81            	ret	
 959                     ; 134 void Save_default_Code_To_Eeprom(void)
 959                     ; 135 {
 960                     	switch	.text
 961  014f               _Save_default_Code_To_Eeprom:
 965                     ; 136     FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
 967  014f 4f            	clr	a
 968  0150 cd0000        	call	_FLASH_SetProgrammingTime
 970                     ; 138     FLASH_Unlock(FLASH_MEMTYPE_PROG);
 972  0153 4f            	clr	a
 973  0154 cd0000        	call	_FLASH_Unlock
 975                     ; 139     FLASH_Unlock(FLASH_MEMTYPE_DATA);
 977  0157 a601          	ld	a,#1
 978  0159 cd0000        	call	_FLASH_Unlock
 980                     ; 142     FLASH_ProgramByte((0x4000), 0xE6);
 982  015c 4be6          	push	#230
 983  015e ae4000        	ldw	x,#16384
 984  0161 89            	pushw	x
 985  0162 5f            	clrw	x
 986  0163 89            	pushw	x
 987  0164 cd0000        	call	_FLASH_ProgramByte
 989  0167 5b05          	addw	sp,#5
 990                     ; 144     FLASH_ProgramByte((0x4001), 0x33);
 992  0169 4b33          	push	#51
 993  016b ae4001        	ldw	x,#16385
 994  016e 89            	pushw	x
 995  016f 5f            	clrw	x
 996  0170 89            	pushw	x
 997  0171 cd0000        	call	_FLASH_ProgramByte
 999  0174 5b05          	addw	sp,#5
1000                     ; 146     FLASH_ProgramByte((0x4002), 0xE6);
1002  0176 4be6          	push	#230
1003  0178 ae4002        	ldw	x,#16386
1004  017b 89            	pushw	x
1005  017c 5f            	clrw	x
1006  017d 89            	pushw	x
1007  017e cd0000        	call	_FLASH_ProgramByte
1009  0181 5b05          	addw	sp,#5
1010                     ; 147     FLASH_Lock(FLASH_MEMTYPE_PROG);
1012  0183 4f            	clr	a
1013  0184 cd0000        	call	_FLASH_Lock
1015                     ; 148     FLASH_Lock(FLASH_MEMTYPE_DATA);
1017  0187 a601          	ld	a,#1
1018  0189 cd0000        	call	_FLASH_Lock
1020                     ; 150     Wait_For_mSec(100);
1022  018c ae0064        	ldw	x,#100
1024                     ; 151 }
1027  018f cc0000        	jp	_Wait_For_mSec
1086                     ; 154 bool Connect_Code_Compare(u8 *rx_code)
1086                     ; 155 {
1087                     	switch	.text
1088  0192               _Connect_Code_Compare:
1090  0192 89            	pushw	x
1091       00000000      OFST:	set	0
1094                     ; 158     if((FLASH_ReadByte(0x4000)!=rx_code[1]) ||(FLASH_ReadByte(0x4001)!=rx_code[2]) ||(FLASH_ReadByte(0x4002)!=rx_code[3]))
1096  0193 ae4000        	ldw	x,#16384
1097  0196 89            	pushw	x
1098  0197 5f            	clrw	x
1099  0198 89            	pushw	x
1100  0199 cd0000        	call	_FLASH_ReadByte
1102  019c 5b04          	addw	sp,#4
1103  019e 1e01          	ldw	x,(OFST+1,sp)
1104  01a0 e101          	cp	a,(1,x)
1105  01a2 2652          	jrne	L543
1107  01a4 ae4001        	ldw	x,#16385
1108  01a7 89            	pushw	x
1109  01a8 5f            	clrw	x
1110  01a9 89            	pushw	x
1111  01aa cd0000        	call	_FLASH_ReadByte
1113  01ad 5b04          	addw	sp,#4
1114  01af 1e01          	ldw	x,(OFST+1,sp)
1115  01b1 e102          	cp	a,(2,x)
1116  01b3 2641          	jrne	L543
1118  01b5 ae4002        	ldw	x,#16386
1119  01b8 89            	pushw	x
1120  01b9 5f            	clrw	x
1121  01ba 89            	pushw	x
1122  01bb cd0000        	call	_FLASH_ReadByte
1124  01be 5b04          	addw	sp,#4
1125  01c0 1e01          	ldw	x,(OFST+1,sp)
1126  01c2 e103          	cp	a,(3,x)
1127                     ; 159         return TRUE;
1129  01c4 2630          	jrne	L543
1130                     ; 160     if((FLASH_ReadByte(0x4000)!=coco_buffer[1]) ||(FLASH_ReadByte(0x4001)!=coco_buffer[2]) ||(FLASH_ReadByte(0x4002)!=coco_buffer[3]))
1132  01c6 ae4000        	ldw	x,#16384
1133  01c9 89            	pushw	x
1134  01ca 5f            	clrw	x
1135  01cb 89            	pushw	x
1136  01cc cd0000        	call	_FLASH_ReadByte
1138  01cf 5b04          	addw	sp,#4
1139  01d1 c10009        	cp	a,_coco_buffer+1
1140  01d4 2620          	jrne	L543
1142  01d6 ae4001        	ldw	x,#16385
1143  01d9 89            	pushw	x
1144  01da 5f            	clrw	x
1145  01db 89            	pushw	x
1146  01dc cd0000        	call	_FLASH_ReadByte
1148  01df 5b04          	addw	sp,#4
1149  01e1 c1000a        	cp	a,_coco_buffer+2
1150  01e4 2610          	jrne	L543
1152  01e6 ae4002        	ldw	x,#16386
1153  01e9 89            	pushw	x
1154  01ea 5f            	clrw	x
1155  01eb 89            	pushw	x
1156  01ec cd0000        	call	_FLASH_ReadByte
1158  01ef 5b04          	addw	sp,#4
1159  01f1 c1000b        	cp	a,_coco_buffer+3
1160  01f4 2704          	jreq	L343
1161  01f6               L543:
1162                     ; 161         return TRUE;
1165  01f6 a601          	ld	a,#1
1167  01f8               L051:
1169  01f8 85            	popw	x
1170  01f9 81            	ret	
1171  01fa               L343:
1172                     ; 165     return FALSE;
1174  01fa 4f            	clr	a
1176  01fb 20fb          	jra	L051
1226                     ; 168 void Wireless_Write_ConectCode(void)
1226                     ; 169 {
1227                     	switch	.text
1228  01fd               _Wireless_Write_ConectCode:
1230  01fd 5209          	subw	sp,#9
1231       00000009      OFST:	set	9
1234                     ; 170     u8 checksum=0;
1236                     ; 172     if((rx_buff[1]==0xff)&&(rx_buff[2]==0xff)&&(rx_buff[3]==0xff))
1238  01ff c60001        	ld	a,_rx_buff+1
1239  0202 4c            	inc	a
1240  0203 260c          	jrne	L173
1242  0205 c60002        	ld	a,_rx_buff+2
1243  0208 4c            	inc	a
1244  0209 2606          	jrne	L173
1246  020b c60003        	ld	a,_rx_buff+3
1247  020e 4c            	inc	a
1248  020f 2711          	jreq	L202
1249                     ; 174         return;
1251  0211               L173:
1252                     ; 176     if((rx_buff[1]==0x00)&&(rx_buff[2]==0x00)&&(rx_buff[3]==0x00))
1254  0211 c60001        	ld	a,_rx_buff+1
1255  0214 260f          	jrne	L373
1257  0216 725d0002      	tnz	_rx_buff+2
1258  021a 2609          	jrne	L373
1260  021c 725d0003      	tnz	_rx_buff+3
1261  0220 2603          	jrne	L373
1262                     ; 178         return;
1263  0222               L202:
1266  0222 5b09          	addw	sp,#9
1267  0224 81            	ret	
1268  0225               L373:
1269                     ; 180     if((rx_buff[1]=='p')&&(rx_buff[2]=='p')&&(rx_buff[3]=='p'))
1271  0225 a170          	cp	a,#112
1272  0227 260e          	jrne	L573
1274  0229 c60002        	ld	a,_rx_buff+2
1275  022c a170          	cp	a,#112
1276  022e 2607          	jrne	L573
1278  0230 c60003        	ld	a,_rx_buff+3
1279  0233 a170          	cp	a,#112
1280  0235 27eb          	jreq	L202
1281                     ; 182         return;
1283  0237               L573:
1284                     ; 184     if((rx_buff[1]=='w')&&(rx_buff[2]=='r')&&(rx_buff[3]=='o'))
1286  0237 c60001        	ld	a,_rx_buff+1
1287  023a a177          	cp	a,#119
1288  023c 266c          	jrne	L773
1290  023e c60002        	ld	a,_rx_buff+2
1291  0241 a172          	cp	a,#114
1292  0243 2665          	jrne	L773
1294  0245 c60003        	ld	a,_rx_buff+3
1295  0248 a16f          	cp	a,#111
1296  024a 265e          	jrne	L773
1297                     ; 186         if(rx_buff[4]=='n')
1299  024c c60004        	ld	a,_rx_buff+4
1300  024f a16e          	cp	a,#110
1301  0251 262a          	jrne	L104
1302                     ; 188             standby_charge_flag=0;
1304  0253 725f0000      	clr	_standby_charge_flag
1305                     ; 189             Batt_16v_SW(ON);
1307  0257 4b80          	push	#128
1308  0259 ae500f        	ldw	x,#20495
1309  025c cd0000        	call	_GPIO_WriteHigh
1311  025f 84            	pop	a
1312                     ; 190             System_Standby(ON);
1314  0260 4b08          	push	#8
1315  0262 ae500a        	ldw	x,#20490
1316  0265 cd0000        	call	_GPIO_WriteHigh
1318  0268 84            	pop	a
1319                     ; 191             AMP_MUTE(OFF);
1322  0269 4b80          	push	#128
1323  026b ae5014        	ldw	x,#20500
1324  026e cd0000        	call	_GPIO_WriteHigh
1326  0271 84            	pop	a
1327                     ; 192             CHARGE_EN(OFF);
1330  0272 4b40          	push	#64
1331  0274 ae5000        	ldw	x,#20480
1332  0277 cd0000        	call	_GPIO_WriteHigh
1334  027a               LC002:
1335  027a 84            	pop	a
1337  027b 20a5          	jra	L202
1338  027d               L104:
1339                     ; 194         else if(rx_buff[4]=='f')
1341  027d a166          	cp	a,#102
1342  027f 26a1          	jrne	L202
1343                     ; 196             standby_charge_flag=1;
1345  0281 35010000      	mov	_standby_charge_flag,#1
1346                     ; 198             AMP_MUTE(ON);
1348  0285 4b80          	push	#128
1349  0287 ae5014        	ldw	x,#20500
1350  028a cd0000        	call	_GPIO_WriteLow
1352  028d 84            	pop	a
1353                     ; 199             Batt_16v_SW(OFF);
1356  028e 4b80          	push	#128
1357  0290 ae500f        	ldw	x,#20495
1358  0293 cd0000        	call	_GPIO_WriteLow
1360  0296 84            	pop	a
1361                     ; 200             System_Standby(OFF);
1363  0297 4b08          	push	#8
1364  0299 ae500a        	ldw	x,#20490
1365  029c cd0000        	call	_GPIO_WriteLow
1367  029f 84            	pop	a
1368                     ; 202             CHARGE_EN(ON);
1371  02a0 4b40          	push	#64
1372  02a2 ae5000        	ldw	x,#20480
1373  02a5 cd0000        	call	_GPIO_WriteLow
1375                     ; 205         return;
1377  02a8 20d0          	jp	LC002
1378  02aa               L773:
1379                     ; 207     checksum=(rx_buff[1]+rx_buff[2]+rx_buff[3]);
1381  02aa c60001        	ld	a,_rx_buff+1
1382  02ad cb0002        	add	a,_rx_buff+2
1383  02b0 cb0003        	add	a,_rx_buff+3
1384  02b3 6b01          	ld	(OFST-8,sp),a
1385                     ; 209     if(checksum==rx_buff[4])
1387  02b5 c10004        	cp	a,_rx_buff+4
1388  02b8 2703cc0222    	jrne	L202
1389                     ; 211         tx_buff[0]=0xBB;
1391  02bd a6bb          	ld	a,#187
1392  02bf 6b02          	ld	(OFST-7,sp),a
1393                     ; 212         tx_buff[1]=rx_buff[1];
1395  02c1 c60001        	ld	a,_rx_buff+1
1396  02c4 6b03          	ld	(OFST-6,sp),a
1397                     ; 213         tx_buff[2]=rx_buff[2];
1399  02c6 c60002        	ld	a,_rx_buff+2
1400  02c9 6b04          	ld	(OFST-5,sp),a
1401                     ; 214         tx_buff[3]=rx_buff[3];
1403  02cb c60003        	ld	a,_rx_buff+3
1404  02ce 6b05          	ld	(OFST-4,sp),a
1405                     ; 221         if(Connect_Code_Compare(tx_buff))
1407  02d0 96            	ldw	x,sp
1408  02d1 1c0002        	addw	x,#OFST-7
1409  02d4 cd0192        	call	_Connect_Code_Compare
1411  02d7 4d            	tnz	a
1412  02d8 27e0          	jreq	L202
1413                     ; 223             I2C_8052_Write_Buf(tx_buff,8);
1415  02da ae0008        	ldw	x,#8
1416  02dd 89            	pushw	x
1417  02de 96            	ldw	x,sp
1418  02df 1c0004        	addw	x,#OFST-5
1419  02e2 cd0000        	call	_I2C_8052_Write_Buf
1421  02e5 85            	popw	x
1422                     ; 224             Save_Connect_Code_To_Eeprom(tx_buff);
1424  02e6 96            	ldw	x,sp
1425  02e7 1c0002        	addw	x,#OFST-7
1426  02ea cd0100        	call	_Save_Connect_Code_To_Eeprom
1428                     ; 229 }
1430  02ed cc0222        	jra	L202
1491                     ; 232 void Wireless_Write_SOD_ConectCode(void)
1491                     ; 233 {
1492                     	switch	.text
1493  02f0               _Wireless_Write_SOD_ConectCode:
1495  02f0 520b          	subw	sp,#11
1496       0000000b      OFST:	set	11
1499                     ; 236     FLASH_Unlock(FLASH_MEMTYPE_PROG);
1501  02f2 4f            	clr	a
1502  02f3 cd0000        	call	_FLASH_Unlock
1504                     ; 237     FLASH_Unlock(FLASH_MEMTYPE_DATA);
1506  02f6 a601          	ld	a,#1
1507  02f8 cd0000        	call	_FLASH_Unlock
1509                     ; 238     X=FLASH_ReadByte(0x4000);
1511  02fb ae4000        	ldw	x,#16384
1512  02fe 89            	pushw	x
1513  02ff 5f            	clrw	x
1514  0300 89            	pushw	x
1515  0301 cd0000        	call	_FLASH_ReadByte
1517  0304 5b04          	addw	sp,#4
1518  0306 6b01          	ld	(OFST-10,sp),a
1519                     ; 239     Y=FLASH_ReadByte(0x4001);
1521  0308 ae4001        	ldw	x,#16385
1522  030b 89            	pushw	x
1523  030c 5f            	clrw	x
1524  030d 89            	pushw	x
1525  030e cd0000        	call	_FLASH_ReadByte
1527  0311 5b04          	addw	sp,#4
1528  0313 6b02          	ld	(OFST-9,sp),a
1529                     ; 240     Z=FLASH_ReadByte(0x4002);
1531  0315 ae4002        	ldw	x,#16386
1532  0318 89            	pushw	x
1533  0319 5f            	clrw	x
1534  031a 89            	pushw	x
1535  031b cd0000        	call	_FLASH_ReadByte
1537  031e 5b04          	addw	sp,#4
1538  0320 6b03          	ld	(OFST-8,sp),a
1539                     ; 241     FLASH_Lock(FLASH_MEMTYPE_PROG);
1541  0322 4f            	clr	a
1542  0323 cd0000        	call	_FLASH_Lock
1544                     ; 242     FLASH_Lock(FLASH_MEMTYPE_DATA);
1546  0326 a601          	ld	a,#1
1547  0328 cd0000        	call	_FLASH_Lock
1549                     ; 243     tx_buff[0]=0xBB;
1551  032b a6bb          	ld	a,#187
1552  032d 6b04          	ld	(OFST-7,sp),a
1553                     ; 244     tx_buff[1]=(X+1);
1555  032f 7b01          	ld	a,(OFST-10,sp)
1556  0331 4c            	inc	a
1557  0332 6b05          	ld	(OFST-6,sp),a
1558                     ; 245     tx_buff[2]=(Y+2);
1560  0334 7b02          	ld	a,(OFST-9,sp)
1561  0336 ab02          	add	a,#2
1562  0338 6b06          	ld	(OFST-5,sp),a
1563                     ; 246     tx_buff[3]=(Z+3);
1565  033a 7b03          	ld	a,(OFST-8,sp)
1566  033c ab03          	add	a,#3
1567  033e 6b07          	ld	(OFST-4,sp),a
1568                     ; 247     I2C_8052_Write_Buf(tx_buff,8);
1570  0340 ae0008        	ldw	x,#8
1571  0343 89            	pushw	x
1572  0344 96            	ldw	x,sp
1573  0345 1c0006        	addw	x,#OFST-5
1574  0348 cd0000        	call	_I2C_8052_Write_Buf
1576  034b 85            	popw	x
1577                     ; 249 }
1580  034c 5b0b          	addw	sp,#11
1581  034e 81            	ret	
1644                     ; 251 void Wireless_Write_main_ConectCode(void)
1644                     ; 252 {
1645                     	switch	.text
1646  034f               _Wireless_Write_main_ConectCode:
1648  034f 520b          	subw	sp,#11
1649       0000000b      OFST:	set	11
1652                     ; 256     FLASH_Unlock(FLASH_MEMTYPE_DATA);
1654  0351 a601          	ld	a,#1
1655  0353 cd0000        	call	_FLASH_Unlock
1657                     ; 257     X=FLASH_ReadByte(0x4000);
1659  0356 ae4000        	ldw	x,#16384
1660  0359 89            	pushw	x
1661  035a 5f            	clrw	x
1662  035b 89            	pushw	x
1663  035c cd0000        	call	_FLASH_ReadByte
1665  035f 5b04          	addw	sp,#4
1666  0361 6b01          	ld	(OFST-10,sp),a
1667                     ; 258     Y=FLASH_ReadByte(0x4001);
1669  0363 ae4001        	ldw	x,#16385
1670  0366 89            	pushw	x
1671  0367 5f            	clrw	x
1672  0368 89            	pushw	x
1673  0369 cd0000        	call	_FLASH_ReadByte
1675  036c 5b04          	addw	sp,#4
1676  036e 6b02          	ld	(OFST-9,sp),a
1677                     ; 259     Z=FLASH_ReadByte(0x4002);
1679  0370 ae4002        	ldw	x,#16386
1680  0373 89            	pushw	x
1681  0374 5f            	clrw	x
1682  0375 89            	pushw	x
1683  0376 cd0000        	call	_FLASH_ReadByte
1685  0379 5b04          	addw	sp,#4
1686  037b 6b03          	ld	(OFST-8,sp),a
1687                     ; 261     FLASH_Lock(FLASH_MEMTYPE_DATA);
1689  037d a601          	ld	a,#1
1690  037f cd0000        	call	_FLASH_Lock
1692                     ; 262     if((X==0)&&(Y==0)&&(Z==0))
1694  0382 7b01          	ld	a,(OFST-10,sp)
1695  0384 2617          	jrne	L364
1697  0386 7b02          	ld	a,(OFST-9,sp)
1698  0388 2613          	jrne	L364
1700  038a 7b03          	ld	a,(OFST-8,sp)
1701  038c 260f          	jrne	L364
1702                     ; 264         X=0xE6;
1704  038e a6e6          	ld	a,#230
1705  0390 6b01          	ld	(OFST-10,sp),a
1706                     ; 265         Y=0x33;
1708  0392 a633          	ld	a,#51
1709  0394 6b02          	ld	(OFST-9,sp),a
1710                     ; 266         Z=0xE6;
1712  0396 a6e6          	ld	a,#230
1713  0398 6b03          	ld	(OFST-8,sp),a
1714                     ; 267         Save_default_Code_To_Eeprom();
1716  039a cd014f        	call	_Save_default_Code_To_Eeprom
1718  039d               L364:
1719                     ; 269     tx_buff[0]=0xBB;
1721  039d a6bb          	ld	a,#187
1722  039f 6b04          	ld	(OFST-7,sp),a
1723                     ; 270     tx_buff[1]=X;
1725  03a1 7b01          	ld	a,(OFST-10,sp)
1726  03a3 6b05          	ld	(OFST-6,sp),a
1727                     ; 271     tx_buff[2]=Y;
1729  03a5 7b02          	ld	a,(OFST-9,sp)
1730  03a7 6b06          	ld	(OFST-5,sp),a
1731                     ; 272     tx_buff[3]=Z;
1733  03a9 7b03          	ld	a,(OFST-8,sp)
1734  03ab 6b07          	ld	(OFST-4,sp),a
1735                     ; 273     I2C_8052_Write_Buf(tx_buff,8);
1737  03ad ae0008        	ldw	x,#8
1738  03b0 89            	pushw	x
1739  03b1 96            	ldw	x,sp
1740  03b2 1c0006        	addw	x,#OFST-5
1741  03b5 cd0000        	call	_I2C_8052_Write_Buf
1743  03b8 85            	popw	x
1744                     ; 274     Wait_For_mSec(100);
1746  03b9 ae0064        	ldw	x,#100
1747  03bc cd0000        	call	_Wait_For_mSec
1749                     ; 275 }
1752  03bf 5b0b          	addw	sp,#11
1753  03c1 81            	ret	
1797                     ; 277 void Tx_Info(u8 *str,u8 ver)
1797                     ; 278 {
1798                     	switch	.text
1799  03c2               _Tx_Info:
1801  03c2 89            	pushw	x
1802       00000000      OFST:	set	0
1805                     ; 279     myputstr(str);
1807  03c3 cd0000        	call	_myputstr
1809                     ; 280     myputc(ver/10+0x30);
1811  03c6 7b05          	ld	a,(OFST+5,sp)
1812  03c8 5f            	clrw	x
1813  03c9 97            	ld	xl,a
1814  03ca a60a          	ld	a,#10
1815  03cc cd0000        	call	c_sdivx
1817  03cf 1c0030        	addw	x,#48
1818  03d2 9f            	ld	a,xl
1819  03d3 cd0000        	call	_myputc
1821                     ; 281     myputc(ver%10+0x30);
1823  03d6 7b05          	ld	a,(OFST+5,sp)
1824  03d8 5f            	clrw	x
1825  03d9 97            	ld	xl,a
1826  03da a60a          	ld	a,#10
1827  03dc cd0000        	call	c_smodx
1829  03df 1c0030        	addw	x,#48
1830  03e2 9f            	ld	a,xl
1831  03e3 cd0000        	call	_myputc
1833                     ; 282     myputstr("\r\n");
1835  03e6 ae0099        	ldw	x,#L505
1836  03e9 cd0000        	call	_myputstr
1838                     ; 283 }
1841  03ec 85            	popw	x
1842  03ed 81            	ret	
1881                     ; 285 char  HexToASCII(unsigned char  data_hex)
1881                     ; 286 {
1882                     	switch	.text
1883  03ee               _HexToASCII:
1885  03ee 88            	push	a
1886       00000001      OFST:	set	1
1889                     ; 288     ASCII_Data=data_hex & 0x0F;
1891  03ef a40f          	and	a,#15
1892  03f1 6b01          	ld	(OFST+0,sp),a
1893                     ; 289     if(ASCII_Data<10)
1895  03f3 a10a          	cp	a,#10
1896  03f5 2404          	jruge	L525
1897                     ; 290         ASCII_Data=ASCII_Data+0x30; //¡®0--9¡¯
1899  03f7 ab30          	add	a,#48
1901  03f9 2002          	jra	L725
1902  03fb               L525:
1903                     ; 292         ASCII_Data=ASCII_Data+0x37;       //¡®A--F¡¯
1905  03fb ab37          	add	a,#55
1906  03fd               L725:
1907                     ; 293     return ASCII_Data;
1911  03fd 5b01          	addw	sp,#1
1912  03ff 81            	ret	
1979                     ; 296 void HexGroupToString(char *OutStrBuffer, unsigned char *InHexBuffer, unsigned int HexLength)
1979                     ; 297 {
1980                     	switch	.text
1981  0400               _HexGroupToString:
1983  0400 89            	pushw	x
1984  0401 5204          	subw	sp,#4
1985       00000004      OFST:	set	4
1988                     ; 298     unsigned int i, k=0;
1990  0403 5f            	clrw	x
1991  0404 1f01          	ldw	(OFST-3,sp),x
1992                     ; 299     for(i=0; i<HexLength; i++)
1994  0406 202c          	jra	L565
1995  0408               L165:
1996                     ; 301         OutStrBuffer[k++]=HexToASCII((InHexBuffer[i]>>4)&0x0F);
1998  0408 1e09          	ldw	x,(OFST+5,sp)
1999  040a 72fb03        	addw	x,(OFST-1,sp)
2000  040d f6            	ld	a,(x)
2001  040e 4e            	swap	a
2002  040f a40f          	and	a,#15
2003  0411 addb          	call	_HexToASCII
2005  0413 1e01          	ldw	x,(OFST-3,sp)
2006  0415 5c            	incw	x
2007  0416 1f01          	ldw	(OFST-3,sp),x
2008  0418 5a            	decw	x
2009  0419 72fb05        	addw	x,(OFST+1,sp)
2010  041c f7            	ld	(x),a
2011                     ; 302         OutStrBuffer[k++]=HexToASCII(InHexBuffer[i]&0x0F);
2013  041d 1e09          	ldw	x,(OFST+5,sp)
2014  041f 72fb03        	addw	x,(OFST-1,sp)
2015  0422 f6            	ld	a,(x)
2016  0423 a40f          	and	a,#15
2017  0425 adc7          	call	_HexToASCII
2019  0427 1e01          	ldw	x,(OFST-3,sp)
2020  0429 5c            	incw	x
2021  042a 1f01          	ldw	(OFST-3,sp),x
2022  042c 5a            	decw	x
2023  042d 72fb05        	addw	x,(OFST+1,sp)
2024  0430 f7            	ld	(x),a
2025                     ; 299     for(i=0; i<HexLength; i++)
2027  0431 1e03          	ldw	x,(OFST-1,sp)
2028  0433 5c            	incw	x
2029  0434               L565:
2031  0434 1f03          	ldw	(OFST-1,sp),x
2034  0436 130b          	cpw	x,(OFST+7,sp)
2035  0438 25ce          	jrult	L165
2036                     ; 304     OutStrBuffer[k]='\0';
2038  043a 1e05          	ldw	x,(OFST+1,sp)
2039  043c 72fb01        	addw	x,(OFST-3,sp)
2040                     ; 305 }
2043  043f 5b06          	addw	sp,#6
2044  0441 7f            	clr	(x)
2045  0442 81            	ret	
2082                     ; 350 void Send_Surr_Info(void)
2082                     ; 351 {
2083                     	switch	.text
2084  0443               _Send_Surr_Info:
2088                     ; 352     factory_test_flag=1;
2090  0443 35010002      	mov	_factory_test_flag,#1
2091                     ; 353     UART2_DeInit();
2093  0447 cd0000        	call	_UART2_DeInit
2095                     ; 354     initUart(UART2_MODE_TXRX_ENABLE);
2097  044a a60c          	ld	a,#12
2098  044c cd0000        	call	_initUart
2100                     ; 355     Wait_For_mSec(10);
2102  044f ae000a        	ldw	x,#10
2103  0452 cd0000        	call	_Wait_For_mSec
2105                     ; 356     Ask_Wireless_Rx_Version();
2107  0455 cd0049        	call	_Ask_Wireless_Rx_Version
2109                     ; 357     myputstr("***************************?\r\n");
2111  0458 ae007a        	ldw	x,#L106
2112  045b cd0000        	call	_myputstr
2114                     ; 358     myputstr("Harman JBL 5.1:\r\n");
2116  045e ae0068        	ldw	x,#L306
2117  0461 cd0000        	call	_myputstr
2119                     ; 359     Tx_Info("MCU:",MCU_VER);
2121  0464 4b17          	push	#23
2122  0466 ae0063        	ldw	x,#L506
2123  0469 cd03c2        	call	_Tx_Info
2125  046c 84            	pop	a
2126                     ; 360     Tx_Info("BAT:", voltage);
2128  046d 3b0001        	push	_voltage+1
2129  0470 ae005e        	ldw	x,#L706
2130  0473 cd03c2        	call	_Tx_Info
2132  0476 ae0052        	ldw	x,#L116
2133  0479 84            	pop	a
2134                     ; 361     myputstr("pair code: ");
2136  047a cd0000        	call	_myputstr
2138                     ; 363     HexGroupToString(coco_char_buffer,coco_buffer,4);
2140  047d ae0004        	ldw	x,#4
2141  0480 89            	pushw	x
2142  0481 ae0008        	ldw	x,#_coco_buffer
2143  0484 89            	pushw	x
2144  0485 ae0000        	ldw	x,#_coco_char_buffer
2145  0488 cd0400        	call	_HexGroupToString
2147  048b 5b04          	addw	sp,#4
2148                     ; 365     myputc(coco_char_buffer[2]);
2150  048d c60002        	ld	a,_coco_char_buffer+2
2151  0490 cd0000        	call	_myputc
2153                     ; 366     myputc(coco_char_buffer[3]);
2155  0493 c60003        	ld	a,_coco_char_buffer+3
2156  0496 cd0000        	call	_myputc
2158                     ; 367     myputc(coco_char_buffer[4]);
2160  0499 c60004        	ld	a,_coco_char_buffer+4
2161  049c cd0000        	call	_myputc
2163                     ; 368     myputc(coco_char_buffer[5]);
2165  049f c60005        	ld	a,_coco_char_buffer+5
2166  04a2 cd0000        	call	_myputc
2168                     ; 369     myputc(coco_char_buffer[6]);
2170  04a5 c60006        	ld	a,_coco_char_buffer+6
2171  04a8 cd0000        	call	_myputc
2173                     ; 370     myputc(coco_char_buffer[7]);
2175  04ab c60007        	ld	a,_coco_char_buffer+7
2176  04ae cd0000        	call	_myputc
2178                     ; 371     memset(coco_char_buffer,0xff,sizeof(coco_char_buffer));
2180  04b1 a6ff          	ld	a,#255
2181  04b3 ae0008        	ldw	x,#8
2182  04b6               L433:
2183  04b6 d7ffff        	ld	(_coco_char_buffer-1,x),a
2184  04b9 5a            	decw	x
2185  04ba 26fa          	jrne	L433
2186                     ; 372     myputstr("\r\n");
2188  04bc ae0099        	ldw	x,#L505
2189  04bf cd0000        	call	_myputstr
2191                     ; 373     led_test_time=7;
2193  04c2 35070000      	mov	_led_test_time,#7
2194                     ; 376 }
2197  04c6 81            	ret	
2324                     	switch	.const
2325  0030               L214:
2326  0030 04fe          	dc.w	L316
2327  0032 0510          	dc.w	L516
2328  0034 0691          	dc.w	L327
2329  0036 0691          	dc.w	L327
2330  0038 0691          	dc.w	L327
2331  003a 060b          	dc.w	L126
2332  003c 0618          	dc.w	L326
2333  003e 063a          	dc.w	L526
2334  0040 063a          	dc.w	L526
2335  0042 063a          	dc.w	L526
2336  0044 063d          	dc.w	L336
2337  0046 0642          	dc.w	L536
2338  0048 0645          	dc.w	L146
2339  004a 064c          	dc.w	L346
2340  004c 0679          	dc.w	L546
2341                     ; 377 void Wireless_RxInfoProcess(void)
2341                     ; 378 {
2342                     	switch	.text
2343  04c7               _Wireless_RxInfoProcess:
2345  04c7 5209          	subw	sp,#9
2346       00000009      OFST:	set	9
2349                     ; 380     u8  data=0x30;
2351  04c9 a630          	ld	a,#48
2352  04cb 6b09          	ld	(OFST+0,sp),a
2353                     ; 382     if(i2c_buzy_flag==1)
2355  04cd c60000        	ld	a,_i2c_buzy_flag
2356  04d0 4a            	dec	a
2357  04d1 270d          	jreq	L414
2358                     ; 384         return;
2360                     ; 387     if(WIRELESS_INT_PIN_STATUS)
2362  04d3 4b08          	push	#8
2363  04d5 ae5014        	ldw	x,#20500
2364  04d8 cd0000        	call	_GPIO_ReadInputPin
2366  04db 5b01          	addw	sp,#1
2367  04dd 4d            	tnz	a
2368  04de 2703          	jreq	L317
2369                     ; 388         return ;
2370  04e0               L414:
2373  04e0 5b09          	addw	sp,#9
2374  04e2 81            	ret	
2375  04e3               L317:
2376                     ; 389     if(I2C_8052_Read_Buf(8))
2378  04e3 ae0008        	ldw	x,#8
2379  04e6 cd0000        	call	_I2C_8052_Read_Buf
2381  04e9 4d            	tnz	a
2382  04ea 26f4          	jrne	L414
2383                     ; 392         return;
2385                     ; 394     if(RX_Data_recv_array[0]==0xAE)
2387  04ec c60000        	ld	a,_RX_Data_recv_array
2388  04ef a1ae          	cp	a,#174
2389  04f1 27ed          	jreq	L414
2390                     ; 397         return ;
2392                     ; 399     switch(RX_Data_recv_array[0])
2395                     ; 627     default:
2395                     ; 628         break;
2396  04f3 a10f          	cp	a,#15
2397  04f5 24e9          	jruge	L414
2398  04f7 5f            	clrw	x
2399  04f8 97            	ld	xl,a
2400  04f9 58            	sllw	x
2401  04fa de0030        	ldw	x,(L214,x)
2402  04fd fc            	jp	(x)
2403  04fe               L316:
2404                     ; 404         tx_buff[0]=0x66;
2406  04fe a666          	ld	a,#102
2407  0500 6b01          	ld	(OFST-8,sp),a
2408                     ; 405         I2C_8052_Write_Buf(tx_buff,8);
2410  0502 ae0008        	ldw	x,#8
2411  0505 89            	pushw	x
2412  0506 96            	ldw	x,sp
2413  0507 1c0003        	addw	x,#OFST-6
2414  050a cd0000        	call	_I2C_8052_Write_Buf
2416  050d 85            	popw	x
2417                     ; 407     break;
2419  050e 20d0          	jra	L414
2420  0510               L516:
2421                     ; 408     case _Info_Wireless_Connect_Staus:
2421                     ; 409 
2421                     ; 410 
2421                     ; 411 
2421                     ; 412 
2421                     ; 413 
2421                     ; 414         if(!disp_timer)
2423  0510 c60000        	ld	a,_disp_timer
2424  0513 267c          	jrne	L527
2425                     ; 416             if(RX_Data_recv_array[1])
2427  0515 c60001        	ld	a,_RX_Data_recv_array+1
2428  0518 274f          	jreq	L727
2429                     ; 418                 if(RX_Data_recv_array[1]==1)
2431  051a 4a            	dec	a
2432  051b 2637          	jrne	L137
2433                     ; 420                     Wireless_State=_Wireless_ConnectTx;
2435  051d 35010000      	mov	_Wireless_State,#1
2436                     ; 422                     charge_changeto_disconent_flag=0;
2438  0521 c70000        	ld	_charge_changeto_disconent_flag,a
2439                     ; 423                     connect_to_disconnecttime=0;
2441  0524 c70000        	ld	_connect_to_disconnecttime,a
2442                     ; 424                     if(standby_flag==1)
2444  0527 c60000        	ld	a,_standby_flag
2445  052a 4a            	dec	a
2446  052b 2627          	jrne	L137
2447                     ; 426                         standby_flag=0;
2449  052d c70000        	ld	_standby_flag,a
2450                     ; 427                         standby_flag_SOD=0;
2452  0530 c70000        	ld	_standby_flag_SOD,a
2453                     ; 428                         System_Standby(ON);
2455  0533 4b08          	push	#8
2456  0535 ae500a        	ldw	x,#20490
2457  0538 cd0000        	call	_GPIO_WriteHigh
2459  053b 84            	pop	a
2460                     ; 430                         if(Link_State==Link_None)
2463  053c c60000        	ld	a,_Link_State
2464  053f 4a            	dec	a
2465  0540 2609          	jrne	L537
2466                     ; 431                             Batt_16v_SW(ON);
2468  0542 4b80          	push	#128
2469  0544 ae500f        	ldw	x,#20495
2470  0547 cd0000        	call	_GPIO_WriteHigh
2472  054a 84            	pop	a
2473  054b               L537:
2474                     ; 433                         AMP_MUTE(OFF);
2476  054b 4b80          	push	#128
2477  054d ae5014        	ldw	x,#20500
2478  0550 cd0000        	call	_GPIO_WriteHigh
2480  0553 84            	pop	a
2482  0554               L137:
2483                     ; 437                 if(RX_Data_recv_array[1]==2)
2485  0554 c60001        	ld	a,_RX_Data_recv_array+1
2486  0557 a102          	cp	a,#2
2487  0559 2604          	jrne	L737
2488                     ; 439                     Wireless_State=_Wireless_Paring;
2490  055b 35020000      	mov	_Wireless_State,#2
2491  055f               L737:
2492                     ; 442                 if(RX_Data_recv_array[1]==3)
2494  055f a103          	cp	a,#3
2495  0561 262e          	jrne	L527
2496                     ; 444                     Wireless_State=_Wireless_standby;
2498  0563 35030000      	mov	_Wireless_State,#3
2499  0567 2028          	jra	L527
2500  0569               L727:
2501                     ; 449                 connect_to_disconnecttime++;
2503  0569 725c0000      	inc	_connect_to_disconnecttime
2504                     ; 450                 if( connect_to_disconnecttime>3)
2506  056d c60000        	ld	a,_connect_to_disconnecttime
2507  0570 a104          	cp	a,#4
2508  0572 251d          	jrult	L527
2509                     ; 452                     if((Wireless_State==_Wireless_ConnectTx)&&(disp_index==Disp_USB_charge))
2511  0574 c60000        	ld	a,_Wireless_State
2512  0577 4a            	dec	a
2513  0578 260f          	jrne	L747
2515  057a c60000        	ld	a,_disp_index
2516  057d a111          	cp	a,#17
2517  057f 2608          	jrne	L747
2518                     ; 455                         disp_index=Disp_Dis_Connect;
2520  0581 35010000      	mov	_disp_index,#1
2521                     ; 456                         charge_changeto_disconent_flag=1;
2523  0585 35010000      	mov	_charge_changeto_disconent_flag,#1
2524  0589               L747:
2525                     ; 458                     Wireless_State=_Wireless_None_Connect;
2527  0589 725f0000      	clr	_Wireless_State
2528                     ; 459                     connect_to_disconnecttime=0;
2530  058d 725f0000      	clr	_connect_to_disconnecttime
2531  0591               L527:
2532                     ; 468         if(LR_Flag==0)
2534  0591 c60000        	ld	a,_LR_Flag
2535  0594 2605          	jrne	L157
2536                     ; 470             LR_Flag=RX_Data_recv_array[3];
2538  0596 5500030000    	mov	_LR_Flag,_RX_Data_recv_array+3
2539  059b               L157:
2540                     ; 473         if( Wireless_State!=_Wireless_Paring)
2542  059b c60000        	ld	a,_Wireless_State
2543  059e a102          	cp	a,#2
2544  05a0 2603cc04e0    	jreq	L414
2545                     ; 475             if(RX_Data_recv_array[4]||RX_Data_recv_array[5]||RX_Data_recv_array[6])
2547  05a5 c60004        	ld	a,_RX_Data_recv_array+4
2548  05a8 260a          	jrne	L757
2550  05aa c60005        	ld	a,_RX_Data_recv_array+5
2551  05ad 2605          	jrne	L757
2553  05af c60006        	ld	a,_RX_Data_recv_array+6
2554  05b2 27ee          	jreq	L414
2555  05b4               L757:
2556                     ; 477                 coco_buffer[1]=RX_Data_recv_array[6];
2558  05b4 5500060009    	mov	_coco_buffer+1,_RX_Data_recv_array+6
2559                     ; 478                 coco_buffer[2]=RX_Data_recv_array[5];
2561  05b9 550005000a    	mov	_coco_buffer+2,_RX_Data_recv_array+5
2562                     ; 479                 coco_buffer[3]=RX_Data_recv_array[4];
2564                     ; 481                 if((FLASH_ReadByte(0x4000)!=coco_buffer[1]) ||(FLASH_ReadByte(0x4001)!=coco_buffer[2]) ||(FLASH_ReadByte(0x4002)!=coco_buffer[3]))
2566  05be ae4000        	ldw	x,#16384
2567  05c1 550004000b    	mov	_coco_buffer+3,_RX_Data_recv_array+4
2568  05c6 89            	pushw	x
2569  05c7 5f            	clrw	x
2570  05c8 89            	pushw	x
2571  05c9 cd0000        	call	_FLASH_ReadByte
2573  05cc 5b04          	addw	sp,#4
2574  05ce c10009        	cp	a,_coco_buffer+1
2575  05d1 2620          	jrne	L567
2577  05d3 ae4001        	ldw	x,#16385
2578  05d6 89            	pushw	x
2579  05d7 5f            	clrw	x
2580  05d8 89            	pushw	x
2581  05d9 cd0000        	call	_FLASH_ReadByte
2583  05dc 5b04          	addw	sp,#4
2584  05de c1000a        	cp	a,_coco_buffer+2
2585  05e1 2610          	jrne	L567
2587  05e3 ae4002        	ldw	x,#16386
2588  05e6 89            	pushw	x
2589  05e7 5f            	clrw	x
2590  05e8 89            	pushw	x
2591  05e9 cd0000        	call	_FLASH_ReadByte
2593  05ec 5b04          	addw	sp,#4
2594  05ee c1000b        	cp	a,_coco_buffer+3
2595  05f1 27af          	jreq	L414
2596  05f3               L567:
2597                     ; 483                     if(!pairing_flag)
2599  05f3 c60000        	ld	a,_pairing_flag
2600  05f6 2606          	jrne	L177
2601                     ; 484                         Wireless_Write_main_ConectCode();
2603  05f8 cd034f        	call	_Wireless_Write_main_ConectCode
2606  05fb cc04e0        	jra	L414
2607  05fe               L177:
2608                     ; 487                         Save_Connect_Code_To_Eeprom(coco_buffer);
2610  05fe ae0008        	ldw	x,#_coco_buffer
2611  0601 cd0100        	call	_Save_Connect_Code_To_Eeprom
2613                     ; 488                         pairing_flag=0;
2615  0604 725f0000      	clr	_pairing_flag
2616  0608 cc04e0        	jra	L414
2617                     ; 496     case _Info_Tx_Ver:
2617                     ; 497         //dputstr("\r\n Tx Version");
2617                     ; 498         break;
2619  060b               L126:
2620                     ; 499     case _Info_Quanity:
2620                     ; 500         standby_flag_SOD=0;
2622  060b 725f0000      	clr	_standby_flag_SOD
2623                     ; 501         Report_Charge_Status(flag_charge_ing);
2625  060f c60000        	ld	a,_flag_charge_ing
2626  0612 cd0694        	call	_Report_Charge_Status
2628                     ; 502         break;
2630  0615 cc04e0        	jra	L414
2631  0618               L326:
2632                     ; 505         if(factory_test_flag)
2634  0618 c60002        	ld	a,_factory_test_flag
2635  061b 27f8          	jreq	L414
2636                     ; 509             rx_ver_h=RX_Data_recv_array[1];
2638  061d c60001        	ld	a,_RX_Data_recv_array+1
2639  0620 6b08          	ld	(OFST-1,sp),a
2640                     ; 510             Tx_Info("RX:",rx_ver_h);
2642  0622 88            	push	a
2643  0623 ae004e        	ldw	x,#L777
2644  0626 cd03c2        	call	_Tx_Info
2646  0629 350e0000      	mov	_disp_index,#14
2647  062d 84            	pop	a
2648                     ; 511             disp_index=Disp_Test_MODE;
2650                     ; 512             UART2_DeInit();
2652  062e cd0000        	call	_UART2_DeInit
2654                     ; 513             initUart(UART2_MODE_RX_ENABLE);
2656  0631 a608          	ld	a,#8
2657  0633 cd0000        	call	_initUart
2659                     ; 514             factory_test_flag=0;
2661  0636 725f0002      	clr	_factory_test_flag
2662  063a               L526:
2663                     ; 523         vol=RX_Data_recv_array[1];
2665                     ; 527     break;
2667                     ; 532         mute=RX_Data_recv_array[1];
2669                     ; 536     break;
2671                     ; 543         drc=RX_Data_recv_array[1];
2673                     ; 548     break;
2675  063a cc04e0        	jra	L414
2676  063d               L336:
2677                     ; 556         vol=RX_Data_recv_array[1];
2679                     ; 557         mute=RX_Data_recv_array[2];
2681                     ; 558         drc=RX_Data_recv_array[3];
2683                     ; 563         Report_Charge_Status(flag_charge_ing);
2685  063d c60000        	ld	a,_flag_charge_ing
2686  0640 ad52          	call	_Report_Charge_Status
2688                     ; 568     break;
2690  0642               L536:
2691                     ; 574         filter=RX_Data_recv_array[1];
2693                     ; 577     break;
2695  0642 cc04e0        	jra	L414
2696                     ; 579     case 0xFB:
2696                     ; 580 
2696                     ; 581         break;
2698  0645               L146:
2699                     ; 583     case _Info_wireless_standby:
2699                     ; 584         //   AMP_MUTE(ON);
2699                     ; 585         //   Power_off_ready(ON);
2699                     ; 586         Wireless_State= _Wireless_standby;
2701  0645 35030000      	mov	_Wireless_State,#3
2702                     ; 587         break;
2704  0649 cc04e0        	jra	L414
2705  064c               L346:
2706                     ; 589     case _Info_wireless_poweroff:
2706                     ; 590         if(RX_Data_recv_array[1]==0xAB)
2708  064c c60001        	ld	a,_RX_Data_recv_array+1
2709  064f a1ab          	cp	a,#171
2710  0651 2615          	jrne	L1001
2711                     ; 592             AMP_MUTE(ON);
2713  0653 4b80          	push	#128
2714  0655 ae5014        	ldw	x,#20500
2715  0658 cd0000        	call	_GPIO_WriteLow
2717  065b 84            	pop	a
2718                     ; 593             Power_off_ready(ON);
2721  065c 4b08          	push	#8
2722  065e ae500f        	ldw	x,#20495
2723  0661 cd0000        	call	_GPIO_WriteLow
2725  0664 84            	pop	a
2726  0665 c60001        	ld	a,_RX_Data_recv_array+1
2727  0668               L1001:
2728                     ; 596         if(RX_Data_recv_array[1]==0x0B)
2730  0668 a10b          	cp	a,#11
2731  066a 26dd          	jrne	L414
2732                     ; 598             if(Link_State==Link_None)
2734  066c c60000        	ld	a,_Link_State
2735  066f 4a            	dec	a
2736  0670 26d7          	jrne	L414
2737                     ; 606                 standby_flag_SOD=1;
2739  0672 35010000      	mov	_standby_flag_SOD,#1
2740  0676 cc04e0        	jra	L414
2741  0679               L546:
2742                     ; 617     case _Info_wireless_poweron:
2742                     ; 618         if(RX_Data_recv_array[1]==0xAA)
2744  0679 c60001        	ld	a,_RX_Data_recv_array+1
2745  067c a1aa          	cp	a,#170
2746  067e 26f6          	jrne	L414
2747                     ; 620             if(Link_State==Link_On)
2749  0680 c60000        	ld	a,_Link_State
2750  0683 26f1          	jrne	L414
2751                     ; 622                 standby_charge_flag=0;
2753  0685 c70000        	ld	_standby_charge_flag,a
2754                     ; 623                 CHARGE_EN(OFF);
2756  0688 4b40          	push	#64
2757  068a ae5000        	ldw	x,#20480
2758  068d cd0000        	call	_GPIO_WriteHigh
2760  0690 84            	pop	a
2761                     ; 627     default:
2761                     ; 628         break;
2763  0691               L327:
2764                     ; 630 }
2766  0691 cc04e0        	jra	L414
2812                     ; 631 void Report_Charge_Status(u8 charge)
2812                     ; 632 {
2813                     	switch	.text
2814  0694               _Report_Charge_Status:
2816  0694 88            	push	a
2817  0695 5208          	subw	sp,#8
2818       00000008      OFST:	set	8
2821                     ; 635     data_buff[0]=Battery_Quanity;
2823  0697 a6fe          	ld	a,#254
2824  0699 6b01          	ld	(OFST-7,sp),a
2825                     ; 636     data_buff[1]=battery_quantity;
2827  069b c60000        	ld	a,_battery_quantity
2828  069e 6b02          	ld	(OFST-6,sp),a
2829                     ; 637     data_buff[2]=charge;
2831  06a0 7b09          	ld	a,(OFST+1,sp)
2832  06a2 6b03          	ld	(OFST-5,sp),a
2833                     ; 638     data_buff[3]=MCU_VER;
2835  06a4 a617          	ld	a,#23
2836  06a6 6b04          	ld	(OFST-4,sp),a
2837                     ; 639     data_buff[4]=voltage;
2839  06a8 c60001        	ld	a,_voltage+1
2840  06ab 6b05          	ld	(OFST-3,sp),a
2841                     ; 640     data_buff[5]=voltage;
2843  06ad 6b06          	ld	(OFST-2,sp),a
2844                     ; 641     data_buff[6]=0x88;
2846  06af a688          	ld	a,#136
2847  06b1 6b07          	ld	(OFST-1,sp),a
2848                     ; 642     I2C_8052_Write_Buf(data_buff,8);
2850  06b3 ae0008        	ldw	x,#8
2851  06b6 89            	pushw	x
2852  06b7 96            	ldw	x,sp
2853  06b8 1c0003        	addw	x,#OFST-5
2854  06bb cd0000        	call	_I2C_8052_Write_Buf
2856  06be 85            	popw	x
2857                     ; 644 }
2860  06bf 5b09          	addw	sp,#9
2861  06c1 81            	ret	
2864                     	switch	.data
2865  0003               L3301_prev_link_status:
2866  0003 02            	dc.b	2
2935                     ; 646 void Link_MainUnit_State_Process(void)
2935                     ; 647 {
2936                     	switch	.text
2937  06c2               _Link_MainUnit_State_Process:
2941                     ; 649     if(prev_link_status!=Link_State)
2943  06c2 c60003        	ld	a,L3301_prev_link_status
2944  06c5 c10000        	cp	a,_Link_State
2945  06c8 275d          	jreq	L3701
2946                     ; 651         if((Link_State==Link_None)&&(prev_link_status==Link_On))  //Undocking
2948  06ca c60000        	ld	a,_Link_State
2949  06cd 4a            	dec	a
2950  06ce 263f          	jrne	L5701
2952  06d0 c60003        	ld	a,L3301_prev_link_status
2953  06d3 263a          	jrne	L5701
2954                     ; 654             battery_quantity=Electric_Full;
2956  06d5 35050000      	mov	_battery_quantity,#5
2957                     ; 658             Batt_16v_SW(ON);
2959  06d9 4b80          	push	#128
2960  06db ae500f        	ldw	x,#20495
2961  06de cd0000        	call	_GPIO_WriteHigh
2963  06e1 84            	pop	a
2964                     ; 659             System_Standby(ON);
2966  06e2 4b08          	push	#8
2967  06e4 ae500a        	ldw	x,#20490
2968  06e7 cd0000        	call	_GPIO_WriteHigh
2970  06ea 84            	pop	a
2971                     ; 660             AMP_MUTE(OFF);
2974  06eb 4b80          	push	#128
2975  06ed ae5014        	ldw	x,#20500
2976  06f0 cd0000        	call	_GPIO_WriteHigh
2978  06f3 84            	pop	a
2979                     ; 663             if((battery_quantity==Electric_Empty)||(battery_quantity==Electric_Low))
2982  06f4 c60000        	ld	a,_battery_quantity
2983  06f7 a102          	cp	a,#2
2984  06f9 2704          	jreq	L1011
2986  06fb a103          	cp	a,#3
2987  06fd 260a          	jrne	L7701
2988  06ff               L1011:
2989                     ; 665                 disp_index=Disp_Battery_Low_UnDocking;
2991  06ff 35080000      	mov	_disp_index,#8
2993  0703               L3011:
2994                     ; 673             disp_timer=2;
2996  0703 35020000      	mov	_disp_timer,#2
2997  0707 2006          	jra	L5701
2998  0709               L7701:
2999                     ; 670                 disp_index=Disp_pre_Separate;
3001  0709 35130000      	mov	_disp_index,#19
3002  070d 20f4          	jra	L3011
3003  070f               L5701:
3004                     ; 675         if((Link_State==Link_On)&&(prev_link_status==Link_None))  //Docking
3006  070f c60000        	ld	a,_Link_State
3007  0712 260e          	jrne	L5011
3009  0714 c60003        	ld	a,L3301_prev_link_status
3010  0717 4a            	dec	a
3011  0718 2608          	jrne	L5011
3012                     ; 677             disp_index=Disp_Docking;
3014  071a 35030000      	mov	_disp_index,#3
3015                     ; 678             disp_timer=2;
3017  071e 35020000      	mov	_disp_timer,#2
3018  0722               L5011:
3019                     ; 680         prev_link_status=Link_State;
3021  0722 5500000003    	mov	L3301_prev_link_status,_Link_State
3022  0727               L3701:
3023                     ; 683     if(disp_timer)        return;
3025  0727 c60000        	ld	a,_disp_timer
3026  072a 2701          	jreq	L7011
3030  072c 81            	ret	
3031  072d               L7011:
3032                     ; 685     switch(Link_State)
3034  072d c60000        	ld	a,_Link_State
3036                     ; 742     default:
3036                     ; 743         break;
3037  0730 2741          	jreq	L7301
3038  0732 4a            	dec	a
3039  0733 266a          	jrne	L3111
3040                     ; 687     case Link_None:
3040                     ; 688         if(battery_charge==_Charge_Ing)
3042  0735 c60000        	ld	a,_battery_charge
3043  0738 4a            	dec	a
3044  0739 2605          	jrne	L5111
3045                     ; 692             disp_index=Disp_USB_charge;
3047  073b 35110000      	mov	_disp_index,#17
3050  073f 81            	ret	
3051  0740               L5111:
3052                     ; 696         else  if((battery_quantity==Electric_Empty)||(battery_quantity==Electric_Need_Cut))
3054  0740 c60000        	ld	a,_battery_quantity
3055  0743 a102          	cp	a,#2
3056  0745 2704          	jreq	L3211
3058  0747 a101          	cp	a,#1
3059  0749 260c          	jrne	L1211
3060  074b               L3211:
3061                     ; 698             if(disp_index!=Disp_Battery_Empty)
3063  074b c60000        	ld	a,_disp_index
3064  074e a10b          	cp	a,#11
3065  0750 274d          	jreq	L3111
3066                     ; 699                 disp_index=Disp_Battery_Empty;
3068  0752 350b0000      	mov	_disp_index,#11
3070  0756 81            	ret	
3071  0757               L1211:
3072                     ; 701         else  if(battery_quantity==Electric_Low)
3074  0757 a103          	cp	a,#3
3075  0759 260c          	jrne	L1311
3076                     ; 705             if(disp_index!=Disp_Battery_Empty)
3078  075b c60000        	ld	a,_disp_index
3079  075e a10b          	cp	a,#11
3080  0760 273d          	jreq	L3111
3081                     ; 706                 disp_index=Disp_Battery_Empty;
3083  0762 350b0000      	mov	_disp_index,#11
3085  0766 81            	ret	
3086  0767               L1311:
3087                     ; 714             if(disp_index!=Disp_Separate)
3089  0767 c60000        	ld	a,_disp_index
3090  076a a106          	cp	a,#6
3091  076c 2731          	jreq	L3111
3092                     ; 715                 disp_index=Disp_pre_Separate;
3094  076e 35130000      	mov	_disp_index,#19
3096  0772 81            	ret	
3097  0773               L7301:
3098                     ; 718     case Link_On:
3098                     ; 719 
3098                     ; 720 
3098                     ; 721         if(prev_charge_status!=battery_charge)
3100  0773 c60001        	ld	a,_prev_charge_status
3101  0776 c10000        	cp	a,_battery_charge
3102  0779 2715          	jreq	L1411
3103                     ; 724             if(battery_charge==_Charge_Full)
3105  077b c60000        	ld	a,_battery_charge
3106  077e a102          	cp	a,#2
3107  0780 2608          	jrne	L3411
3108                     ; 726                 disp_index=Disp_Charge_Full;
3110  0782 350d0000      	mov	_disp_index,#13
3111                     ; 727                 disp_timer=10;      //10Second
3113  0786 350a0000      	mov	_disp_timer,#10
3114  078a               L3411:
3115                     ; 729             prev_charge_status=battery_charge;
3117  078a 5500000001    	mov	_prev_charge_status,_battery_charge
3118                     ; 730             break;
3121  078f 81            	ret	
3122  0790               L1411:
3123                     ; 733         if(battery_charge==_Charge_Ing)
3125  0790 c60000        	ld	a,_battery_charge
3126  0793 4a            	dec	a
3127  0794 2605          	jrne	L5411
3128                     ; 735             if(disp_index!=Disp_Charging);
3131                     ; 736             disp_index=Disp_Charging;
3133  0796 35070000      	mov	_disp_index,#7
3136  079a 81            	ret	
3137  079b               L5411:
3138                     ; 740             disp_index=Disp_Separate;
3140  079b 35060000      	mov	_disp_index,#6
3141                     ; 742     default:
3141                     ; 743         break;
3143  079f               L3111:
3144                     ; 745 }
3147  079f 81            	ret	
3177                     ; 748 void Wireless_State_Process(void)
3177                     ; 749 {
3178                     	switch	.text
3179  07a0               _Wireless_State_Process:
3183                     ; 751     switch(Wireless_State)
3185  07a0 c60000        	ld	a,_Wireless_State
3187                     ; 805     default:
3187                     ; 806         break;
3188  07a3 2709          	jreq	L3511
3189  07a5 4a            	dec	a
3190  07a6 2729          	jreq	L5511
3191  07a8 4a            	dec	a
3192  07a9 2729          	jreq	L7511
3193  07ab 4a            	dec	a
3194  07ac 262a          	jrne	L5711
3195  07ae               L3511:
3196                     ; 753     case _Wireless_standby:
3196                     ; 754     case _Wireless_None_Connect:  //Red Led On
3196                     ; 755 
3196                     ; 756 #if 0
3196                     ; 757         //    if((!standby_flag)||(flag_charge_ing)||(Main_Link_Status() ))
3196                     ; 758         if(flag_charge_ing)
3196                     ; 759         {
3196                     ; 760             //disp_index=Disp_Dis_Connect;
3196                     ; 761             disp_index=Disp_USB_charge;
3196                     ; 762         }
3196                     ; 763         else
3196                     ; 764         {
3196                     ; 765             if(!standby_flag)
3196                     ; 766                 disp_index=Disp_Dis_Connect;
3196                     ; 767             else
3196                     ; 768                 disp_index=Disp_standby;
3196                     ; 769         }
3196                     ; 770 #endif
3196                     ; 771         //    if(disp_index==Disp_USB_charge)
3196                     ; 772         //    	{
3196                     ; 773         //	 disp_index=Disp_Dis_Connect;
3196                     ; 774         //	 charge_changeto_disconent_flag=1;
3196                     ; 775         //   	}
3196                     ; 776 
3196                     ; 777 
3196                     ; 778         if(!flag_charge_ing)
3198  07ae c60000        	ld	a,_flag_charge_ing
3199  07b1 2625          	jrne	L5711
3200                     ; 780             if(!standby_flag)
3202  07b3 c60000        	ld	a,_standby_flag
3203  07b6 2614          	jrne	L1021
3204                     ; 783                 if((battery_quantity==Electric_Empty)||(battery_quantity==Electric_Need_Cut))
3206  07b8 c60000        	ld	a,_battery_quantity
3207  07bb a102          	cp	a,#2
3208  07bd 2703          	jreq	L5021
3210  07bf 4a            	dec	a
3211  07c0 2605          	jrne	L3021
3212  07c2               L5021:
3213                     ; 787                     disp_index=Disp_Dis_Connect;
3215  07c2 35010000      	mov	_disp_index,#1
3218  07c6 81            	ret	
3219  07c7               L3021:
3220                     ; 791                     disp_index=Disp_Dis_Connect;
3222  07c7 35010000      	mov	_disp_index,#1
3224  07cb 81            	ret	
3225  07cc               L1021:
3226                     ; 795                 disp_index=Disp_standby;
3228  07cc 35120000      	mov	_disp_index,#18
3230  07d0 81            	ret	
3231  07d1               L5511:
3232                     ; 798     case _Wireless_ConnectTx:
3232                     ; 799         Link_MainUnit_State_Process();
3235                     ; 800         break;
3238  07d1 cc06c2        	jp	_Link_MainUnit_State_Process
3239  07d4               L7511:
3240                     ; 801     case _Wireless_Paring:      //Red Led fast blink
3240                     ; 802         disp_index=Disp_Connecting;
3242  07d4 35020000      	mov	_disp_index,#2
3243                     ; 803         break;
3245                     ; 805     default:
3245                     ; 806         break;
3247  07d8               L5711:
3248                     ; 808 }
3251  07d8 81            	ret	
3290                     ; 814 void  Wireless_Goto_Pairing(void)
3290                     ; 815 {
3291                     	switch	.text
3292  07d9               _Wireless_Goto_Pairing:
3294  07d9 5208          	subw	sp,#8
3295       00000008      OFST:	set	8
3298                     ; 817     tx_buff[0]=0xA1;
3300  07db a6a1          	ld	a,#161
3301  07dd 6b01          	ld	(OFST-7,sp),a
3302                     ; 818     I2C_8052_Write_Buf(tx_buff,8);
3304  07df ae0008        	ldw	x,#8
3305  07e2 89            	pushw	x
3306  07e3 96            	ldw	x,sp
3307  07e4 1c0003        	addw	x,#OFST-5
3308  07e7 cd0000        	call	_I2C_8052_Write_Buf
3310  07ea 35140000      	mov	_b_pwm_value,#20
3311  07ee 85            	popw	x
3312                     ; 820     b_pwm_value=LIGHTLY_4P4;
3314                     ; 821     Wait_For_mSec(1000);
3316  07ef ae03e8        	ldw	x,#1000
3317  07f2 cd0000        	call	_Wait_For_mSec
3319                     ; 822     b_pwm_value=LIGHTLY_0P4;
3321  07f5 725f0000      	clr	_b_pwm_value
3322                     ; 823 }
3325  07f9 5b08          	addw	sp,#8
3326  07fb 81            	ret	
3353                     ; 825 void  Rest_Pairing_Code(void)
3353                     ; 826 {
3354                     	switch	.text
3355  07fc               _Rest_Pairing_Code:
3359                     ; 827     Save_default_Code_To_Eeprom();
3361  07fc cd014f        	call	_Save_default_Code_To_Eeprom
3363                     ; 828     Wireless_Write_main_ConectCode();
3365  07ff cd034f        	call	_Wireless_Write_main_ConectCode
3367                     ; 829     r_pwm_value=LIGHTLY_4P4;
3369  0802 35140000      	mov	_r_pwm_value,#20
3370                     ; 830     Wait_For_mSec(1000);
3372  0806 ae03e8        	ldw	x,#1000
3373  0809 cd0000        	call	_Wait_For_mSec
3375                     ; 831     r_pwm_value=LIGHTLY_0P4;
3377  080c 725f0000      	clr	_r_pwm_value
3378                     ; 833 }
3381  0810 81            	ret	
3476                     	xdef	_HexGroupToString
3477                     	xdef	_HexToASCII
3478                     	xdef	_Tx_Info
3479                     	xdef	_Connect_Code_Compare
3480                     	xdef	_Save_Connect_Code_To_Eeprom
3481                     	xdef	_info_FCC_mode
3482                     	xdef	_factory_test_flag
3483                     	xdef	_prev_charge_status
3484                     	switch	.bss
3485  0000               _coco_char_buffer:
3486  0000 000000000000  	ds.b	8
3487                     	xdef	_coco_char_buffer
3488  0008               _coco_buffer:
3489  0008 00000000      	ds.b	4
3490                     	xdef	_coco_buffer
3491                     	xref	_i2c_buzy_flag
3492                     	xdef	_clear_rx_buffuer
3493                     	xdef	_Rest_Pairing_Code
3494                     	xdef	_Wireless_Goto_Pairing
3495                     	xdef	_info_Stereo_Wireless_Rx_mute_OFF
3496                     	xdef	_info_Tx_Wireless_Sod_BT_mode
3497                     	xdef	_info_Stereo_Wireless_Rx_OFF
3498                     	xdef	_Save_default_Code_To_Eeprom
3499                     	xdef	_info_Wireless_Rx_BT_state
3500                     	xdef	_Wireless_Write_main_ConectCode
3501                     	xdef	_Wireless_Write_SOD_ConectCode
3502                     	xdef	_Change_to_Strereo_mode
3503                     	xdef	_Notification_PowerOff
3504                     	xdef	_Send_Surr_Info
3505                     	xdef	_Ask_Wireless_Rx_Version
3506                     	xdef	_Wireless_Write_ConectCode
3507                     	xdef	_Report_Charge_Status
3508                     	xdef	_System_PowerOff
3509                     	xdef	_Link_MainUnit_State_Process
3510                     	xdef	_Wireless_RxInfoProcess
3511                     	xref	_Link_State
3512                     	xdef	_Wireless_State
3513                     	xref	_I2C_8052_Read_Buf
3514                     	xref	_I2C_8052_Write_Buf
3515                     	xref	_RX_Data_recv_array
3516                     	xref	_b_pwm_value
3517                     	xref	_r_pwm_value
3518                     	xdef	_Wireless_State_Process
3519                     	xref	_disp_timer
3520                     	xref	_disp_index
3521                     	xref	_initUart
3522                     	xref	_rx_buff
3523                     	xref	_voltage
3524                     	xref	_battery_charge
3525                     	xref	_battery_quantity
3526                     	xref	_myputstr
3527                     	xref	_myputc
3528                     	xref	_Wait_For_mSec
3529                     	xref	_standby_flag_SOD
3530                     	xref	_charge_changeto_disconent_flag
3531                     	xref	_standby_charge_flag
3532                     	xref	_connect_to_disconnecttime
3533                     	xref	_led_test_time
3534                     	xref	_pairing_flag
3535                     	xref	_standby_flag
3536                     	xref	_LR_Flag
3537                     	xref	_flag_charge_ing
3538                     	xref	_UART2_DeInit
3539                     	xref	_GPIO_ReadInputPin
3540                     	xref	_GPIO_WriteLow
3541                     	xref	_GPIO_WriteHigh
3542                     	xref	_FLASH_SetProgrammingTime
3543                     	xref	_FLASH_ReadByte
3544                     	xref	_FLASH_ProgramByte
3545                     	xref	_FLASH_Lock
3546                     	xref	_FLASH_Unlock
3547                     	switch	.const
3548  004e               L777:
3549  004e 52583a00      	dc.b	"RX:",0
3550  0052               L116:
3551  0052 706169722063  	dc.b	"pair code: ",0
3552  005e               L706:
3553  005e 4241543a00    	dc.b	"BAT:",0
3554  0063               L506:
3555  0063 4d43553a00    	dc.b	"MCU:",0
3556  0068               L306:
3557  0068 4861726d616e  	dc.b	"Harman JBL 5.1:",13
3558  0078 0a00          	dc.b	10,0
3559  007a               L106:
3560  007a 2a2a2a2a2a2a  	dc.b	"******************"
3561  008c 2a2a2a2a2a2a  	dc.b	"*********?",13
3562  0097 0a00          	dc.b	10,0
3563  0099               L505:
3564  0099 0d0a00        	dc.b	13,10,0
3565                     	xref.b	c_x
3585                     	xref	c_smodx
3586                     	xref	c_sdivx
3587                     	end
