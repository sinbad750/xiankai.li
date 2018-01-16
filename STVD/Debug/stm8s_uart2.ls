   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  55                     ; 46 void UART2_DeInit(void)
  55                     ; 47 {
  57                     	switch	.text
  58  0000               _UART2_DeInit:
  60       00000001      OFST:	set	1
  63                     ; 48     u8 dummy = 0;
  65                     ; 51     dummy = UART2->SR;
  67  0000 c65240        	ld	a,21056
  68                     ; 52     dummy = UART2->DR;
  70  0003 c65241        	ld	a,21057
  71                     ; 54     UART2->BRR2 = UART2_BRR2_RESET_VALUE;  /*< Set UART2_BRR2 to reset value 0x00 */
  73  0006 725f5243      	clr	21059
  74                     ; 55     UART2->BRR1 = UART2_BRR1_RESET_VALUE;  /*< Set UART2_BRR1 to reset value 0x00 */
  76  000a 725f5242      	clr	21058
  77                     ; 57     UART2->CR1 = UART2_CR1_RESET_VALUE; /*< Set UART2_CR1 to reset value 0x00  */
  79  000e 725f5244      	clr	21060
  80                     ; 58     UART2->CR2 = UART2_CR2_RESET_VALUE; /*< Set UART2_CR2 to reset value 0x00  */
  82  0012 725f5245      	clr	21061
  83                     ; 59     UART2->CR3 = UART2_CR3_RESET_VALUE;  /*< Set UART2_CR3 to reset value 0x00  */
  85  0016 725f5246      	clr	21062
  86                     ; 60     UART2->CR4 = UART2_CR4_RESET_VALUE;  /*< Set UART2_CR4 to reset value 0x00  */
  88  001a 725f5247      	clr	21063
  89                     ; 61     UART2->CR5 = UART2_CR5_RESET_VALUE; /*< Set UART2_CR5 to reset value 0x00  */
  91  001e 725f5248      	clr	21064
  92                     ; 62     UART2->CR6 = UART2_CR6_RESET_VALUE; /*< Set UART2_CR6 to reset value 0x00  */
  94  0022 725f5249      	clr	21065
  95                     ; 64 }
  98  0026 81            	ret	
 409                     .const:	section	.text
 410  0000               L41:
 411  0000 00000064      	dc.l	100
 412                     ; 76 void UART2_Init(u32 BaudRate, UART2_WordLength_TypeDef WordLength, UART2_StopBits_TypeDef StopBits, UART2_Parity_TypeDef Parity, UART2_SyncMode_TypeDef SyncMode, UART2_Mode_TypeDef Mode)
 412                     ; 77 {
 413                     	switch	.text
 414  0027               _UART2_Init:
 416       0000000e      OFST:	set	14
 419                     ; 78     u8 BRR2_1, BRR2_2 = 0;
 421                     ; 79     u32 BaudRate_Mantissa, BaudRate_Mantissa100 = 0;
 423                     ; 82     assert_param(IS_UART2_BAUDRATE_OK(BaudRate));
 425                     ; 84     assert_param(IS_UART2_WORDLENGTH_OK(WordLength));
 427                     ; 86     assert_param(IS_UART2_STOPBITS_OK(StopBits));
 429                     ; 88     assert_param(IS_UART2_PARITY_OK(Parity));
 431                     ; 91     assert_param(IS_UART2_MODE_OK((u8)Mode));
 433                     ; 95     assert_param(IS_UART2_SYNCMODE_OK((u8)SyncMode));
 435                     ; 97     UART2->CR1 &= (u8)(~UART2_CR1_M);  /**< Clear the word length bit */
 437  0027 72195244      	bres	21060,#4
 438  002b 520e          	subw	sp,#14
 439                     ; 98     UART2->CR1 |= (u8)WordLength; /**< Set the word length bit according to UART2_WordLength value */
 441  002d c65244        	ld	a,21060
 442  0030 1a15          	or	a,(OFST+7,sp)
 443  0032 c75244        	ld	21060,a
 444                     ; 100     UART2->CR3 &= (u8)(~UART2_CR3_STOP);  /**< Clear the STOP bits */
 446  0035 c65246        	ld	a,21062
 447  0038 a4cf          	and	a,#207
 448  003a c75246        	ld	21062,a
 449                     ; 101     UART2->CR3 |= (u8)StopBits;  /**< Set the STOP bits number according to UART2_StopBits value  */
 451  003d c65246        	ld	a,21062
 452  0040 1a16          	or	a,(OFST+8,sp)
 453  0042 c75246        	ld	21062,a
 454                     ; 103     UART2->CR1 &= (u8)(~(UART2_CR1_PCEN | UART2_CR1_PS  ));  /**< Clear the Parity Control bit */
 456  0045 c65244        	ld	a,21060
 457  0048 a4f9          	and	a,#249
 458  004a c75244        	ld	21060,a
 459                     ; 104     UART2->CR1 |= (u8)Parity;  /**< Set the Parity Control bit to UART2_Parity value */
 461  004d c65244        	ld	a,21060
 462  0050 1a17          	or	a,(OFST+9,sp)
 463  0052 c75244        	ld	21060,a
 464                     ; 106     UART2->BRR1 &= (u8)(~UART2_BRR1_DIVM);  /**< Clear the LSB mantissa of UARTDIV  */
 466  0055 725f5242      	clr	21058
 467                     ; 107     UART2->BRR2 &= (u8)(~UART2_BRR2_DIVM);  /**< Clear the MSB mantissa of UARTDIV  */
 469  0059 c65243        	ld	a,21059
 470  005c a40f          	and	a,#15
 471  005e c75243        	ld	21059,a
 472                     ; 108     UART2->BRR2 &= (u8)(~UART2_BRR2_DIVF);  /**< Clear the Fraction bits of UARTDIV */
 474  0061 c65243        	ld	a,21059
 475  0064 a4f0          	and	a,#240
 476  0066 c75243        	ld	21059,a
 477                     ; 111     BaudRate_Mantissa    = ((u32)CLK_GetClockFreq() / (BaudRate << 4));
 479  0069 96            	ldw	x,sp
 480  006a 1c0011        	addw	x,#OFST+3
 481  006d cd0000        	call	c_ltor
 483  0070 a604          	ld	a,#4
 484  0072 cd0000        	call	c_llsh
 486  0075 96            	ldw	x,sp
 487  0076 5c            	incw	x
 488  0077 cd0000        	call	c_rtol
 490  007a cd0000        	call	_CLK_GetClockFreq
 492  007d 96            	ldw	x,sp
 493  007e 5c            	incw	x
 494  007f cd0000        	call	c_ludv
 496  0082 96            	ldw	x,sp
 497  0083 1c000b        	addw	x,#OFST-3
 498  0086 cd0000        	call	c_rtol
 500                     ; 112     BaudRate_Mantissa100 = (((u32)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 502  0089 96            	ldw	x,sp
 503  008a 1c0011        	addw	x,#OFST+3
 504  008d cd0000        	call	c_ltor
 506  0090 a604          	ld	a,#4
 507  0092 cd0000        	call	c_llsh
 509  0095 96            	ldw	x,sp
 510  0096 5c            	incw	x
 511  0097 cd0000        	call	c_rtol
 513  009a cd0000        	call	_CLK_GetClockFreq
 515  009d a664          	ld	a,#100
 516  009f cd0000        	call	c_smul
 518  00a2 96            	ldw	x,sp
 519  00a3 5c            	incw	x
 520  00a4 cd0000        	call	c_ludv
 522  00a7 96            	ldw	x,sp
 523  00a8 1c0007        	addw	x,#OFST-7
 524  00ab cd0000        	call	c_rtol
 526                     ; 114     BRR2_1 = (u8)((u8)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
 526                     ; 115                         << 4) / 100) & (u8)0x0F); /**< Set the fraction of UARTDIV  */
 528  00ae 96            	ldw	x,sp
 529  00af 1c000b        	addw	x,#OFST-3
 530  00b2 cd0000        	call	c_ltor
 532  00b5 a664          	ld	a,#100
 533  00b7 cd0000        	call	c_smul
 535  00ba 96            	ldw	x,sp
 536  00bb 5c            	incw	x
 537  00bc cd0000        	call	c_rtol
 539  00bf 96            	ldw	x,sp
 540  00c0 1c0007        	addw	x,#OFST-7
 541  00c3 cd0000        	call	c_ltor
 543  00c6 96            	ldw	x,sp
 544  00c7 5c            	incw	x
 545  00c8 cd0000        	call	c_lsub
 547  00cb a604          	ld	a,#4
 548  00cd cd0000        	call	c_llsh
 550  00d0 ae0000        	ldw	x,#L41
 551  00d3 cd0000        	call	c_ludv
 553  00d6 b603          	ld	a,c_lreg+3
 554  00d8 a40f          	and	a,#15
 555  00da 6b05          	ld	(OFST-9,sp),a
 556                     ; 116     BRR2_2 = (u8)((BaudRate_Mantissa >> 4) & (u8)0xF0);
 558  00dc 96            	ldw	x,sp
 559  00dd 1c000b        	addw	x,#OFST-3
 560  00e0 cd0000        	call	c_ltor
 562  00e3 a604          	ld	a,#4
 563  00e5 cd0000        	call	c_lursh
 565  00e8 b603          	ld	a,c_lreg+3
 566  00ea a4f0          	and	a,#240
 567  00ec b703          	ld	c_lreg+3,a
 568  00ee 3f02          	clr	c_lreg+2
 569  00f0 3f01          	clr	c_lreg+1
 570  00f2 3f00          	clr	c_lreg
 571  00f4 6b06          	ld	(OFST-8,sp),a
 572                     ; 118     UART2->BRR2 = (u8)(BRR2_1 | BRR2_2);
 574  00f6 1a05          	or	a,(OFST-9,sp)
 575  00f8 c75243        	ld	21059,a
 576                     ; 119     UART2->BRR1 = (u8)BaudRate_Mantissa;           /**< Set the LSB mantissa of UARTDIV  */
 578  00fb 7b0e          	ld	a,(OFST+0,sp)
 579  00fd c75242        	ld	21058,a
 580                     ; 121     UART2->CR2 &= (u8)~(UART2_CR2_TEN | UART2_CR2_REN); /**< Disable the Transmitter and Receiver before seting the LBCL, CPOL and CPHA bits */
 582  0100 c65245        	ld	a,21061
 583  0103 a4f3          	and	a,#243
 584  0105 c75245        	ld	21061,a
 585                     ; 122     UART2->CR3 &= (u8)~(UART2_CR3_CPOL | UART2_CR3_CPHA | UART2_CR3_LBCL); /**< Clear the Clock Polarity, lock Phase, Last Bit Clock pulse */
 587  0108 c65246        	ld	a,21062
 588  010b a4f8          	and	a,#248
 589  010d c75246        	ld	21062,a
 590                     ; 123     UART2->CR3 |= (u8)((u8)SyncMode & (u8)(UART2_CR3_CPOL | UART2_CR3_CPHA | UART2_CR3_LBCL));  /**< Set the Clock Polarity, lock Phase, Last Bit Clock pulse */
 592  0110 7b18          	ld	a,(OFST+10,sp)
 593  0112 a407          	and	a,#7
 594  0114 ca5246        	or	a,21062
 595  0117 c75246        	ld	21062,a
 596                     ; 125     if ((u8)Mode & (u8)UART2_MODE_TX_ENABLE)
 598  011a 7b19          	ld	a,(OFST+11,sp)
 599  011c a504          	bcp	a,#4
 600  011e 2706          	jreq	L571
 601                     ; 127         UART2->CR2 |= (u8)UART2_CR2_TEN;  /**< Set the Transmitter Enable bit */
 603  0120 72165245      	bset	21061,#3
 605  0124 2004          	jra	L771
 606  0126               L571:
 607                     ; 131         UART2->CR2 &= (u8)(~UART2_CR2_TEN);  /**< Clear the Transmitter Disable bit */
 609  0126 72175245      	bres	21061,#3
 610  012a               L771:
 611                     ; 133     if ((u8)Mode & (u8)UART2_MODE_RX_ENABLE)
 613  012a a508          	bcp	a,#8
 614  012c 2706          	jreq	L102
 615                     ; 135         UART2->CR2 |= (u8)UART2_CR2_REN;  /**< Set the Receiver Enable bit */
 617  012e 72145245      	bset	21061,#2
 619  0132 2004          	jra	L302
 620  0134               L102:
 621                     ; 139         UART2->CR2 &= (u8)(~UART2_CR2_REN);  /**< Clear the Receiver Disable bit */
 623  0134 72155245      	bres	21061,#2
 624  0138               L302:
 625                     ; 142     if ((u8)SyncMode&(u8)UART2_SYNCMODE_CLOCK_DISABLE)
 627  0138 7b18          	ld	a,(OFST+10,sp)
 628  013a 2a06          	jrpl	L502
 629                     ; 144         UART2->CR3 &= (u8)(~UART2_CR3_CKEN); /**< Clear the Clock Enable bit */
 631  013c 72175246      	bres	21062,#3
 633  0140 2008          	jra	L702
 634  0142               L502:
 635                     ; 149         UART2->CR3 |= (u8)((u8)SyncMode & UART2_CR3_CKEN);
 637  0142 a408          	and	a,#8
 638  0144 ca5246        	or	a,21062
 639  0147 c75246        	ld	21062,a
 640  014a               L702:
 641                     ; 151 }
 644  014a 5b0e          	addw	sp,#14
 645  014c 81            	ret	
 700                     ; 162 void UART2_Cmd(FunctionalState NewState)
 700                     ; 163 {
 701                     	switch	.text
 702  014d               _UART2_Cmd:
 706                     ; 165     if (NewState != DISABLE)
 708  014d 4d            	tnz	a
 709  014e 2705          	jreq	L732
 710                     ; 167         UART2->CR1 &= (u8)(~UART2_CR1_UARTD); /**< UART2 Enable */
 712  0150 721b5244      	bres	21060,#5
 715  0154 81            	ret	
 716  0155               L732:
 717                     ; 171         UART2->CR1 |= UART2_CR1_UARTD;  /**< UART2 Disable (for low power consumption) */
 719  0155 721a5244      	bset	21060,#5
 720                     ; 173 }
 723  0159 81            	ret	
 851                     ; 192 void UART2_ITConfig(UART2_IT_TypeDef UART2_IT, FunctionalState NewState)
 851                     ; 193 {
 852                     	switch	.text
 853  015a               _UART2_ITConfig:
 855  015a 89            	pushw	x
 856  015b 89            	pushw	x
 857       00000002      OFST:	set	2
 860                     ; 194     u8 uartreg, itpos = 0x00;
 862                     ; 195     assert_param(IS_UART2_CONFIG_IT_OK(UART2_IT));
 864                     ; 196     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 866                     ; 199     uartreg = (u8)(UART2_IT >> 0x08);
 868  015c 9e            	ld	a,xh
 869  015d 6b01          	ld	(OFST-1,sp),a
 870                     ; 202     itpos = (u8)((u8)1 << (u8)((u8)UART2_IT & (u8)0x0F));
 872  015f 9f            	ld	a,xl
 873  0160 a40f          	and	a,#15
 874  0162 5f            	clrw	x
 875  0163 97            	ld	xl,a
 876  0164 a601          	ld	a,#1
 877  0166 5d            	tnzw	x
 878  0167 2704          	jreq	L22
 879  0169               L42:
 880  0169 48            	sll	a
 881  016a 5a            	decw	x
 882  016b 26fc          	jrne	L42
 883  016d               L22:
 884  016d 6b02          	ld	(OFST+0,sp),a
 885                     ; 204     if (NewState != DISABLE)
 887  016f 7b07          	ld	a,(OFST+5,sp)
 888  0171 272a          	jreq	L713
 889                     ; 207         if (uartreg == 0x01)
 891  0173 7b01          	ld	a,(OFST-1,sp)
 892  0175 a101          	cp	a,#1
 893  0177 2607          	jrne	L123
 894                     ; 209             UART2->CR1 |= itpos;
 896  0179 c65244        	ld	a,21060
 897  017c 1a02          	or	a,(OFST+0,sp)
 899  017e 2029          	jp	LC003
 900  0180               L123:
 901                     ; 211         else if (uartreg == 0x02)
 903  0180 a102          	cp	a,#2
 904  0182 2607          	jrne	L523
 905                     ; 213             UART2->CR2 |= itpos;
 907  0184 c65245        	ld	a,21061
 908  0187 1a02          	or	a,(OFST+0,sp)
 910  0189 202d          	jp	LC002
 911  018b               L523:
 912                     ; 215         else if (uartreg == 0x03)
 914  018b a103          	cp	a,#3
 915  018d 2607          	jrne	L133
 916                     ; 217             UART2->CR4 |= itpos;
 918  018f c65247        	ld	a,21063
 919  0192 1a02          	or	a,(OFST+0,sp)
 921  0194 2031          	jp	LC004
 922  0196               L133:
 923                     ; 221             UART2->CR6 |= itpos;
 925  0196 c65249        	ld	a,21065
 926  0199 1a02          	or	a,(OFST+0,sp)
 927  019b 2035          	jp	LC001
 928  019d               L713:
 929                     ; 227         if (uartreg == 0x01)
 931  019d 7b01          	ld	a,(OFST-1,sp)
 932  019f a101          	cp	a,#1
 933  01a1 260b          	jrne	L733
 934                     ; 229             UART2->CR1 &= (u8)(~itpos);
 936  01a3 7b02          	ld	a,(OFST+0,sp)
 937  01a5 43            	cpl	a
 938  01a6 c45244        	and	a,21060
 939  01a9               LC003:
 940  01a9 c75244        	ld	21060,a
 942  01ac 2027          	jra	L533
 943  01ae               L733:
 944                     ; 231         else if (uartreg == 0x02)
 946  01ae a102          	cp	a,#2
 947  01b0 260b          	jrne	L343
 948                     ; 233             UART2->CR2 &= (u8)(~itpos);
 950  01b2 7b02          	ld	a,(OFST+0,sp)
 951  01b4 43            	cpl	a
 952  01b5 c45245        	and	a,21061
 953  01b8               LC002:
 954  01b8 c75245        	ld	21061,a
 956  01bb 2018          	jra	L533
 957  01bd               L343:
 958                     ; 235         else if (uartreg == 0x03)
 960  01bd a103          	cp	a,#3
 961  01bf 260b          	jrne	L743
 962                     ; 237             UART2->CR4 &= (u8)(~itpos);
 964  01c1 7b02          	ld	a,(OFST+0,sp)
 965  01c3 43            	cpl	a
 966  01c4 c45247        	and	a,21063
 967  01c7               LC004:
 968  01c7 c75247        	ld	21063,a
 970  01ca 2009          	jra	L533
 971  01cc               L743:
 972                     ; 241             UART2->CR6 &= (u8)(~itpos);
 974  01cc 7b02          	ld	a,(OFST+0,sp)
 975  01ce 43            	cpl	a
 976  01cf c45249        	and	a,21065
 977  01d2               LC001:
 978  01d2 c75249        	ld	21065,a
 979  01d5               L533:
 980                     ; 244 }
 983  01d5 5b04          	addw	sp,#4
 984  01d7 81            	ret	
