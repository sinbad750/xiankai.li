   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  18                     	switch	.data
  19  0000               _i2c_error:
  20  0000 00            	dc.b	0
  21  0001               _Tpa5050:
  22  0001 00            	dc.b	0
  51                     ; 22 u8 Wireless_i2c_Addr(void)
  51                     ; 23 {
  53                     	switch	.text
  54  0000               _Wireless_i2c_Addr:
  58                     ; 24    return  I2C_WIRELESS_ADDR ;
  60  0000 a680          	ld	a,#128
  63  0002 81            	ret	
  95                     ; 26 void  Wireless_SDA(u8 statu)
  95                     ; 27 {
  96                     	switch	.text
  97  0003               _Wireless_SDA:
 101                     ; 38  if(statu==HIGH)
 103  0003 4a            	dec	a
 104  0004 2605          	jrne	L53
 105                     ; 39   GPIOD->ODR|=GPIO_PIN_0;
 107  0006 7210500f      	bset	20495,#0
 110  000a 81            	ret	
 111  000b               L53:
 112                     ; 41   GPIOD->ODR &=~GPIO_PIN_0;	
 114  000b 7211500f      	bres	20495,#0
 115                     ; 51 }
 118  000f 81            	ret	
 150                     ; 52 void Wireless_SCL(u8 statu)
 150                     ; 53 { 
 151                     	switch	.text
 152  0010               _Wireless_SCL:
 156                     ; 60        if(statu==HIGH)
 158  0010 4a            	dec	a
 159  0011 2605          	jrne	L55
 160                     ; 61   GPIOE->ODR|=GPIO_PIN_1;
 162  0013 72125014      	bset	20500,#1
 165  0017 81            	ret	
 166  0018               L55:
 167                     ; 63   GPIOE->ODR &=~GPIO_PIN_1;	
 169  0018 72135014      	bres	20500,#1
 170                     ; 66 }
 173  001c 81            	ret	
 197                     ; 67 u8 Wireless_SDA_statu(void)
 197                     ; 68 {
 198                     	switch	.text
 199  001d               _Wireless_SDA_statu:
 203                     ; 70  return  GPIO_ReadInputPin(GPIOD,  GPIO_PIN_0);
 205  001d 4b01          	push	#1
 206  001f ae500f        	ldw	x,#20495
 207  0022 cd0000        	call	_GPIO_ReadInputPin
 209  0025 5b01          	addw	sp,#1
 212  0027 81            	ret	
 246                     ; 75 void vCheck_SCL_Status(void)
 246                     ; 76 { 
 247                     	switch	.text
 248  0028               _vCheck_SCL_Status:
 250  0028 88            	push	a
 251       00000001      OFST:	set	1
 254                     ; 77    u8 I2S_Streching_Cnt= 100;
 256  0029 a664          	ld	a,#100
 257  002b 6b01          	ld	(OFST+0,sp),a
 259  002d 2018          	jra	L111
 260  002f               L501:
 261                     ; 85 		GPIO_WriteHigh(GPIOE, GPIO_PIN_1);
 263  002f 4b02          	push	#2
 264  0031 ae5014        	ldw	x,#20500
 265  0034 cd0000        	call	_GPIO_WriteHigh
 267  0037 84            	pop	a
 268                     ; 86 		if(GPIO_ReadInputPin(GPIOE,  GPIO_PIN_1))
 270  0038 4b02          	push	#2
 271  003a ae5014        	ldw	x,#20500
 272  003d cd0000        	call	_GPIO_ReadInputPin
 274  0040 5b01          	addw	sp,#1
 275  0042 4d            	tnz	a
 276  0043 2702          	jreq	L111
 277                     ; 87 		break;
 278  0045               L311:
 279                     ; 89 }
 282  0045 84            	pop	a
 283  0046 81            	ret	
 284  0047               L111:
 285                     ; 83 	while(I2S_Streching_Cnt--)
 287  0047 7b01          	ld	a,(OFST+0,sp)
 288  0049 0a01          	dec	(OFST+0,sp)
 289  004b 4d            	tnz	a
 290  004c 26e1          	jrne	L501
 291  004e 20f5          	jra	L311
 323                     ; 90 void  Wireless_IIC_delay(u8 n)
 323                     ; 91 {
 324                     	switch	.text
 325  0050               _Wireless_IIC_delay:
 327  0050 88            	push	a
 328       00000000      OFST:	set	0
 331  0051               L531:
 332                     ; 92 	while(n--)
 334  0051 7b01          	ld	a,(OFST+1,sp)
 335  0053 0a01          	dec	(OFST+1,sp)
 336  0055 4d            	tnz	a
 337  0056 26f9          	jrne	L531
 338                     ; 96 }
 341  0058 84            	pop	a
 342  0059 81            	ret	
 366                     ; 97 unsigned char SDA_IN(void)
 366                     ; 98 {
 367                     	switch	.text
 368  005a               _SDA_IN:
 372                     ; 99 	return SLA_SDA;
 377  005a 20c1          	jp	_Wireless_SDA_statu
 410                     ; 101 void SDA_OUT(unsigned char b)
 410                     ; 102 {
 411                     	switch	.text
 412  005c               _SDA_OUT:
 416                     ; 103 	if (b == 0)
 418  005c 4d            	tnz	a
 419                     ; 104 		{SDA_LOW;}
 422  005d 2702          	jreq	L761
 423                     ; 106 		{SDA_HIGH ;}
 425  005f a601          	ld	a,#1
 427  0061               L761:
 429                     ; 107 }
 432  0061 20a0          	jp	_Wireless_SDA
 459                     ; 108 unsigned char i2c_start(void)
 459                     ; 109 {
 460                     	switch	.text
 461  0063               _i2c_start:
 465                     ; 110 	SDA_HIGH ;       
 467  0063 a601          	ld	a,#1
 468  0065 ad9c          	call	_Wireless_SDA
 470                     ; 111 	delay_II(1);
 472  0067 a601          	ld	a,#1
 473  0069 ade5          	call	_Wireless_IIC_delay
 475                     ; 112 	SCL_HIGH;        
 477  006b a601          	ld	a,#1
 478  006d ada1          	call	_Wireless_SCL
 480                     ; 113 	delay_II(1);
 482  006f a601          	ld	a,#1
 483  0071 addd          	call	_Wireless_IIC_delay
 485                     ; 115 	vCheck_SCL_Status();
 487  0073 adb3          	call	_vCheck_SCL_Status
 489                     ; 117 	SDA_LOW;   
 491  0075 4f            	clr	a
 492  0076 ad8b          	call	_Wireless_SDA
 494                     ; 118 	delay_II(1);
 496  0078 a601          	ld	a,#1
 497  007a add4          	call	_Wireless_IIC_delay
 499                     ; 119 	SCL_LOW;
 501  007c 4f            	clr	a
 502  007d ad91          	call	_Wireless_SCL
 504                     ; 120 	delay_II(1);
 506  007f a601          	ld	a,#1
 507  0081 adcd          	call	_Wireless_IIC_delay
 509                     ; 121         return 0;
 511  0083 4f            	clr	a
 514  0084 81            	ret	
 541                     ; 123 unsigned char i2c_stop(void)
 541                     ; 124 {
 542                     	switch	.text
 543  0085               _i2c_stop:
 547                     ; 125 	delay_II(1);
 549  0085 a601          	ld	a,#1
 550  0087 adc7          	call	_Wireless_IIC_delay
 552                     ; 126 	SDA_LOW;        
 554  0089 4f            	clr	a
 555  008a cd0003        	call	_Wireless_SDA
 557                     ; 127 	delay_II(1);
 559  008d a601          	ld	a,#1
 560  008f adbf          	call	_Wireless_IIC_delay
 562                     ; 128 	SCL_HIGH;
 564  0091 a601          	ld	a,#1
 565  0093 cd0010        	call	_Wireless_SCL
 567                     ; 130 	vCheck_SCL_Status();
 569  0096 ad90          	call	_vCheck_SCL_Status
 571                     ; 132 	delay_II(2);
 573  0098 a602          	ld	a,#2
 574  009a adb4          	call	_Wireless_IIC_delay
 576                     ; 133 	SDA_HIGH ;        
 578  009c a601          	ld	a,#1
 579  009e cd0003        	call	_Wireless_SDA
 581                     ; 134 	return (0);
 583  00a1 4f            	clr	a
 586  00a2 81            	ret	
 622                     ; 136 unsigned char i2c_bit_out(unsigned char bout)
 622                     ; 137 {
 623                     	switch	.text
 624  00a3               _i2c_bit_out:
 628                     ; 138 	SDA_OUT(bout);		
 630  00a3 adb7          	call	_SDA_OUT
 632                     ; 139 	delay_II(1);
 634  00a5 a601          	ld	a,#1
 635  00a7 ada7          	call	_Wireless_IIC_delay
 637                     ; 140 	SCL_HIGH;
 639  00a9 a601          	ld	a,#1
 640  00ab cd0010        	call	_Wireless_SCL
 642                     ; 142 	vCheck_SCL_Status();
 644  00ae cd0028        	call	_vCheck_SCL_Status
 646                     ; 144 	delay_II(2);
 648  00b1 a602          	ld	a,#2
 649  00b3 ad9b          	call	_Wireless_IIC_delay
 651                     ; 145 	SCL_LOW;			/* Pull SCL back down */
 653  00b5 4f            	clr	a
 654  00b6 cd0010        	call	_Wireless_SCL
 656                     ; 146 	delay_II(1);
 658  00b9 a601          	ld	a,#1
 659  00bb ad93          	call	_Wireless_IIC_delay
 661                     ; 147 	return 0;			/* OK */	
 663  00bd 4f            	clr	a
 666  00be 81            	ret	
 703                     ; 149 unsigned char i2c_bit_in(void)
 703                     ; 150 {	
 704                     	switch	.text
 705  00bf               _i2c_bit_in:
 707  00bf 88            	push	a
 708       00000001      OFST:	set	1
 711                     ; 152 	SDA_HIGH ;
 713  00c0 a601          	ld	a,#1
 714  00c2 cd0003        	call	_Wireless_SDA
 716                     ; 153 	delay_II(1);
 718  00c5 a601          	ld	a,#1
 719  00c7 ad87          	call	_Wireless_IIC_delay
 721                     ; 154 	SCL_HIGH;			/* Let SCL go up */
 723  00c9 a601          	ld	a,#1
 724  00cb cd0010        	call	_Wireless_SCL
 726                     ; 156 	vCheck_SCL_Status();
 728  00ce cd0028        	call	_vCheck_SCL_Status
 730                     ; 158 	delay_II(3);
 732  00d1 a603          	ld	a,#3
 733  00d3 cd0050        	call	_Wireless_IIC_delay
 735                     ; 159 	bin = SDA_IN();		/* Read in data */
 737  00d6 ad82          	call	_SDA_IN
 739  00d8 6b01          	ld	(OFST+0,sp),a
 740                     ; 160 	delay_II(1);
 742  00da a601          	ld	a,#1
 743  00dc cd0050        	call	_Wireless_IIC_delay
 745                     ; 161 	SCL_LOW;			/* Pull SCL back up */
 747  00df 4f            	clr	a
 748  00e0 cd0010        	call	_Wireless_SCL
 750                     ; 162 	delay_II(1);
 752  00e3 a601          	ld	a,#1
 753  00e5 cd0050        	call	_Wireless_IIC_delay
 755                     ; 163 	return bin;			/* Return the sampled bit */
 757  00e8 7b01          	ld	a,(OFST+0,sp)
 760  00ea 5b01          	addw	sp,#1
 761  00ec 81            	ret	
 805                     ; 165 unsigned char i2c_bit_in_ACK(void)
 805                     ; 166 {	
 806                     	switch	.text
 807  00ed               _i2c_bit_in_ACK:
 809  00ed 89            	pushw	x
 810       00000002      OFST:	set	2
 813                     ; 169 	SDA_HIGH ;
 815  00ee a601          	ld	a,#1
 816  00f0 cd0003        	call	_Wireless_SDA
 818                     ; 170 	delay_II(1);
 820  00f3 a601          	ld	a,#1
 821  00f5 cd0050        	call	_Wireless_IIC_delay
 823                     ; 171 	SCL_HIGH;	
 825  00f8 a601          	ld	a,#1
 826  00fa cd0010        	call	_Wireless_SCL
 828                     ; 173 	vCheck_SCL_Status();
 830  00fd cd0028        	call	_vCheck_SCL_Status
 832                     ; 175 	delay_II(3);
 834  0100 a603          	ld	a,#3
 835  0102 cd0050        	call	_Wireless_IIC_delay
 837                     ; 177         i=0;
 839  0105 0f01          	clr	(OFST-1,sp)
 840  0107               L752:
 841                     ; 180 			bin = SDA_IN();		/* Read in data */
 843  0107 cd005a        	call	_SDA_IN
 845  010a 6b02          	ld	(OFST+0,sp),a
 846                     ; 181 			if(bin == 0)
 848  010c 2708          	jreq	L362
 849                     ; 182 				{ break;}
 851                     ; 183 			i++;			
 853  010e 0c01          	inc	(OFST-1,sp)
 854                     ; 178 	while(i<100)
 856  0110 7b01          	ld	a,(OFST-1,sp)
 857  0112 a164          	cp	a,#100
 858  0114 25f1          	jrult	L752
 859  0116               L362:
 860                     ; 186 	bin = SDA_IN();		/* Read in data */
 862  0116 cd005a        	call	_SDA_IN
 864  0119 6b02          	ld	(OFST+0,sp),a
 865                     ; 187 	delay_II(1);
 867  011b a601          	ld	a,#1
 868  011d cd0050        	call	_Wireless_IIC_delay
 870                     ; 188 	SCL_LOW;			/* Pull SCL back up */
 872  0120 4f            	clr	a
 873  0121 cd0010        	call	_Wireless_SCL
 875                     ; 189 	delay_II(1);
 877  0124 a601          	ld	a,#1
 878  0126 cd0050        	call	_Wireless_IIC_delay
 880                     ; 190 	return bin;			/* Return the sampled bit */
 882  0129 7b02          	ld	a,(OFST+0,sp)
 885  012b 85            	popw	x
 886  012c 81            	ret	
 928                     ; 193 unsigned char i2c_byte_out(unsigned char dat)
 928                     ; 194 {
 929                     	switch	.text
 930  012d               _i2c_byte_out:
 932  012d 88            	push	a
 933  012e 88            	push	a
 934       00000001      OFST:	set	1
 937                     ; 195        unsigned char  bit_count = 8;
 939  012f a608          	ld	a,#8
 940  0131 6b01          	ld	(OFST+0,sp),a
 941  0133               L503:
 942                     ; 199 		if (dat & 0x80)
 944  0133 7b02          	ld	a,(OFST+1,sp)
 945  0135 2a04          	jrpl	L313
 946                     ; 201 			if (i2c_bit_out(1)) return 1;
 948  0137 a601          	ld	a,#1
 952  0139 2001          	jp	LC001
 953  013b               L313:
 954                     ; 205 			if (i2c_bit_out(0)) return 1;
 956  013b 4f            	clr	a
 960  013c               LC001:
 961  013c cd00a3        	call	_i2c_bit_out
 962  013f 4d            	tnz	a
 963  0140 2704          	jreq	L713
 965  0142 a601          	ld	a,#1
 967  0144               L602:
 969  0144 85            	popw	x
 970  0145 81            	ret	
 971  0146               L713:
 972                     ; 207 		dat <<= 1;
 974  0146 0802          	sll	(OFST+1,sp)
 975                     ; 208 		bit_count--;
 977  0148 0a01          	dec	(OFST+0,sp)
 978                     ; 197 	while(bit_count)
 980  014a 26e7          	jrne	L503
 981                     ; 210 	if (i2c_bit_in_ACK())
 983  014c ad9f          	call	_i2c_bit_in_ACK
 985  014e 4d            	tnz	a
 986  014f 27f3          	jreq	L602
 987                     ; 212 		i2c_error = I2CERR_NAK;
 989  0151 a601          	ld	a,#1
 990  0153 c70000        	ld	_i2c_error,a
 991                     ; 213 		return 1;
 994  0156 20ec          	jra	L602
 995                     ; 215      return 0;
1046                     ; 218 unsigned char i2c_byte_in(unsigned char Ack_Bit)
1046                     ; 219 {
1047                     	switch	.text
1048  0158               _i2c_byte_in:
1050  0158 88            	push	a
1051  0159 89            	pushw	x
1052       00000002      OFST:	set	2
1055                     ; 220        unsigned char bit_count=8, byte_in=0;
1057  015a a608          	ld	a,#8
1058  015c 6b01          	ld	(OFST-1,sp),a
1061  015e 0f02          	clr	(OFST+0,sp)
1063  0160 2010          	jra	L153
1064  0162               L543:
1065                     ; 223 		byte_in <<= 1;
1067  0162 0802          	sll	(OFST+0,sp)
1068                     ; 224 		if (i2c_bit_in()) 
1070  0164 cd00bf        	call	_i2c_bit_in
1072  0167 4d            	tnz	a
1073  0168 2706          	jreq	L553
1074                     ; 225 			byte_in |= 0x01;
1076  016a 7b02          	ld	a,(OFST+0,sp)
1077  016c aa01          	or	a,#1
1078  016e 6b02          	ld	(OFST+0,sp),a
1079  0170               L553:
1080                     ; 226 		bit_count--;
1082  0170 0a01          	dec	(OFST-1,sp)
1083  0172               L153:
1084                     ; 221 	while(bit_count)
1086  0172 7b01          	ld	a,(OFST-1,sp)
1087  0174 26ec          	jrne	L543
1088                     ; 228 	i2c_bit_out(Ack_Bit);
1090  0176 7b03          	ld	a,(OFST+1,sp)
1091  0178 cd00a3        	call	_i2c_bit_out
1093                     ; 229 	SDA_HIGH ;
1095  017b a601          	ld	a,#1
1096  017d cd0003        	call	_Wireless_SDA
1098                     ; 230 	return byte_in;
1100  0180 7b02          	ld	a,(OFST+0,sp)
1103  0182 5b03          	addw	sp,#3
1104  0184 81            	ret	
1157                     ; 232 unsigned char I2C_8052_Write_Buf (unsigned char *buf, int count)
1157                     ; 233 {
1158                     	switch	.text
1159  0185               _I2C_8052_Write_Buf:
1161  0185 89            	pushw	x
1162  0186 88            	push	a
1163       00000001      OFST:	set	1
1166                     ; 235        	i2c_start();
1168  0187 cd0063        	call	_i2c_start
1170                     ; 237          i2c_error = 0;
1172  018a 725f0000      	clr	_i2c_error
1173                     ; 238 	if (i2c_byte_out(0x80))	
1175  018e a680          	ld	a,#128
1176  0190 ad9b          	call	_i2c_byte_out
1178  0192 4d            	tnz	a
1179  0193 272b          	jreq	L704
1180                     ; 240 		if (i2c_error == I2CERR_NAK )
1182  0195 c60000        	ld	a,_i2c_error
1183  0198 a101          	cp	a,#1
1184  019a 261c          	jrne	L632
1185                     ; 241 		    i2c_stop();		
1187                     ; 242 		return i2c_error;
1190  019c 2014          	jp	LC003
1191  019e               L504:
1192                     ; 247                 byte_out = *buf++;
1194  019e 1e02          	ldw	x,(OFST+1,sp)
1195  01a0 5c            	incw	x
1196  01a1 1f02          	ldw	(OFST+1,sp),x
1197  01a3 5a            	decw	x
1198  01a4 f6            	ld	a,(x)
1199  01a5 6b01          	ld	(OFST+0,sp),a
1200                     ; 248 		if (i2c_byte_out(byte_out))
1202  01a7 ad84          	call	_i2c_byte_out
1204  01a9 4d            	tnz	a
1205  01aa 270f          	jreq	L314
1206                     ; 250 			if (i2c_error == I2CERR_NAK)
1208  01ac c60000        	ld	a,_i2c_error
1209  01af 4a            	dec	a
1210  01b0 2603          	jrne	L514
1211                     ; 251 				i2c_stop();
1213  01b2               LC003:
1215  01b2 cd0085        	call	_i2c_stop
1217  01b5               L514:
1218                     ; 252                             return i2c_error;
1220  01b5 c60000        	ld	a,_i2c_error
1222  01b8               L632:
1224  01b8 5b03          	addw	sp,#3
1225  01ba 81            	ret	
1226  01bb               L314:
1227                     ; 254 		count--;
1229  01bb 1e06          	ldw	x,(OFST+5,sp)
1230  01bd 5a            	decw	x
1231  01be 1f06          	ldw	(OFST+5,sp),x
1232  01c0               L704:
1233                     ; 245 	while(count)
1235  01c0 1e06          	ldw	x,(OFST+5,sp)
1236  01c2 26da          	jrne	L504
1237                     ; 256 	i2c_stop();
1239  01c4 cd0085        	call	_i2c_stop
1241                     ; 257 	return 0;
1243  01c7 4f            	clr	a
1245  01c8 20ee          	jra	L632
1297                     ; 260 unsigned char I2C_8052_Read_Buf ( unsigned int rx_count)
1297                     ; 261 {
1298                     	switch	.text
1299  01ca               _I2C_8052_Read_Buf:
1301  01ca 89            	pushw	x
1302  01cb 89            	pushw	x
1303       00000002      OFST:	set	2
1306                     ; 262       unsigned char byte_in , byteptr = 0;  
1308  01cc 0f01          	clr	(OFST-1,sp)
1309                     ; 263       if (i2c_start()) 
1311  01ce cd0063        	call	_i2c_start
1313  01d1 4d            	tnz	a
1314                     ; 264 	  	return 1;
1316  01d2 2614          	jrne	LC004
1317                     ; 265       i2c_error = 0; 
1319  01d4 c70000        	ld	_i2c_error,a
1320                     ; 266       if (i2c_byte_out(0x80))         //send device address
1322  01d7 a680          	ld	a,#128
1323  01d9 cd012d        	call	_i2c_byte_out
1325  01dc 4d            	tnz	a
1326  01dd 270e          	jreq	L144
1327                     ; 268            if (i2c_error == I2CERR_NAK )
1329  01df c60000        	ld	a,_i2c_error
1330  01e2 4a            	dec	a
1331  01e3 2608          	jrne	L144
1332                     ; 270                     i2c_stop();                         
1334  01e5               LC005:
1336  01e5 cd0085        	call	_i2c_stop
1338                     ; 271                     return 1;
1340  01e8               LC004:
1343  01e8 a601          	ld	a,#1
1345  01ea               L462:
1347  01ea 5b04          	addw	sp,#4
1348  01ec 81            	ret	
1349  01ed               L144:
1350                     ; 276       i2c_start();      
1352  01ed cd0063        	call	_i2c_start
1354                     ; 277       if (i2c_byte_out(0x81))         //send device address
1356  01f0 a681          	ld	a,#129
1357  01f2 cd012d        	call	_i2c_byte_out
1359  01f5 4d            	tnz	a
1360  01f6 2722          	jreq	L354
1361                     ; 279            if (i2c_error == I2CERR_NAK )
1363  01f8 c60000        	ld	a,_i2c_error
1364  01fb 4a            	dec	a
1365  01fc 261c          	jrne	L354
1366                     ; 281                     i2c_stop();                         
1368                     ; 282                     return 1;
1370  01fe 20e5          	jp	LC005
1371  0200               L154:
1372                     ; 287            if (--rx_count)
1374  0200 5a            	decw	x
1375  0201 1f03          	ldw	(OFST+1,sp),x
1376  0203 2703          	jreq	L754
1377                     ; 289                     byte_in = i2c_byte_in(0);
1379  0205 4f            	clr	a
1382  0206 2002          	jra	L164
1383  0208               L754:
1384                     ; 293                     byte_in = i2c_byte_in(1); /* No ACK during last byte */
1386  0208 a601          	ld	a,#1
1388  020a               L164:
1389  020a cd0158        	call	_i2c_byte_in
1390  020d 6b02          	ld	(OFST+0,sp),a
1391                     ; 295            RX_Data_recv_array[byteptr]     = byte_in;
1393  020f 5f            	clrw	x
1394  0210 7b01          	ld	a,(OFST-1,sp)
1395  0212 97            	ld	xl,a
1396  0213 7b02          	ld	a,(OFST+0,sp)
1397  0215 d70000        	ld	(_RX_Data_recv_array,x),a
1398                     ; 296            byteptr++;               
1400  0218 0c01          	inc	(OFST-1,sp)
1401  021a               L354:
1402                     ; 285       while(rx_count)
1404  021a 1e03          	ldw	x,(OFST+1,sp)
1405  021c 26e2          	jrne	L154
1406                     ; 298      i2c_stop();
1408  021e cd0085        	call	_i2c_stop
1410                     ; 299      return 0 ;         
1412  0221 4f            	clr	a
1414  0222 20c6          	jra	L462
1475                     ; 303  unsigned char i2c_recv(unsigned char *temp_buff,unsigned char count)
1475                     ; 304 {
1476                     	switch	.text
1477  0224               _i2c_recv:
1479  0224 89            	pushw	x
1480  0225 89            	pushw	x
1481       00000002      OFST:	set	2
1484                     ; 307 	if (i2c_start()) return 1;
1486  0226 cd0063        	call	_i2c_start
1488  0229 4d            	tnz	a
1491  022a 263a          	jrne	LC006
1492                     ; 308 	i2c_error = 0;
1494  022c c70000        	ld	_i2c_error,a
1495                     ; 309 	byteptr = 0;
1497                     ; 311 	if (i2c_byte_out(0x37))
1499  022f a637          	ld	a,#55
1500  0231 cd012d        	call	_i2c_byte_out
1502  0234 4d            	tnz	a
1503  0235 2723          	jreq	L715
1504                     ; 313 		if (i2c_error == I2CERR_NAK) 
1506  0237 c60000        	ld	a,_i2c_error
1507  023a 4a            	dec	a
1508  023b 2603          	jrne	L315
1509                     ; 314 			i2c_stop();
1511  023d cd0085        	call	_i2c_stop
1513  0240               L315:
1514                     ; 315 		return 
1514                     ; 316 			i2c_error;
1516  0240 c60000        	ld	a,_i2c_error
1518  0243               L013:
1520  0243 5b04          	addw	sp,#4
1521  0245 81            	ret	
1522  0246               L515:
1523                     ; 321 		if (--count)
1525  0246 0a07          	dec	(OFST+5,sp)
1526  0248 2703          	jreq	L325
1527                     ; 322 			byte_in = i2c_byte_in(0);
1529  024a 4f            	clr	a
1532  024b 2002          	jra	L525
1533  024d               L325:
1534                     ; 324 			byte_in = i2c_byte_in(1);   /* No ACK during last byte */
1536  024d a601          	ld	a,#1
1538  024f               L525:
1539  024f cd0158        	call	_i2c_byte_in
1540  0252 6b02          	ld	(OFST+0,sp),a
1541                     ; 325 		*temp_buff=byte_in;
1543  0254 1e03          	ldw	x,(OFST+1,sp)
1544  0256 f7            	ld	(x),a
1545                     ; 326 		temp_buff++;
1547  0257 5c            	incw	x
1548  0258 1f03          	ldw	(OFST+1,sp),x
1549  025a               L715:
1550                     ; 319 	while(count)
1552  025a 7b07          	ld	a,(OFST+5,sp)
1553  025c 26e8          	jrne	L515
1554                     ; 329 	i2c_stop();
1556  025e cd0085        	call	_i2c_stop
1558                     ; 331 	return (i2c_error ? 1 : 0);
1560  0261 c60000        	ld	a,_i2c_error
1561  0264 27dd          	jreq	L013
1562  0266               LC006:
1564  0266 a601          	ld	a,#1
1565  0268 20d9          	jra	L013
1629                     ; 336 unsigned char I2C_Read_Buf (unsigned char map,unsigned char *temp,unsigned char  rx_count)
1629                     ; 337 {
1630                     	switch	.text
1631  026a               _I2C_Read_Buf:
1633  026a 88            	push	a
1634  026b 88            	push	a
1635       00000001      OFST:	set	1
1638                     ; 338 	u8 bdata=0;
1640  026c 0f01          	clr	(OFST+0,sp)
1641                     ; 339 	if ( I2C_Write_Buf (map, &bdata, 0))//, 0))/* second map addres is dummy pointer no data writtten only i2cSlave address and map address*/
1643  026e 4b00          	push	#0
1644  0270 96            	ldw	x,sp
1645  0271 1c0002        	addw	x,#OFST+1
1646  0274 89            	pushw	x
1647  0275 ad3b          	call	_I2C_Write_Buf
1649  0277 5b03          	addw	sp,#3
1650  0279 4d            	tnz	a
1651  027a 270c          	jreq	L355
1652                     ; 343 		if (i2c_error != I2CERR_LOST) 
1654  027c c60000        	ld	a,_i2c_error
1655  027f a102          	cp	a,#2
1656  0281 271f          	jreq	LC007
1657                     ; 344 		i2c_stop();
1659  0283 cd0085        	call	_i2c_stop
1661                     ; 345 		return 1;
1663  0286 201a          	jp	LC007
1664  0288               L355:
1665                     ; 348 	SDA_HIGH ;        /* One of these may be low now, in which case the next */
1667  0288 4c            	inc	a
1668  0289 cd0003        	call	_Wireless_SDA
1670                     ; 349 	SCL_HIGH;        /*   start condition wouldn't be detected so make */
1672  028c a601          	ld	a,#1
1673  028e cd0010        	call	_Wireless_SCL
1675                     ; 350 	delay_II(2);    /*   sure that they're up and wait for one delay slot */
1677  0291 a602          	ld	a,#2
1678  0293 cd0050        	call	_Wireless_IIC_delay
1680                     ; 351 	if (i2c_recv(temp,rx_count))
1682  0296 7b07          	ld	a,(OFST+6,sp)
1683  0298 88            	push	a
1684  0299 1e06          	ldw	x,(OFST+5,sp)
1685  029b ad87          	call	_i2c_recv
1687  029d 5b01          	addw	sp,#1
1688  029f 4d            	tnz	a
1689  02a0 2704          	jreq	L755
1690                     ; 352 	return 1;
1692  02a2               LC007:
1694  02a2 a601          	ld	a,#1
1696  02a4               L433:
1698  02a4 85            	popw	x
1699  02a5 81            	ret	
1700  02a6               L755:
1701                     ; 354 	return (i2c_error ? 1 : 0);
1703  02a6 725d0000      	tnz	_i2c_error
1704  02aa 2703          	jreq	L033
1705  02ac 4c            	inc	a
1706  02ad 20f5          	jra	L433
1707  02af               L033:
1708  02af 4f            	clr	a
1710  02b0 20f2          	jra	L433
1778                     ; 358 unsigned char I2C_Write_Buf (unsigned char addr, unsigned char *buf, unsigned char count) //unsigned char flash_type)
1778                     ; 359 {
1779                     	switch	.text
1780  02b2               _I2C_Write_Buf:
1782  02b2 88            	push	a
1783  02b3 88            	push	a
1784       00000001      OFST:	set	1
1787                     ; 364 	   if(Tpa5050)
1789  02b4 c60001        	ld	a,_Tpa5050
1790  02b7 2704          	jreq	L706
1791                     ; 365 	 	add_slave=I2C_dADDR_FOR_Tpa5050;
1793  02b9 a6d0          	ld	a,#208
1795  02bb 2002          	jra	L116
1796  02bd               L706:
1797                     ; 367 		add_slave=0x36;	
1799  02bd a636          	ld	a,#54
1800  02bf               L116:
1801  02bf 6b01          	ld	(OFST+0,sp),a
1802                     ; 369 	if (i2c_start()) 	return 1;
1804  02c1 cd0063        	call	_i2c_start
1806  02c4 4d            	tnz	a
1807  02c5 2704          	jreq	L316
1810  02c7 a601          	ld	a,#1
1812  02c9 2017          	jra	L453
1813  02cb               L316:
1814                     ; 370 		i2c_error = 0;
1816  02cb c70000        	ld	_i2c_error,a
1817                     ; 373 	if (i2c_byte_out(add_slave))
1819  02ce 7b01          	ld	a,(OFST+0,sp)
1820  02d0 cd012d        	call	_i2c_byte_out
1822  02d3 4d            	tnz	a
1823  02d4 270e          	jreq	L516
1824                     ; 375 		if (i2c_error == I2CERR_NAK )
1826  02d6 c60000        	ld	a,_i2c_error
1827  02d9 4a            	dec	a
1828  02da 2603          	jrne	L716
1829                     ; 376 		i2c_stop();		
1831  02dc               LC009:
1833  02dc cd0085        	call	_i2c_stop
1835  02df               L716:
1836                     ; 377 		return i2c_error;
1839  02df c60000        	ld	a,_i2c_error
1841  02e2               L453:
1843  02e2 85            	popw	x
1844  02e3 81            	ret	
1845  02e4               L516:
1846                     ; 379 	byte_out = (addr & 0xFF);
1848  02e4 7b02          	ld	a,(OFST+1,sp)
1849  02e6 6b01          	ld	(OFST+0,sp),a
1850                     ; 380 	count = count+1;                    /* Include map addres to byte count */
1852  02e8 0c07          	inc	(OFST+6,sp)
1854  02ea 2019          	jra	L326
1855  02ec               L126:
1856                     ; 383 		if (i2c_byte_out(byte_out))
1858  02ec cd012d        	call	_i2c_byte_out
1860  02ef 4d            	tnz	a
1861  02f0 2708          	jreq	L726
1862                     ; 385 			if (i2c_error == I2CERR_NAK)
1864  02f2 c60000        	ld	a,_i2c_error
1865  02f5 4a            	dec	a
1866  02f6 26e7          	jrne	L716
1867                     ; 386 				i2c_stop();
1869                     ; 387 				return i2c_error;
1871  02f8 20e2          	jp	LC009
1872  02fa               L726:
1873                     ; 389 		byte_out = *buf++;
1875  02fa 1e05          	ldw	x,(OFST+4,sp)
1876  02fc 5c            	incw	x
1877  02fd 1f05          	ldw	(OFST+4,sp),x
1878  02ff 5a            	decw	x
1879  0300 f6            	ld	a,(x)
1880  0301 6b01          	ld	(OFST+0,sp),a
1881                     ; 390 		count--;
1883  0303 0a07          	dec	(OFST+6,sp)
1884  0305               L326:
1885                     ; 381 	while(count)
1887  0305 26e5          	jrne	L126
1888                     ; 392 	i2c_stop();
1890  0307 cd0085        	call	_i2c_stop
1892                     ; 393 	return 0;
1894  030a 4f            	clr	a
1896  030b 20d5          	jra	L453
1946                     ; 397 unsigned char I2C_Write_TAS5711(unsigned char write_addr,unsigned char *write_buff,unsigned char count)
1946                     ; 398 {
1947                     	switch	.text
1948  030d               _I2C_Write_TAS5711:
1950  030d 88            	push	a
1951       00000000      OFST:	set	0
1954                     ; 401 		if(I2CERR_OK ==I2C_Write_Buf(write_addr,write_buff,count));
1956  030e 7b06          	ld	a,(OFST+6,sp)
1957  0310 88            	push	a
1958  0311 1e05          	ldw	x,(OFST+5,sp)
1959  0313 89            	pushw	x
1960  0314 7b04          	ld	a,(OFST+4,sp)
1961  0316 ad9a          	call	_I2C_Write_Buf
1963  0318 5b03          	addw	sp,#3
1964  031a 4d            	tnz	a
1966                     ; 403 	      return(0);
1968  031b 4f            	clr	a
1971  031c 5b01          	addw	sp,#1
1972  031e 81            	ret	
2022                     ; 406 unsigned char I2C_Read_TAS5711(unsigned char read_addr,unsigned char *read_buff,unsigned char count)
2022                     ; 407 {
2023                     	switch	.text
2024  031f               _I2C_Read_TAS5711:
2026  031f 88            	push	a
2027       00000000      OFST:	set	0
2030                     ; 409 	    return (I2C_Read_Buf(read_addr,read_buff,count));
2032  0320 7b06          	ld	a,(OFST+6,sp)
2033  0322 88            	push	a
2034  0323 1e05          	ldw	x,(OFST+5,sp)
2035  0325 89            	pushw	x
2036  0326 7b04          	ld	a,(OFST+4,sp)
2037  0328 cd026a        	call	_I2C_Read_Buf
2039  032b 5b04          	addw	sp,#4
2042  032d 81            	ret	
2093                     ; 414 unsigned char I2C_Write_Tpa5050(unsigned char write_addr,unsigned char *write_buff,unsigned char count)
2093                     ; 415 {
2094                     	switch	.text
2095  032e               _I2C_Write_Tpa5050:
2097       00000000      OFST:	set	0
2100                     ; 417 		Tpa5050=1;
2102  032e 35010001      	mov	_Tpa5050,#1
2103  0332 88            	push	a
2104                     ; 418 	       I2C_Write_Buf(write_addr,write_buff,count);
2106  0333 7b06          	ld	a,(OFST+6,sp)
2107  0335 88            	push	a
2108  0336 1e05          	ldw	x,(OFST+5,sp)
2109  0338 89            	pushw	x
2110  0339 7b04          	ld	a,(OFST+4,sp)
2111  033b cd02b2        	call	_I2C_Write_Buf
2113  033e 5b03          	addw	sp,#3
2114                     ; 419              Tpa5050=0;
2116  0340 725f0001      	clr	_Tpa5050
2117                     ; 420 	        return(0);
2119  0344 4f            	clr	a
2122  0345 5b01          	addw	sp,#1
2123  0347 81            	ret	
2183                     ; 429 u8 I2C_Write_Buf_W (u16 addr, u8 *buf, unsigned int count)
2183                     ; 430 {
2184                     	switch	.text
2185  0348               _I2C_Write_Buf_W:
2187  0348 89            	pushw	x
2188  0349 88            	push	a
2189       00000001      OFST:	set	1
2192                     ; 431 	u8 byte_out = (u8 ) (addr>>8) ;
2194  034a 9e            	ld	a,xh
2195  034b 6b01          	ld	(OFST+0,sp),a
2196                     ; 432 	i2c_start();
2198  034d cd0063        	call	_i2c_start
2200                     ; 433 	if (i2c_byte_out(I2C_WIRELESS_UPG_ADDR & 0xFE))
2202  0350 a682          	ld	a,#130
2203  0352 cd012d        	call	_i2c_byte_out
2205  0355 4d            	tnz	a
2206                     ; 435 		i2c_stop();
2208                     ; 436 		return 1;
2210  0356 261b          	jrne	LC010
2211                     ; 438 	i2c_byte_out(byte_out);
2213  0358 7b01          	ld	a,(OFST+0,sp)
2214  035a cd012d        	call	_i2c_byte_out
2216                     ; 440 	i2c_byte_out(addr & 0xFF);
2218  035d 7b03          	ld	a,(OFST+2,sp)
2219  035f cd012d        	call	_i2c_byte_out
2222  0362 2021          	jra	L357
2223  0364               L157:
2224                     ; 444 		byte_out = *buf++;
2226  0364 1e06          	ldw	x,(OFST+5,sp)
2227  0366 5c            	incw	x
2228  0367 1f06          	ldw	(OFST+5,sp),x
2229  0369 5a            	decw	x
2230  036a f6            	ld	a,(x)
2231  036b 6b01          	ld	(OFST+0,sp),a
2232                     ; 445 		if (i2c_byte_out(byte_out))
2234  036d cd012d        	call	_i2c_byte_out
2236  0370 4d            	tnz	a
2237  0371 2708          	jreq	L757
2238                     ; 447 			i2c_stop();
2241                     ; 448 			return 1;
2243  0373               LC010:
2245  0373 cd0085        	call	_i2c_stop
2247  0376 a601          	ld	a,#1
2249  0378               L614:
2251  0378 5b03          	addw	sp,#3
2252  037a 81            	ret	
2253  037b               L757:
2254                     ; 450 		count--;
2256  037b 1e08          	ldw	x,(OFST+7,sp)
2257  037d 5a            	decw	x
2258  037e 1f08          	ldw	(OFST+7,sp),x
2259                     ; 451 		Wireless_IIC_delay(2);
2261  0380 a602          	ld	a,#2
2262  0382 cd0050        	call	_Wireless_IIC_delay
2264  0385               L357:
2265                     ; 442 	while(count)
2267  0385 1e08          	ldw	x,(OFST+7,sp)
2268  0387 26db          	jrne	L157
2269                     ; 453 	i2c_stop();
2271  0389 cd0085        	call	_i2c_stop
2273                     ; 454 	return 0;
2275  038c 4f            	clr	a
2277  038d 20e9          	jra	L614
2328                     ; 460 unsigned char i2c_recv_W(unsigned char count)
2328                     ; 461 {
2329                     	switch	.text
2330  038f               _i2c_recv_W:
2332  038f 88            	push	a
2333  0390 89            	pushw	x
2334       00000002      OFST:	set	2
2337                     ; 463 	byteptr = 0;
2339  0391 0f01          	clr	(OFST-1,sp)
2340                     ; 464 	i2c_start();
2342  0393 cd0063        	call	_i2c_start
2344                     ; 465 	byte_in = I2C_WIRELESS_UPG_ADDR |0x01;
2346                     ; 466 	if (i2c_byte_out(byte_in))
2348  0396 a683          	ld	a,#131
2349  0398 cd012d        	call	_i2c_byte_out
2351  039b 4d            	tnz	a
2352  039c 2720          	jreq	L5001
2353                     ; 468 		i2c_stop();
2355  039e cd0085        	call	_i2c_stop
2357                     ; 469 		return 1;
2359  03a1 a601          	ld	a,#1
2361  03a3 2021          	jra	L634
2362  03a5               L3001:
2363                     ; 473 		if (--count)
2365  03a5 0a03          	dec	(OFST+1,sp)
2366  03a7 2703          	jreq	L1101
2367                     ; 474 			byte_in = i2c_byte_in(0);
2369  03a9 4f            	clr	a
2372  03aa 2002          	jra	L3101
2373  03ac               L1101:
2374                     ; 476 			byte_in = i2c_byte_in(1); /* No ACK during last byte */
2376  03ac a601          	ld	a,#1
2378  03ae               L3101:
2379  03ae cd0158        	call	_i2c_byte_in
2380  03b1 6b02          	ld	(OFST+0,sp),a
2381                     ; 477 		RX_Data_recv_array[byteptr]	= byte_in;
2383  03b3 5f            	clrw	x
2384  03b4 7b01          	ld	a,(OFST-1,sp)
2385  03b6 97            	ld	xl,a
2386  03b7 7b02          	ld	a,(OFST+0,sp)
2387  03b9 d70000        	ld	(_RX_Data_recv_array,x),a
2388                     ; 478 		byteptr++;
2390  03bc 0c01          	inc	(OFST-1,sp)
2391  03be               L5001:
2392                     ; 471 	while(count)
2394  03be 7b03          	ld	a,(OFST+1,sp)
2395  03c0 26e3          	jrne	L3001
2396                     ; 480 	i2c_stop();
2398  03c2 cd0085        	call	_i2c_stop
2400                     ; 481 	return 0;
2402  03c5 4f            	clr	a
2404  03c6               L634:
2406  03c6 5b03          	addw	sp,#3
2407  03c8 81            	ret	
2452                     ; 484 u8 I2C_Read_Buf_W(u16 map, signed int rx_count)
2452                     ; 485 {
2453                     	switch	.text
2454  03c9               _I2C_Read_Buf_W:
2456  03c9 89            	pushw	x
2457       00000000      OFST:	set	0
2460                     ; 486 	if ( I2C_Write_Buf_W (map, (u8*) &map, 0))/* second map addres is dummy pointer no data writtten only i2cSlave address and map address*/
2462  03ca 5f            	clrw	x
2463  03cb 89            	pushw	x
2464  03cc 96            	ldw	x,sp
2465  03cd 1c0003        	addw	x,#OFST+3
2466  03d0 89            	pushw	x
2467  03d1 1e05          	ldw	x,(OFST+5,sp)
2468  03d3 cd0348        	call	_I2C_Write_Buf_W
2470  03d6 5b04          	addw	sp,#4
2471  03d8 4d            	tnz	a
2472  03d9 2707          	jreq	L3301
2473                     ; 488 		i2c_stop();
2475  03db cd0085        	call	_i2c_stop
2477                     ; 489 		return 1;
2479  03de a601          	ld	a,#1
2481  03e0 2012          	jra	L654
2482  03e2               L3301:
2483                     ; 491 	SDA_HIGH;
2485  03e2 4c            	inc	a
2486  03e3 cd0003        	call	_Wireless_SDA
2488                     ; 492 	SCL_HIGH;
2490  03e6 a601          	ld	a,#1
2491  03e8 cd0010        	call	_Wireless_SCL
2493                     ; 493 	Wireless_IIC_delay(2);  
2495  03eb a602          	ld	a,#2
2496  03ed cd0050        	call	_Wireless_IIC_delay
2498                     ; 495 	return (i2c_recv_W(rx_count));
2500  03f0 7b06          	ld	a,(OFST+6,sp)
2501  03f2 ad9b          	call	_i2c_recv_W
2504  03f4               L654:
2506  03f4 85            	popw	x
2507  03f5 81            	ret	
2546                     	xdef	_i2c_recv_W
2547                     	xdef	_I2C_Write_Tpa5050
2548                     	xdef	_I2C_Read_TAS5711
2549                     	xdef	_i2c_recv
2550                     	xdef	_i2c_byte_in
2551                     	xdef	_i2c_byte_out
2552                     	xdef	_i2c_bit_in_ACK
2553                     	xdef	_i2c_bit_in
2554                     	xdef	_i2c_bit_out
2555                     	xdef	_i2c_stop
2556                     	xdef	_i2c_start
2557                     	xdef	_SDA_OUT
2558                     	xdef	_SDA_IN
2559                     	xdef	_Wireless_IIC_delay
2560                     	xdef	_vCheck_SCL_Status
2561                     	xdef	_Wireless_SDA_statu
2562                     	xdef	_Wireless_SCL
2563                     	xdef	_Wireless_SDA
2564                     	xdef	_Wireless_i2c_Addr
2565                     	xdef	_Tpa5050
2566                     	xdef	_i2c_error
2567                     	xdef	_I2C_Write_Buf_W
2568                     	xdef	_I2C_Read_Buf_W
2569                     	xdef	_I2C_Write_TAS5711
2570                     	xdef	_I2C_Write_Buf
2571                     	xdef	_I2C_Read_Buf
2572                     	xdef	_I2C_8052_Read_Buf
2573                     	xdef	_I2C_8052_Write_Buf
2574                     	switch	.bss
2575  0000               _RX_Data_recv_array:
2576  0000 000000000000  	ds.b	8
2577                     	xdef	_RX_Data_recv_array
2578                     	xref	_GPIO_ReadInputPin
2579                     	xref	_GPIO_WriteHigh
2599                     	end
