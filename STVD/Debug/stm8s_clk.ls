   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  18                     .const:	section	.text
  19  0000               _HSIDivFactor:
  20  0000 01            	dc.b	1
  21  0001 02            	dc.b	2
  22  0002 04            	dc.b	4
  23  0003 08            	dc.b	8
  24  0004               _CLKPrescTable:
  25  0004 01            	dc.b	1
  26  0005 02            	dc.b	2
  27  0006 04            	dc.b	4
  28  0007 08            	dc.b	8
  29  0008 0a            	dc.b	10
  30  0009 10            	dc.b	16
  31  000a 14            	dc.b	20
  32  000b 28            	dc.b	40
  61                     ; 64 void CLK_DeInit(void)
  61                     ; 65 {
  63                     	switch	.text
  64  0000               _CLK_DeInit:
  68                     ; 67     CLK->ICKR = CLK_ICKR_RESET_VALUE;
  70  0000 350150c0      	mov	20672,#1
  71                     ; 68     CLK->ECKR = CLK_ECKR_RESET_VALUE;
  73  0004 725f50c1      	clr	20673
  74                     ; 69     CLK->SWR  = CLK_SWR_RESET_VALUE;
  76  0008 35e150c4      	mov	20676,#225
  77                     ; 70     CLK->SWCR = CLK_SWCR_RESET_VALUE;
  79  000c 725f50c5      	clr	20677
  80                     ; 71     CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  82  0010 351850c6      	mov	20678,#24
  83                     ; 72     CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  85  0014 35ff50c7      	mov	20679,#255
  86                     ; 73     CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  88  0018 35ff50ca      	mov	20682,#255
  89                     ; 74     CLK->CSSR = CLK_CSSR_RESET_VALUE;
  91  001c 725f50c8      	clr	20680
  92                     ; 75     CLK->CCOR = CLK_CCOR_RESET_VALUE;
  94  0020 725f50c9      	clr	20681
  96  0024               L52:
  97                     ; 76     while (CLK->CCOR & CLK_CCOR_CCOEN)
  99  0024 720050c9fb    	btjt	20681,#0,L52
 100                     ; 78     CLK->CCOR = CLK_CCOR_RESET_VALUE;
 102  0029 725f50c9      	clr	20681
 103                     ; 79     CLK->CANCCR = CLK_CANCCR_RESET_VALUE;
 105  002d 725f50cb      	clr	20683
 106                     ; 80     CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
 108  0031 725f50cc      	clr	20684
 109                     ; 81     CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
 111  0035 725f50cd      	clr	20685
 112                     ; 83 }
 115  0039 81            	ret	
 170                     ; 90 void CLK_HSECmd(FunctionalState NewState)
 170                     ; 91 {
 171                     	switch	.text
 172  003a               _CLK_HSECmd:
 176                     ; 94     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 178                     ; 96     if (NewState != DISABLE)
 180  003a 4d            	tnz	a
 181  003b 2705          	jreq	L75
 182                     ; 99         CLK->ECKR |= CLK_ECKR_HSEEN;
 184  003d 721050c1      	bset	20673,#0
 187  0041 81            	ret	
 188  0042               L75:
 189                     ; 104         CLK->ECKR &= (u8)(~CLK_ECKR_HSEEN);
 191  0042 721150c1      	bres	20673,#0
 192                     ; 107 }
 195  0046 81            	ret	
 279                     ; 159 u32 CLK_GetClockFreq(void)
 279                     ; 160 {
 280                     	switch	.text
 281  0047               _CLK_GetClockFreq:
 283  0047 5209          	subw	sp,#9
 284       00000009      OFST:	set	9
 287                     ; 162   u32 clockfrequency = 0;
 289                     ; 163   CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
 291                     ; 164   u8 tmp = 0, presc = 0;
 295                     ; 167   clocksource = (CLK_Source_TypeDef)CLK->CMSR;
 297  0049 c650c3        	ld	a,20675
 298  004c 6b09          	ld	(OFST+0,sp),a
 299                     ; 169   if (clocksource == CLK_SOURCE_HSI)
 301  004e a1e1          	cp	a,#225
 302  0050 2634          	jrne	L121
 303                     ; 171     tmp = (u8)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
 305  0052 c650c6        	ld	a,20678
 306  0055 a418          	and	a,#24
 307  0057 44            	srl	a
 308  0058 44            	srl	a
 309  0059 44            	srl	a
 310                     ; 172     tmp = (u8)(tmp >> 3);
 312                     ; 173     presc = HSIDivFactor[tmp];
 314  005a 5f            	clrw	x
 315  005b 97            	ld	xl,a
 316  005c d60000        	ld	a,(_HSIDivFactor,x)
 317  005f 6b09          	ld	(OFST+0,sp),a
 318                     ; 174     clockfrequency = HSI_VALUE / presc;
 320  0061 b703          	ld	c_lreg+3,a
 321  0063 3f02          	clr	c_lreg+2
 322  0065 3f01          	clr	c_lreg+1
 323  0067 3f00          	clr	c_lreg
 324  0069 96            	ldw	x,sp
 325  006a 5c            	incw	x
 326  006b cd0000        	call	c_rtol
 328  006e ae2400        	ldw	x,#9216
 329  0071 bf02          	ldw	c_lreg+2,x
 330  0073 ae00f4        	ldw	x,#244
 331  0076 bf00          	ldw	c_lreg,x
 332  0078 96            	ldw	x,sp
 333  0079 5c            	incw	x
 334  007a cd0000        	call	c_ludv
 336  007d 96            	ldw	x,sp
 337  007e 1c0005        	addw	x,#OFST-4
 338  0081 cd0000        	call	c_rtol
 341  0084 2018          	jra	L321
 342  0086               L121:
 343                     ; 176   else if ( clocksource == CLK_SOURCE_LSI)
 345  0086 a1d2          	cp	a,#210
 346  0088 260a          	jrne	L521
 347                     ; 178     clockfrequency = LSI_VALUE;
 349  008a aef400        	ldw	x,#62464
 350  008d 1f07          	ldw	(OFST-2,sp),x
 351  008f ae0001        	ldw	x,#1
 353  0092 2008          	jp	LC001
 354  0094               L521:
 355                     ; 182     clockfrequency = HSE_VALUE;
 357  0094 ae1b00        	ldw	x,#6912
 358  0097 1f07          	ldw	(OFST-2,sp),x
 359  0099 ae00b7        	ldw	x,#183
 360  009c               LC001:
 361  009c 1f05          	ldw	(OFST-4,sp),x
 362  009e               L321:
 363                     ; 185   return((u32)clockfrequency);
 365  009e 96            	ldw	x,sp
 366  009f 1c0005        	addw	x,#OFST-4
 367  00a2 cd0000        	call	c_ltor
 371  00a5 5b09          	addw	sp,#9
 372  00a7 81            	ret	
 509                     ; 235 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef ClockPrescaler)
 509                     ; 236 {
 510                     	switch	.text
 511  00a8               _CLK_SYSCLKConfig:
 513  00a8 88            	push	a
 514       00000000      OFST:	set	0
 517                     ; 239     assert_param(IS_CLK_PRESCALER_OK(ClockPrescaler));
 519                     ; 241     if (((u8)ClockPrescaler & (u8)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
 521  00a9 a580          	bcp	a,#128
 522  00ab 260e          	jrne	L302
 523                     ; 243         CLK->CKDIVR &= (u8)(~CLK_CKDIVR_HSIDIV);
 525  00ad c650c6        	ld	a,20678
 526  00b0 a4e7          	and	a,#231
 527  00b2 c750c6        	ld	20678,a
 528                     ; 244         CLK->CKDIVR |= (u8)((u8)ClockPrescaler & (u8)CLK_CKDIVR_HSIDIV);
 530  00b5 7b01          	ld	a,(OFST+1,sp)
 531  00b7 a418          	and	a,#24
 533  00b9 200c          	jra	L502
 534  00bb               L302:
 535                     ; 248         CLK->CKDIVR &= (u8)(~CLK_CKDIVR_CPUDIV);
 537  00bb c650c6        	ld	a,20678
 538  00be a4f8          	and	a,#248
 539  00c0 c750c6        	ld	20678,a
 540                     ; 249         CLK->CKDIVR |= (u8)((u8)ClockPrescaler & (u8)CLK_CKDIVR_CPUDIV);
 542  00c3 7b01          	ld	a,(OFST+1,sp)
 543  00c5 a407          	and	a,#7
 544  00c7               L502:
 545  00c7 ca50c6        	or	a,20678
 546  00ca c750c6        	ld	20678,a
 547                     ; 251 }
 550  00cd 84            	pop	a
 551  00ce 81            	ret	
 700                     ; 252 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
 700                     ; 253 {
 701                     	switch	.text
 702  00cf               _CLK_GetFlagStatus:
 704  00cf 89            	pushw	x
 705  00d0 5203          	subw	sp,#3
 706       00000003      OFST:	set	3
 709                     ; 255     u16 statusreg = 0;
 711                     ; 256     u8 tmpreg = 0;
 713                     ; 257     FlagStatus bitstatus = RESET;
 715                     ; 260     assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
 717                     ; 263     statusreg = (u16)((u16)CLK_FLAG & (u16)0xFF00);
 719  00d2 01            	rrwa	x,a
 720  00d3 4f            	clr	a
 721  00d4 02            	rlwa	x,a
 722  00d5 1f01          	ldw	(OFST-2,sp),x
 723                     ; 266     if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
 725  00d7 a30100        	cpw	x,#256
 726  00da 2605          	jrne	L372
 727                     ; 268         tmpreg = CLK->ICKR;
 729  00dc c650c0        	ld	a,20672
 731  00df 2021          	jra	L572
 732  00e1               L372:
 733                     ; 270     else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
 735  00e1 a30200        	cpw	x,#512
 736  00e4 2605          	jrne	L772
 737                     ; 272         tmpreg = CLK->ECKR;
 739  00e6 c650c1        	ld	a,20673
 741  00e9 2017          	jra	L572
 742  00eb               L772:
 743                     ; 274     else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
 745  00eb a30300        	cpw	x,#768
 746  00ee 2605          	jrne	L303
 747                     ; 276         tmpreg = CLK->SWCR;
 749  00f0 c650c5        	ld	a,20677
 751  00f3 200d          	jra	L572
 752  00f5               L303:
 753                     ; 278     else if (statusreg == 0x0400) /* The flag to check is in CSS register */
 755  00f5 a30400        	cpw	x,#1024
 756  00f8 2605          	jrne	L703
 757                     ; 280         tmpreg = CLK->CSSR;
 759  00fa c650c8        	ld	a,20680
 761  00fd 2003          	jra	L572
 762  00ff               L703:
 763                     ; 284         tmpreg = CLK->CCOR;
 765  00ff c650c9        	ld	a,20681
 766  0102               L572:
 767  0102 6b03          	ld	(OFST+0,sp),a
 768                     ; 287     if ((tmpreg & (u8)CLK_FLAG) != (u8)RESET)
 770  0104 7b05          	ld	a,(OFST+2,sp)
 771  0106 1503          	bcp	a,(OFST+0,sp)
 772  0108 2704          	jreq	L313
 773                     ; 289         bitstatus = SET;
 775  010a a601          	ld	a,#1
 777  010c 2001          	jra	L513
 778  010e               L313:
 779                     ; 293         bitstatus = RESET;
 781  010e 4f            	clr	a
 782  010f               L513:
 783                     ; 297     return((FlagStatus)bitstatus);
 787  010f 5b05          	addw	sp,#5
 788  0111 81            	ret	
 823                     ; 334 void CLK_CCOCmd(FunctionalState NewState)
 823                     ; 335 {
 824                     	switch	.text
 825  0112               _CLK_CCOCmd:
 829                     ; 338     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 831                     ; 340     if (NewState != DISABLE)
 833  0112 4d            	tnz	a
 834  0113 2705          	jreq	L533
 835                     ; 343         CLK->CCOR |= CLK_CCOR_CCOEN;
 837  0115 721050c9      	bset	20681,#0
 840  0119 81            	ret	
 841  011a               L533:
 842                     ; 348         CLK->CCOR &= (u8)(~CLK_CCOR_CCOEN);
 844  011a 721150c9      	bres	20681,#0
 845                     ; 351 }
 848  011e 81            	ret	
 983                     ; 354 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
 983                     ; 355 {
 984                     	switch	.text
 985  011f               _CLK_CCOConfig:
 987  011f 88            	push	a
 988       00000000      OFST:	set	0
 991                     ; 358     assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
 993                     ; 361     CLK->CCOR &= (u8)(~CLK_CCOR_CCOSEL);
 995  0120 c650c9        	ld	a,20681
 996  0123 a4e1          	and	a,#225
 997  0125 c750c9        	ld	20681,a
 998                     ; 364     CLK->CCOR |= (u8)CLK_CCO;
1000  0128 c650c9        	ld	a,20681
1001  012b 1a01          	or	a,(OFST+1,sp)
1002  012d c750c9        	ld	20681,a
1003                     ; 367     CLK->CCOR |= CLK_CCOR_CCOEN;
1005                     ; 369 }
1008  0130 84            	pop	a
1009  0131 721050c9      	bset	20681,#0
1010  0135 81            	ret	
1035                     ; 371 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
1035                     ; 372 {
1036                     	switch	.text
1037  0136               _CLK_GetSYSCLKSource:
1041                     ; 373     return((CLK_Source_TypeDef)CLK->CMSR);
1043  0136 c650c3        	ld	a,20675
1046  0139 81            	ret	
1205                     ; 377 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
1205                     ; 378 {
1206                     	switch	.text
1207  013a               _CLK_ClockSwitchConfig:
1209  013a 89            	pushw	x
1210  013b 5204          	subw	sp,#4
1211       00000004      OFST:	set	4
1214                     ; 381     u16 DownCounter = CLK_TIMEOUT;
1216  013d ae0491        	ldw	x,#1169
1217  0140 1f03          	ldw	(OFST-1,sp),x
1218                     ; 382     ErrorStatus Swif = ERROR;
1220                     ; 385     assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
1222                     ; 386     assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
1224                     ; 387     assert_param(IS_FUNCTIONALSTATE_OK(ITState));
1226                     ; 388     assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
1228                     ; 391     clock_master = (CLK_Source_TypeDef)CLK->CMSR;
1230  0142 c650c3        	ld	a,20675
1231  0145 6b01          	ld	(OFST-3,sp),a
1232                     ; 394     if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
1234  0147 7b05          	ld	a,(OFST+1,sp)
1235  0149 4a            	dec	a
1236  014a 262d          	jrne	L125
1237                     ; 398         CLK->SWCR |= CLK_SWCR_SWEN;
1239  014c 721250c5      	bset	20677,#1
1240                     ; 401         if (ITState != DISABLE)
1242  0150 7b09          	ld	a,(OFST+5,sp)
1243  0152 2706          	jreq	L325
1244                     ; 403             CLK->SWCR |= CLK_SWCR_SWIEN;
1246  0154 721450c5      	bset	20677,#2
1248  0158 2004          	jra	L525
1249  015a               L325:
1250                     ; 407             CLK->SWCR &= (u8)(~CLK_SWCR_SWIEN);
1252  015a 721550c5      	bres	20677,#2
1253  015e               L525:
1254                     ; 411         CLK->SWR = (u8)CLK_NewClock;
1256  015e 7b06          	ld	a,(OFST+2,sp)
1257  0160 c750c4        	ld	20676,a
1259  0163 2003          	jra	L335
1260  0165               L725:
1261                     ; 415             DownCounter--;
1263  0165 5a            	decw	x
1264  0166 1f03          	ldw	(OFST-1,sp),x
1265  0168               L335:
1266                     ; 413         while (((CLK->SWCR & CLK_SWCR_SWBSY) && (DownCounter != 0)))
1268  0168 720150c504    	btjf	20677,#0,L735
1270  016d 1e03          	ldw	x,(OFST-1,sp)
1271  016f 26f4          	jrne	L725
1272  0171               L735:
1273                     ; 418         if (DownCounter != 0)
1275  0171 1e03          	ldw	x,(OFST-1,sp)
1276                     ; 420             Swif = SUCCESS;
1278  0173 2617          	jrne	LC002
1279                     ; 424             Swif = ERROR;
1281  0175 0f02          	clr	(OFST-2,sp)
1282  0177 2017          	jra	L545
1283  0179               L125:
1284                     ; 432         if (ITState != DISABLE)
1286  0179 7b09          	ld	a,(OFST+5,sp)
1287  017b 2706          	jreq	L745
1288                     ; 434             CLK->SWCR |= CLK_SWCR_SWIEN;
1290  017d 721450c5      	bset	20677,#2
1292  0181 2004          	jra	L155
1293  0183               L745:
1294                     ; 438             CLK->SWCR &= (u8)(~CLK_SWCR_SWIEN);
1296  0183 721550c5      	bres	20677,#2
1297  0187               L155:
1298                     ; 442         CLK->SWR = (u8)CLK_NewClock;
1300  0187 7b06          	ld	a,(OFST+2,sp)
1301  0189 c750c4        	ld	20676,a
1302                     ; 446         Swif = SUCCESS;
1304  018c               LC002:
1306  018c a601          	ld	a,#1
1307  018e 6b02          	ld	(OFST-2,sp),a
1308  0190               L545:
1309                     ; 451     if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
1311  0190 7b0a          	ld	a,(OFST+6,sp)
1312  0192 260c          	jrne	L355
1314  0194 7b01          	ld	a,(OFST-3,sp)
1315  0196 a1e1          	cp	a,#225
1316  0198 2606          	jrne	L355
1317                     ; 453         CLK->ICKR &= (u8)(~CLK_ICKR_HSIEN);
1319  019a 721150c0      	bres	20672,#0
1321  019e 201e          	jra	L555
1322  01a0               L355:
1323                     ; 455     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
1325  01a0 7b0a          	ld	a,(OFST+6,sp)
1326  01a2 260c          	jrne	L755
1328  01a4 7b01          	ld	a,(OFST-3,sp)
1329  01a6 a1d2          	cp	a,#210
1330  01a8 2606          	jrne	L755
1331                     ; 457         CLK->ICKR &= (u8)(~CLK_ICKR_LSIEN);
1333  01aa 721750c0      	bres	20672,#3
1335  01ae 200e          	jra	L555
1336  01b0               L755:
1337                     ; 459     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
1339  01b0 7b0a          	ld	a,(OFST+6,sp)
1340  01b2 260a          	jrne	L555
1342  01b4 7b01          	ld	a,(OFST-3,sp)
1343  01b6 a1b4          	cp	a,#180
1344  01b8 2604          	jrne	L555
1345                     ; 461         CLK->ECKR &= (u8)(~CLK_ECKR_HSEEN);
1347  01ba 721150c1      	bres	20673,#0
1348  01be               L555:
1349                     ; 464     return(Swif);
1351  01be 7b02          	ld	a,(OFST-2,sp)
1354  01c0 5b06          	addw	sp,#6
1355  01c2 81            	ret	
1390                     	xdef	_CLKPrescTable
1391                     	xdef	_HSIDivFactor
1392                     	xdef	_CLK_GetFlagStatus
1393                     	xdef	_CLK_GetSYSCLKSource
1394                     	xdef	_CLK_GetClockFreq
1395                     	xdef	_CLK_SYSCLKConfig
1396                     	xdef	_CLK_CCOConfig
1397                     	xdef	_CLK_ClockSwitchConfig
1398                     	xdef	_CLK_CCOCmd
1399                     	xdef	_CLK_HSECmd
1400                     	xdef	_CLK_DeInit
1401                     	xref.b	c_lreg
1402                     	xref.b	c_x
1421                     	xref	c_ltor
1422                     	xref	c_ludv
1423                     	xref	c_rtol
1424                     	end