1041                     ; 254 void UART2_IrDAConfig(UART2_IrDAMode_TypeDef UART2_IrDAMode)
1041                     ; 255 {
1042                     	switch	.text
1043  01d8               _UART2_IrDAConfig:
1047                     ; 256     assert_param(IS_UART2_IRDAMODE_OK(UART2_IrDAMode));
1049                     ; 258     if (UART2_IrDAMode != UART2_IRDAMODE_NORMAL)
1051  01d8 4d            	tnz	a
1052  01d9 2705          	jreq	L104
1053                     ; 260         UART2->CR5 |= UART2_CR5_IRLP;
1055  01db 72145248      	bset	21064,#2
1058  01df 81            	ret	
1059  01e0               L104:
1060                     ; 264         UART2->CR5 &= ((u8)~UART2_CR5_IRLP);
1062  01e0 72155248      	bres	21064,#2
1063                     ; 266 }
1066  01e4 81            	ret	
1101                     ; 277 void UART2_IrDACmd(FunctionalState NewState)
1101                     ; 278 {
1102                     	switch	.text
1103  01e5               _UART2_IrDACmd:
1107                     ; 281     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1109                     ; 283     if (NewState != DISABLE)
1111  01e5 4d            	tnz	a
1112  01e6 2705          	jreq	L324
1113                     ; 286         UART2->CR5 |= UART2_CR5_IREN;
1115  01e8 72125248      	bset	21064,#1
1118  01ec 81            	ret	
1119  01ed               L324:
1120                     ; 291         UART2->CR5 &= ((u8)~UART2_CR5_IREN);
1122  01ed 72135248      	bres	21064,#1
1123                     ; 293 }
1126  01f1 81            	ret	
1185                     ; 303 void UART2_LINBreakDetectionConfig(UART2_LINBreakDetectionLength_TypeDef UART2_LINBreakDetectionLength)
1185                     ; 304 {
1186                     	switch	.text
1187  01f2               _UART2_LINBreakDetectionConfig:
1191                     ; 305     assert_param(IS_UART2_LINBREAKDETECTIONLENGTH_OK(UART2_LINBreakDetectionLength));
1193                     ; 307     if (UART2_LINBreakDetectionLength != UART2_LINBREAKDETECTIONLENGTH_10BITS)
1195  01f2 4d            	tnz	a
1196  01f3 2705          	jreq	L554
1197                     ; 309         UART2->CR4 |= UART2_CR4_LBDL;
1199  01f5 721a5247      	bset	21063,#5
1202  01f9 81            	ret	
1203  01fa               L554:
1204                     ; 313         UART2->CR4 &= ((u8)~UART2_CR4_LBDL);
1206  01fa 721b5247      	bres	21063,#5
1207                     ; 315 }
1210  01fe 81            	ret	
1331                     ; 329 void UART2_LINConfig(UART2_LinMode_TypeDef UART2_Mode, UART2_LinAutosync_TypeDef UART2_Autosync, UART2_LinDivUp_TypeDef UART2_DivUp)
1331                     ; 330 {
1332                     	switch	.text
1333  01ff               _UART2_LINConfig:
1335  01ff 89            	pushw	x
1336       00000000      OFST:	set	0
1339                     ; 331     assert_param(IS_UART2_SLAVE_OK(UART2_Mode));
1341                     ; 333     assert_param(IS_UART2_AUTOSYNC_OK(UART2_Autosync));
1343                     ; 335     assert_param(IS_UART2_DIVUP_OK(UART2_DivUp));
1345                     ; 337     if (UART2_Mode != UART2_LIN_MODE_MASTER)
1347  0200 9e            	ld	a,xh
1348  0201 4d            	tnz	a
1349  0202 2706          	jreq	L735
1350                     ; 339         UART2->CR6 |=  UART2_CR6_LSLV;
1352  0204 721a5249      	bset	21065,#5
1354  0208 2004          	jra	L145
1355  020a               L735:
1356                     ; 343         UART2->CR6 &= ((u8)~UART2_CR6_LSLV);
1358  020a 721b5249      	bres	21065,#5
1359  020e               L145:
1360                     ; 346     if (UART2_Autosync != UART2_LIN_AUTOSYNC_DISABLE)
1362  020e 7b02          	ld	a,(OFST+2,sp)
1363  0210 2706          	jreq	L345
1364                     ; 348         UART2->CR6 |=  UART2_CR6_LASE ;
1366  0212 72185249      	bset	21065,#4
1368  0216 2004          	jra	L545
1369  0218               L345:
1370                     ; 352         UART2->CR6 &= ((u8)~ UART2_CR6_LASE );
1372  0218 72195249      	bres	21065,#4
1373  021c               L545:
1374                     ; 355     if (UART2_DivUp != UART2_LIN_DIVUP_LBRR1)
1376  021c 7b05          	ld	a,(OFST+5,sp)
1377  021e 2706          	jreq	L745
1378                     ; 357         UART2->CR6 |=  UART2_CR6_LDUM;
1380  0220 721e5249      	bset	21065,#7
1382  0224 2004          	jra	L155
1383  0226               L745:
1384                     ; 361         UART2->CR6 &= ((u8)~ UART2_CR6_LDUM);
1386  0226 721f5249      	bres	21065,#7
1387  022a               L155:
1388                     ; 364 }
1391  022a 85            	popw	x
1392  022b 81            	ret	
1427                     ; 376 void UART2_LINCmd(FunctionalState NewState)
1427                     ; 377 {
1428                     	switch	.text
1429  022c               _UART2_LINCmd:
1433                     ; 378     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1435                     ; 380     if (NewState != DISABLE)
1437  022c 4d            	tnz	a
1438  022d 2705          	jreq	L175
1439                     ; 383         UART2->CR3 |= UART2_CR3_LINEN;
1441  022f 721c5246      	bset	21062,#6
1444  0233 81            	ret	
1445  0234               L175:
1446                     ; 388         UART2->CR3 &= ((u8)~UART2_CR3_LINEN);
1448  0234 721d5246      	bres	21062,#6
1449                     ; 390 }
1452  0238 81            	ret	
1487                     ; 400 void UART2_SmartCardCmd(FunctionalState NewState)
1487                     ; 401 {
1488                     	switch	.text
1489  0239               _UART2_SmartCardCmd:
1493                     ; 402     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1495                     ; 404     if (NewState != DISABLE)
1497  0239 4d            	tnz	a
1498  023a 2705          	jreq	L316
1499                     ; 407         UART2->CR5 |= UART2_CR5_SCEN;
1501  023c 721a5248      	bset	21064,#5
1504  0240 81            	ret	
1505  0241               L316:
1506                     ; 412         UART2->CR5 &= ((u8)(~UART2_CR5_SCEN));
1508  0241 721b5248      	bres	21064,#5
1509                     ; 414 }
1512  0245 81            	ret	
1548                     ; 425 void UART2_SmartCardNACKCmd(FunctionalState NewState)
1548                     ; 426 {
1549                     	switch	.text
1550  0246               _UART2_SmartCardNACKCmd:
1554                     ; 427     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1556                     ; 429     if (NewState != DISABLE)
1558  0246 4d            	tnz	a
1559  0247 2705          	jreq	L536
1560                     ; 432         UART2->CR5 |= UART2_CR5_NACK;
1562  0249 72185248      	bset	21064,#4
1565  024d 81            	ret	
1566  024e               L536:
1567                     ; 437         UART2->CR5 &= ((u8)~(UART2_CR5_NACK));
1569  024e 72195248      	bres	21064,#4
1570                     ; 439 }
1573  0252 81            	ret	
1630                     ; 448 void UART2_WakeUpConfig(UART2_WakeUp_TypeDef UART2_WakeUp)
1630                     ; 449 {
1631                     	switch	.text
1632  0253               _UART2_WakeUpConfig:
1636                     ; 450     assert_param(IS_UART2_WAKEUP_OK(UART2_WakeUp));
1638                     ; 452     UART2->CR1 &= ((u8)~UART2_CR1_WAKE);
1640  0253 72175244      	bres	21060,#3
1641                     ; 453     UART2->CR1 |= (u8)UART2_WakeUp;
1643  0257 ca5244        	or	a,21060
1644  025a c75244        	ld	21060,a
1645                     ; 454 }
1648  025d 81            	ret	
1684                     ; 466 void UART2_ReceiverWakeUpCmd(FunctionalState NewState)
1684                     ; 467 {
1685                     	switch	.text
1686  025e               _UART2_ReceiverWakeUpCmd:
1690                     ; 468     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1692                     ; 470     if (NewState != DISABLE)
1694  025e 4d            	tnz	a
1695  025f 2705          	jreq	L507
1696                     ; 473         UART2->CR2 |= UART2_CR2_RWU;
1698  0261 72125245      	bset	21061,#1
1701  0265 81            	ret	
1702  0266               L507:
1703                     ; 478         UART2->CR2 &= ((u8)~UART2_CR2_RWU);
1705  0266 72135245      	bres	21061,#1
1706                     ; 480 }
1709  026a 81            	ret	
1732                     ; 491 u8 UART2_ReceiveData8(void)
1732                     ; 492 {
1733                     	switch	.text
1734  026b               _UART2_ReceiveData8:
1738                     ; 493     return ((u8)UART2->DR);
1740  026b c65241        	ld	a,21057
1743  026e 81            	ret	
1766                     ; 504 u16 UART2_ReceiveData9(void)
1766                     ; 505 {
1767                     	switch	.text
1768  026f               _UART2_ReceiveData9:
1770  026f 89            	pushw	x
1771       00000002      OFST:	set	2
1774                     ; 506     return (u16)((((u16)UART2->DR) | ((u16)(((u16)((u16)UART2->CR1 & (u16)UART2_CR1_R8)) << 1))) & ((u16)0x01FF));
1776  0270 c65244        	ld	a,21060
1777  0273 a480          	and	a,#128
1778  0275 5f            	clrw	x
1779  0276 02            	rlwa	x,a
1780  0277 58            	sllw	x
1781  0278 1f01          	ldw	(OFST-1,sp),x
1782  027a 5f            	clrw	x
1783  027b c65241        	ld	a,21057
1784  027e 97            	ld	xl,a
1785  027f 01            	rrwa	x,a
1786  0280 1a02          	or	a,(OFST+0,sp)
1787  0282 01            	rrwa	x,a
1788  0283 1a01          	or	a,(OFST-1,sp)
1789  0285 a401          	and	a,#1
1790  0287 01            	rrwa	x,a
1793  0288 5b02          	addw	sp,#2
1794  028a 81            	ret	
1826                     ; 520 void UART2_SendData8(u8 Data)
1826                     ; 521 {
1827                     	switch	.text
1828  028b               _UART2_SendData8:
1832                     ; 523     UART2->DR = Data;
1834  028b c75241        	ld	21057,a
1835                     ; 524 }
1838  028e 81            	ret	
1870                     ; 535 void UART2_SendData9(u16 Data)
1870                     ; 536 {
1871                     	switch	.text
1872  028f               _UART2_SendData9:
1874  028f 89            	pushw	x
1875       00000000      OFST:	set	0
1878                     ; 537     UART2->CR1 &= ((u8)~UART2_CR1_T8);                  /* Clear the transmit data bit 8     */
1880  0290 721d5244      	bres	21060,#6
1881                     ; 538     UART2->CR1 |= (u8)(((u8)(Data >> 2)) & UART2_CR1_T8); /* Write the transmit data bit [8]   */
1883  0294 54            	srlw	x
1884  0295 54            	srlw	x
1885  0296 9f            	ld	a,xl
1886  0297 a440          	and	a,#64
1887  0299 ca5244        	or	a,21060
1888  029c c75244        	ld	21060,a
1889                     ; 539     UART2->DR   = (u8)(Data);                    /* Write the transmit data bit [0:7] */
1891  029f 7b02          	ld	a,(OFST+2,sp)
1892  02a1 c75241        	ld	21057,a
1893                     ; 541 }
1896  02a4 85            	popw	x
1897  02a5 81            	ret	
1920                     ; 548 void UART2_SendBreak(void)
1920                     ; 549 {
1921                     	switch	.text
1922  02a6               _UART2_SendBreak:
1926                     ; 550     UART2->CR2 |= UART2_CR2_SBK;
1928  02a6 72105245      	bset	21061,#0
1929                     ; 551 }
1932  02aa 81            	ret	
1964                     ; 560 void UART2_SetAddress(u8 UART2_Address)
1964                     ; 561 {
1965                     	switch	.text
1966  02ab               _UART2_SetAddress:
1968  02ab 88            	push	a
1969       00000000      OFST:	set	0
1972                     ; 563     assert_param(IS_UART2_ADDRESS_OK(UART2_Address));
1974                     ; 566     UART2->CR4 &= ((u8)~UART2_CR4_ADD);
1976  02ac c65247        	ld	a,21063
1977  02af a4f0          	and	a,#240
1978  02b1 c75247        	ld	21063,a
1979                     ; 568     UART2->CR4 |= UART2_Address;
1981  02b4 c65247        	ld	a,21063
1982  02b7 1a01          	or	a,(OFST+1,sp)
1983  02b9 c75247        	ld	21063,a
1984                     ; 569 }
1987  02bc 84            	pop	a
1988  02bd 81            	ret	
2020                     ; 580 void UART2_SetGuardTime(u8 UART2_GuardTime)
2020                     ; 581 {
2021                     	switch	.text
2022  02be               _UART2_SetGuardTime:
2026                     ; 583     UART2->GTR = UART2_GuardTime;
2028  02be c7524a        	ld	21066,a
2029                     ; 584 }
2032  02c1 81            	ret	
2064                     ; 610 void UART2_SetPrescaler(u8 UART2_Prescaler)
2064                     ; 611 {
2065                     	switch	.text
2066  02c2               _UART2_SetPrescaler:
2070                     ; 613     UART2->PSCR = UART2_Prescaler;
2072  02c2 c7524b        	ld	21067,a
2073                     ; 614 }
2076  02c5 81            	ret	
2233                     ; 625 FlagStatus UART2_GetFlagStatus(UART2_Flag_TypeDef UART2_FLAG)
2233                     ; 626 {
2234                     	switch	.text
2235  02c6               _UART2_GetFlagStatus:
2237  02c6 89            	pushw	x
2238  02c7 88            	push	a
2239       00000001      OFST:	set	1
2242                     ; 627     FlagStatus status = RESET;
2244                     ; 630     assert_param(IS_UART2_FLAG_OK(UART2_FLAG));
2246                     ; 633     if (UART2_FLAG == UART2_FLAG_LBDF)
2248  02c8 a30210        	cpw	x,#528
2249  02cb 2608          	jrne	L3211
2250                     ; 635         if ((UART2->CR4 & (u8)UART2_FLAG) != (u8)0x00)
2252  02cd 9f            	ld	a,xl
2253  02ce c45247        	and	a,21063
2254  02d1 2728          	jreq	L1311
2255                     ; 638             status = SET;
2257  02d3 2021          	jp	LC007
2258                     ; 643             status = RESET;
2259  02d5               L3211:
2260                     ; 646     else if (UART2_FLAG == UART2_FLAG_SBK)
2262  02d5 1e02          	ldw	x,(OFST+1,sp)
2263  02d7 a30101        	cpw	x,#257
2264  02da 2609          	jrne	L3311
2265                     ; 648         if ((UART2->CR2 & (u8)UART2_FLAG) != (u8)0x00)
2267  02dc c65245        	ld	a,21061
2268  02df 1503          	bcp	a,(OFST+2,sp)
2269  02e1 2717          	jreq	L7411
2270                     ; 651             status = SET;
2272  02e3 2011          	jp	LC007
2273                     ; 656             status = RESET;
2274  02e5               L3311:
2275                     ; 659     else if ((UART2_FLAG == UART2_FLAG_LHDF) || (UART2_FLAG == UART2_FLAG_LSF))
2277  02e5 a30302        	cpw	x,#770
2278  02e8 2705          	jreq	L5411
2280  02ea a30301        	cpw	x,#769
2281  02ed 260f          	jrne	L3411
2282  02ef               L5411:
2283                     ; 661         if ((UART2->CR6 & (u8)UART2_FLAG) != (u8)0x00)
2285  02ef c65249        	ld	a,21065
2286  02f2 1503          	bcp	a,(OFST+2,sp)
2287  02f4 2704          	jreq	L7411
2288                     ; 664             status = SET;
2290  02f6               LC007:
2294  02f6 a601          	ld	a,#1
2297  02f8 2001          	jra	L1311
2298  02fa               L7411:
2299                     ; 669             status = RESET;
2303  02fa 4f            	clr	a
2304  02fb               L1311:
2305                     ; 687     return  status;
2309  02fb 5b03          	addw	sp,#3
2310  02fd 81            	ret	
2311  02fe               L3411:
2312                     ; 674         if ((UART2->SR & (u8)UART2_FLAG) != (u8)0x00)
2314  02fe c65240        	ld	a,21056
2315  0301 1503          	bcp	a,(OFST+2,sp)
2316  0303 27f5          	jreq	L7411
2317                     ; 677             status = SET;
2319  0305 20ef          	jp	LC007
2320                     ; 682             status = RESET;
2355                     ; 715 void UART2_ClearFlag(UART2_Flag_TypeDef UART2_FLAG)
2355                     ; 716 {
2356                     	switch	.text
2357  0307               _UART2_ClearFlag:
2359  0307 89            	pushw	x
2360       00000000      OFST:	set	0
2363                     ; 717     assert_param(IS_UART2_CLEAR_FLAG_OK(UART2_FLAG));
2365                     ; 720     if (UART2_FLAG == UART2_FLAG_RXNE)
2367  0308 a30020        	cpw	x,#32
2368  030b 2606          	jrne	L7711
2369                     ; 722         UART2->SR = (u8)~(UART2_SR_RXNE);
2371  030d 35df5240      	mov	21056,#223
2373  0311 201c          	jra	L1021
2374  0313               L7711:
2375                     ; 725     else if (UART2_FLAG == UART2_FLAG_LBDF)
2377  0313 1e01          	ldw	x,(OFST+1,sp)
2378  0315 a30210        	cpw	x,#528
2379  0318 2606          	jrne	L3021
2380                     ; 727         UART2->CR4 &= (u8)(~UART2_CR4_LBDF);
2382  031a 72195247      	bres	21063,#4
2384  031e 200f          	jra	L1021
2385  0320               L3021:
2386                     ; 730     else if (UART2_FLAG == UART2_FLAG_LHDF)
2388  0320 a30302        	cpw	x,#770
2389  0323 2606          	jrne	L7021
2390                     ; 732         UART2->CR6 &= (u8)(~UART2_CR6_LHDF);
2392  0325 72135249      	bres	21065,#1
2394  0329 2004          	jra	L1021
2395  032b               L7021:
2396                     ; 737         UART2->CR6 &= (u8)(~UART2_CR6_LSF);
2398  032b 72115249      	bres	21065,#0
2399  032f               L1021:
2400                     ; 740 }
2403  032f 85            	popw	x
2404  0330 81            	ret	
2478                     ; 758 ITStatus UART2_GetITStatus(UART2_IT_TypeDef UART2_IT)
2478                     ; 759 {
2479                     	switch	.text
2480  0331               _UART2_GetITStatus:
2482  0331 89            	pushw	x
2483  0332 89            	pushw	x
2484       00000002      OFST:	set	2
2487                     ; 760     ITStatus pendingbitstatus = RESET;
2489                     ; 761     u8 itpos = 0;
2491                     ; 762     u8 itmask1 = 0;
2493                     ; 763     u8 itmask2 = 0;
2495                     ; 764     u8 enablestatus = 0;
2497                     ; 767     assert_param(IS_UART2_GET_IT_OK(UART2_IT));
2499                     ; 770     itpos = (u8)((u8)1 << (u8)((u8)UART2_IT & (u8)0x0F));
2501  0333 9f            	ld	a,xl
2502  0334 a40f          	and	a,#15
2503  0336 5f            	clrw	x
2504  0337 97            	ld	xl,a
2505  0338 a601          	ld	a,#1
2506  033a 5d            	tnzw	x
2507  033b 2704          	jreq	L67
2508  033d               L001:
2509  033d 48            	sll	a
2510  033e 5a            	decw	x
2511  033f 26fc          	jrne	L001
2512  0341               L67:
2513  0341 6b01          	ld	(OFST-1,sp),a
2514                     ; 772     itmask1 = (u8)((u8)UART2_IT >> (u8)4);
2516  0343 7b04          	ld	a,(OFST+2,sp)
2517  0345 4e            	swap	a
2518  0346 a40f          	and	a,#15
2519  0348 6b02          	ld	(OFST+0,sp),a
2520                     ; 774     itmask2 = (u8)((u8)1 << itmask1);
2522  034a 5f            	clrw	x
2523  034b 97            	ld	xl,a
2524  034c a601          	ld	a,#1
2525  034e 5d            	tnzw	x
2526  034f 2704          	jreq	L201
2527  0351               L401:
2528  0351 48            	sll	a
2529  0352 5a            	decw	x
2530  0353 26fc          	jrne	L401
2531  0355               L201:
2532  0355 6b02          	ld	(OFST+0,sp),a
2533                     ; 779     if (UART2_IT == UART2_IT_PE)
2535  0357 1e03          	ldw	x,(OFST+1,sp)
2536  0359 a30100        	cpw	x,#256
2537  035c 260c          	jrne	L5421
2538                     ; 782         enablestatus = (u8)((u8)UART2->CR1 & itmask2);
2540  035e c65244        	ld	a,21060
2541  0361 1402          	and	a,(OFST+0,sp)
2542  0363 6b02          	ld	(OFST+0,sp),a
2543                     ; 785         if (((UART2->SR & itpos) != (u8)0x00) && enablestatus)
2545  0365 c65240        	ld	a,21056
2547                     ; 788             pendingbitstatus = SET;
2549  0368 2020          	jp	LC010
2550                     ; 793             pendingbitstatus = RESET;
2551  036a               L5421:
2552                     ; 797     else if (UART2_IT == UART2_IT_LBDF)
2554  036a a30346        	cpw	x,#838
2555  036d 260c          	jrne	L5521
2556                     ; 800         enablestatus = (u8)((u8)UART2->CR4 & itmask2);
2558  036f c65247        	ld	a,21063
2559  0372 1402          	and	a,(OFST+0,sp)
2560  0374 6b02          	ld	(OFST+0,sp),a
2561                     ; 802         if (((UART2->CR4 & itpos) != (u8)0x00) && enablestatus)
2563  0376 c65247        	ld	a,21063
2565                     ; 805             pendingbitstatus = SET;
2567  0379 200f          	jp	LC010
2568                     ; 810             pendingbitstatus = RESET;
2569  037b               L5521:
2570                     ; 813     else if (UART2_IT == UART2_IT_LHDF)
2572  037b a30412        	cpw	x,#1042
2573  037e 2616          	jrne	L5621
2574                     ; 816         enablestatus = (u8)((u8)UART2->CR6 & itmask2);
2576  0380 c65249        	ld	a,21065
2577  0383 1402          	and	a,(OFST+0,sp)
2578  0385 6b02          	ld	(OFST+0,sp),a
2579                     ; 818         if (((UART2->CR6 & itpos) != (u8)0x00) && enablestatus)
2581  0387 c65249        	ld	a,21065
2583  038a               LC010:
2584  038a 1501          	bcp	a,(OFST-1,sp)
2585  038c 271a          	jreq	L5721
2586  038e 7b02          	ld	a,(OFST+0,sp)
2587  0390 2716          	jreq	L5721
2588                     ; 821             pendingbitstatus = SET;
2590  0392               LC009:
2594  0392 a601          	ld	a,#1
2596  0394 2013          	jra	L3521
2597                     ; 826             pendingbitstatus = RESET;
2598  0396               L5621:
2599                     ; 832         enablestatus = (u8)((u8)UART2->CR2 & itmask2);
2601  0396 c65245        	ld	a,21061
2602  0399 1402          	and	a,(OFST+0,sp)
2603  039b 6b02          	ld	(OFST+0,sp),a
2604                     ; 834         if (((UART2->SR & itpos) != (u8)0x00) && enablestatus)
2606  039d c65240        	ld	a,21056
2607  03a0 1501          	bcp	a,(OFST-1,sp)
2608  03a2 2704          	jreq	L5721
2610  03a4 7b02          	ld	a,(OFST+0,sp)
2611                     ; 837             pendingbitstatus = SET;
2613  03a6 26ea          	jrne	LC009
2614  03a8               L5721:
2615                     ; 842             pendingbitstatus = RESET;
2620  03a8 4f            	clr	a
2621  03a9               L3521:
2622                     ; 846     return  pendingbitstatus;
2626  03a9 5b04          	addw	sp,#4
2627  03ab 81            	ret	
2663                     ; 873 void UART2_ClearITPendingBit(UART2_IT_TypeDef UART2_IT)
2663                     ; 874 {
2664                     	switch	.text
2665  03ac               _UART2_ClearITPendingBit:
2667  03ac 89            	pushw	x
2668       00000000      OFST:	set	0
2671                     ; 875     assert_param(IS_UART2_CLEAR_IT_OK(UART2_IT));
2673                     ; 878     if (UART2_IT == UART2_IT_RXNE)
2675  03ad a30255        	cpw	x,#597
2676  03b0 2606          	jrne	L7131
2677                     ; 880         UART2->SR = (u8)~(UART2_SR_RXNE);
2679  03b2 35df5240      	mov	21056,#223
2681  03b6 2011          	jra	L1231
2682  03b8               L7131:
2683                     ; 883     else if (UART2_IT == UART2_IT_LBDF)
2685  03b8 1e01          	ldw	x,(OFST+1,sp)
2686  03ba a30346        	cpw	x,#838
2687  03bd 2606          	jrne	L3231
2688                     ; 885         UART2->CR4 &= (u8)~(UART2_CR4_LBDF);
2690  03bf 72195247      	bres	21063,#4
2692  03c3 2004          	jra	L1231
2693  03c5               L3231:
2694                     ; 890         UART2->CR6 &= (u8)(~UART2_CR6_LHDF);
2696  03c5 72135249      	bres	21065,#1
2697  03c9               L1231:
2698                     ; 892 }
2701  03c9 85            	popw	x
2702  03ca 81            	ret	
2715                     	xdef	_UART2_ClearITPendingBit
2716                     	xdef	_UART2_GetITStatus
2717                     	xdef	_UART2_ClearFlag
2718                     	xdef	_UART2_GetFlagStatus
2719                     	xdef	_UART2_SetPrescaler
2720                     	xdef	_UART2_SetGuardTime
2721                     	xdef	_UART2_SetAddress
2722                     	xdef	_UART2_SendBreak
2723                     	xdef	_UART2_SendData9
2724                     	xdef	_UART2_SendData8
2725                     	xdef	_UART2_ReceiveData9
2726                     	xdef	_UART2_ReceiveData8
2727                     	xdef	_UART2_ReceiverWakeUpCmd
2728                     	xdef	_UART2_WakeUpConfig
2729                     	xdef	_UART2_SmartCardNACKCmd
2730                     	xdef	_UART2_SmartCardCmd
2731                     	xdef	_UART2_LINCmd
2732                     	xdef	_UART2_LINConfig
2733                     	xdef	_UART2_LINBreakDetectionConfig
2734                     	xdef	_UART2_IrDACmd
2735                     	xdef	_UART2_IrDAConfig
2736                     	xdef	_UART2_ITConfig
2737                     	xdef	_UART2_Cmd
2738                     	xdef	_UART2_Init
2739                     	xdef	_UART2_DeInit
2740                     	xref	_CLK_GetClockFreq
2741                     	xref.b	c_lreg
2742                     	xref.b	c_x
2761                     	xref	c_lursh
2762                     	xref	c_lsub
2763                     	xref	c_smul
2764                     	xref	c_ludv
2765                     	xref	c_rtol
2766                     	xref	c_llsh
2767                     	xref	c_ltor
2768                     	end
