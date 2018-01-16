   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  46                     ; 43 void SPI_DeInit(void)
  46                     ; 44 {
  48                     	switch	.text
  49  0000               _SPI_DeInit:
  53                     ; 45     SPI->CR1    = SPI_CR1_RESET_VALUE;
  55  0000 725f5200      	clr	20992
  56                     ; 46     SPI->CR2    = SPI_CR2_RESET_VALUE;
  58  0004 725f5201      	clr	20993
  59                     ; 47     SPI->ICR    = SPI_ICR_RESET_VALUE;
  61  0008 725f5202      	clr	20994
  62                     ; 48     SPI->SR     = SPI_SR_RESET_VALUE;
  64  000c 35025203      	mov	20995,#2
  65                     ; 49     SPI->CRCPR  = SPI_CRCPR_RESET_VALUE;
  67  0010 35075205      	mov	20997,#7
  68                     ; 50 }
  71  0014 81            	ret	
 385                     ; 65 void SPI_Init(SPI_FirstBit_TypeDef FirstBit, SPI_BaudRatePrescaler_TypeDef BaudRatePrescaler, SPI_Mode_TypeDef Mode, SPI_ClockPolarity_TypeDef ClockPolarity, SPI_ClockPhase_TypeDef ClockPhase, SPI_DataDirection_TypeDef Data_Direction, SPI_NSS_TypeDef Slave_Management, u8 CRCPolynomial)
 385                     ; 66 {
 386                     	switch	.text
 387  0015               _SPI_Init:
 389  0015 89            	pushw	x
 390       00000000      OFST:	set	0
 393                     ; 68     assert_param(IS_SPI_FIRSTBIT_OK(FirstBit));
 395                     ; 69     assert_param(IS_SPI_BAUDRATE_PRESCALER_OK(BaudRatePrescaler));
 397                     ; 70     assert_param(IS_SPI_MODE_OK(Mode));
 399                     ; 71     assert_param(IS_SPI_POLARITY_OK(ClockPolarity));
 401                     ; 72     assert_param(IS_SPI_PHASE_OK(ClockPhase));
 403                     ; 73     assert_param(IS_SPI_DATA_DIRECTION_OK(Data_Direction));
 405                     ; 74     assert_param(IS_SPI_SLAVEMANAGEMENT_OK(Slave_Management));
 407                     ; 75     assert_param(IS_SPI_CRC_POLYNOMIAL_OK(CRCPolynomial));
 409                     ; 78     SPI->CR1 = (u8)((u8)(FirstBit) |
 409                     ; 79                     (u8)(BaudRatePrescaler) |
 409                     ; 80                     (u8)(ClockPolarity) |
 409                     ; 81                     (u8)(ClockPhase));
 411  0016 9f            	ld	a,xl
 412  0017 1a01          	or	a,(OFST+1,sp)
 413  0019 1a06          	or	a,(OFST+6,sp)
 414  001b 1a07          	or	a,(OFST+7,sp)
 415  001d c75200        	ld	20992,a
 416                     ; 84     SPI->CR2 = (u8)((u8)(Data_Direction) | (u8)(Slave_Management));
 418  0020 7b08          	ld	a,(OFST+8,sp)
 419  0022 1a09          	or	a,(OFST+9,sp)
 420  0024 c75201        	ld	20993,a
 421                     ; 86     if (Mode == SPI_MODE_MASTER)
 423  0027 7b05          	ld	a,(OFST+5,sp)
 424  0029 a104          	cp	a,#4
 425  002b 2606          	jrne	L102
 426                     ; 88         SPI->CR2 |= (u8)SPI_CR2_SSI;
 428  002d 72105201      	bset	20993,#0
 430  0031 2004          	jra	L302
 431  0033               L102:
 432                     ; 92         SPI->CR2 &= (u8)~(SPI_CR2_SSI);
 434  0033 72115201      	bres	20993,#0
 435  0037               L302:
 436                     ; 96     SPI->CR1 |= (u8)(Mode);
 438  0037 c65200        	ld	a,20992
 439  003a 1a05          	or	a,(OFST+5,sp)
 440  003c c75200        	ld	20992,a
 441                     ; 99     SPI->CRCPR = (u8)CRCPolynomial;
 443  003f 7b0a          	ld	a,(OFST+10,sp)
 444  0041 c75205        	ld	20997,a
 445                     ; 100 }
 448  0044 85            	popw	x
 449  0045 81            	ret	
 504                     ; 111 void SPI_Cmd(FunctionalState NewState)
 504                     ; 112 {
 505                     	switch	.text
 506  0046               _SPI_Cmd:
 510                     ; 114     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 512                     ; 116     if (NewState != DISABLE)
 514  0046 4d            	tnz	a
 515  0047 2705          	jreq	L332
 516                     ; 118         SPI->CR1 |= SPI_CR1_SPE; /* Enable the SPI peripheral*/
 518  0049 721c5200      	bset	20992,#6
 521  004d 81            	ret	
 522  004e               L332:
 523                     ; 122         SPI->CR1 &= (u8)(~SPI_CR1_SPE); /* Disable the SPI peripheral*/
 525  004e 721d5200      	bres	20992,#6
 526                     ; 124 }
 529  0052 81            	ret	
 636                     ; 135 void SPI_ITConfig(SPI_IT_TypeDef SPI_IT, FunctionalState NewState)
 636                     ; 136 {
 637                     	switch	.text
 638  0053               _SPI_ITConfig:
 640  0053 89            	pushw	x
 641  0054 88            	push	a
 642       00000001      OFST:	set	1
 645                     ; 137     u8 itpos = 0;
 647                     ; 139     assert_param(IS_SPI_CONFIG_IT_OK(SPI_IT));
 649                     ; 140     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 651                     ; 143     itpos = (u8)((u8)1 << (u8)((u8)SPI_IT & (u8)0x0F));
 653  0055 9e            	ld	a,xh
 654  0056 a40f          	and	a,#15
 655  0058 5f            	clrw	x
 656  0059 97            	ld	xl,a
 657  005a a601          	ld	a,#1
 658  005c 5d            	tnzw	x
 659  005d 2704          	jreq	L41
 660  005f               L61:
 661  005f 48            	sll	a
 662  0060 5a            	decw	x
 663  0061 26fc          	jrne	L61
 664  0063               L41:
 665  0063 6b01          	ld	(OFST+0,sp),a
 666                     ; 145     if (NewState != DISABLE)
 668  0065 0d03          	tnz	(OFST+2,sp)
 669  0067 2707          	jreq	L503
 670                     ; 147         SPI->ICR |= itpos; /* Enable interrupt*/
 672  0069 c65202        	ld	a,20994
 673  006c 1a01          	or	a,(OFST+0,sp)
 675  006e 2004          	jra	L703
 676  0070               L503:
 677                     ; 151         SPI->ICR &= (u8)(~itpos); /* Disable interrupt*/
 679  0070 43            	cpl	a
 680  0071 c45202        	and	a,20994
 681  0074               L703:
 682  0074 c75202        	ld	20994,a
 683                     ; 153 }
 686  0077 5b03          	addw	sp,#3
 687  0079 81            	ret	
 719                     ; 160 void SPI_SendData(u8 Data)
 719                     ; 161 {
 720                     	switch	.text
 721  007a               _SPI_SendData:
 725                     ; 162     SPI->DR = Data; /* Write in the DR register the data to be sent*/
 727  007a c75204        	ld	20996,a
 728                     ; 163 }
 731  007d 81            	ret	
 754                     ; 171 u8 SPI_ReceiveData(void)
 754                     ; 172 {
 755                     	switch	.text
 756  007e               _SPI_ReceiveData:
 760                     ; 173     return ((u8)SPI->DR); /* Return the data in the DR register*/
 762  007e c65204        	ld	a,20996
 765  0081 81            	ret	
 801                     ; 185 void SPI_NSSInternalSoftwareCmd(FunctionalState NewState)
 801                     ; 186 {
 802                     	switch	.text
 803  0082               _SPI_NSSInternalSoftwareCmd:
 807                     ; 188     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 809                     ; 190     if (NewState != DISABLE)
 811  0082 4d            	tnz	a
 812  0083 2705          	jreq	L353
 813                     ; 192         SPI->CR2 |= SPI_CR2_SSI; /* Set NSS pin internally by software*/
 815  0085 72105201      	bset	20993,#0
 818  0089 81            	ret	
 819  008a               L353:
 820                     ; 196         SPI->CR2 &= (u8)(~SPI_CR2_SSI); /* Reset NSS pin internally by software*/
 822  008a 72115201      	bres	20993,#0
 823                     ; 198 }
 826  008e 81            	ret	
 849                     ; 207 void SPI_TransmitCRC(void)
 849                     ; 208 {
 850                     	switch	.text
 851  008f               _SPI_TransmitCRC:
 855                     ; 209     SPI->CR2 |= SPI_CR2_CRCNEXT; /* Enable the CRC transmission*/
 857  008f 72185201      	bset	20993,#4
 858                     ; 210 }
 861  0093 81            	ret	
 898                     ; 221 void SPI_CalculateCRCCmd(FunctionalState NewState)
 898                     ; 222 {
 899                     	switch	.text
 900  0094               _SPI_CalculateCRCCmd:
 902  0094 88            	push	a
 903       00000000      OFST:	set	0
 906                     ; 224     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 908                     ; 227     SPI_Cmd(DISABLE);
 910  0095 4f            	clr	a
 911  0096 adae          	call	_SPI_Cmd
 913                     ; 229     if (NewState != DISABLE)
 915  0098 7b01          	ld	a,(OFST+1,sp)
 916  009a 2706          	jreq	L504
 917                     ; 231         SPI->CR2 |= SPI_CR2_CRCEN; /* Enable the CRC calculation*/
 919  009c 721a5201      	bset	20993,#5
 921  00a0 2004          	jra	L704
 922  00a2               L504:
 923                     ; 235         SPI->CR2 &= (u8)(~SPI_CR2_CRCEN); /* Disable the CRC calculation*/
 925  00a2 721b5201      	bres	20993,#5
 926  00a6               L704:
 927                     ; 237 }
 930  00a6 84            	pop	a
 931  00a7 81            	ret	
 993                     ; 244 u8 SPI_GetCRC(SPI_CRC_TypeDef SPI_CRC)
 993                     ; 245 {
 994                     	switch	.text
 995  00a8               _SPI_GetCRC:
 997  00a8 88            	push	a
 998       00000001      OFST:	set	1
1001                     ; 246     u8 crcreg = 0;
1003                     ; 249     assert_param(IS_SPI_CRC_OK(SPI_CRC));
1005                     ; 251     if (SPI_CRC != SPI_CRC_RX)
1007  00a9 4d            	tnz	a
1008  00aa 2705          	jreq	L144
1009                     ; 253         crcreg = SPI->TXCRCR;  /* Get the Tx CRC register*/
1011  00ac c65207        	ld	a,20999
1013  00af 2003          	jra	L344
1014  00b1               L144:
1015                     ; 257         crcreg = SPI->RXCRCR; /* Get the Rx CRC register*/
1017  00b1 c65206        	ld	a,20998
1018  00b4               L344:
1019                     ; 261     return crcreg;
1023  00b4 5b01          	addw	sp,#1
1024  00b6 81            	ret	
1049                     ; 271 void SPI_ResetCRC(void)
1049                     ; 272 {
1050                     	switch	.text
1051  00b7               _SPI_ResetCRC:
1055                     ; 275     SPI_CalculateCRCCmd(ENABLE);
1057  00b7 a601          	ld	a,#1
1058  00b9 add9          	call	_SPI_CalculateCRCCmd
1060                     ; 278     SPI_Cmd(ENABLE);
1062  00bb a601          	ld	a,#1
1064                     ; 279 }
1067  00bd 2087          	jp	_SPI_Cmd
1091                     ; 287 u8 SPI_GetCRCPolynomial(void)
1091                     ; 288 {
1092                     	switch	.text
1093  00bf               _SPI_GetCRCPolynomial:
1097                     ; 289     return SPI->CRCPR; /* Return the CRC polynomial register */
1099  00bf c65205        	ld	a,20997
1102  00c2 81            	ret	
1158                     ; 298 void SPI_BiDirectionalLineConfig(SPI_Direction_TypeDef SPI_Direction)
1158                     ; 299 {
1159                     	switch	.text
1160  00c3               _SPI_BiDirectionalLineConfig:
1164                     ; 301     assert_param(IS_SPI_DIRECTION_OK(SPI_Direction));
1166                     ; 303     if (SPI_Direction != SPI_DIRECTION_RX)
1168  00c3 4d            	tnz	a
1169  00c4 2705          	jreq	L315
1170                     ; 305         SPI->CR2 |= SPI_CR2_BDOE; /* Set the Tx only mode*/
1172  00c6 721c5201      	bset	20993,#6
1175  00ca 81            	ret	
1176  00cb               L315:
1177                     ; 309         SPI->CR2 &= (u8)(~SPI_CR2_BDOE); /* Set the Rx only mode*/
1179  00cb 721d5201      	bres	20993,#6
1180                     ; 311 }
1183  00cf 81            	ret	
1304                     ; 321 FlagStatus SPI_GetFlagStatus(SPI_Flag_TypeDef SPI_FLAG)
1304                     ; 322 {
1305                     	switch	.text
1306  00d0               _SPI_GetFlagStatus:
1308  00d0 88            	push	a
1309       00000001      OFST:	set	1
1312                     ; 323     FlagStatus status = RESET;
1314                     ; 325     assert_param(IS_SPI_FLAGS_OK(SPI_FLAG));
1316                     ; 328     if ((SPI->SR & (u8)SPI_FLAG) != (u8)RESET)
1318  00d1 c45203        	and	a,20995
1319  00d4 2702          	jreq	L375
1320                     ; 330         status = SET; /* SPI_FLAG is set */
1322  00d6 a601          	ld	a,#1
1324  00d8               L375:
1325                     ; 334         status = RESET; /* SPI_FLAG is reset*/
1327                     ; 338     return status;
1331  00d8 5b01          	addw	sp,#1
1332  00da 81            	ret	
1367                     ; 357 void SPI_ClearFlag(SPI_Flag_TypeDef SPI_FLAG)
1367                     ; 358 {
1368                     	switch	.text
1369  00db               _SPI_ClearFlag:
1373                     ; 359     assert_param(IS_SPI_CLEAR_FLAGS_OK(SPI_FLAG));
1375                     ; 361     SPI->SR = (u8)(~SPI_FLAG);
1377  00db 43            	cpl	a
1378  00dc c75203        	ld	20995,a
1379                     ; 362 }
1382  00df 81            	ret	
1456                     ; 377 ITStatus SPI_GetITStatus(SPI_IT_TypeDef SPI_IT)
1456                     ; 378 {
1457                     	switch	.text
1458  00e0               _SPI_GetITStatus:
1460  00e0 88            	push	a
1461  00e1 89            	pushw	x
1462       00000002      OFST:	set	2
1465                     ; 379     ITStatus pendingbitstatus = RESET;
1467                     ; 380     u8 itpos = 0;
1469                     ; 381     u8 itmask1 = 0;
1471                     ; 382     u8 itmask2 = 0;
1473                     ; 383     u8 enablestatus = 0;
1475                     ; 384     assert_param(IS_SPI_GET_IT_OK(SPI_IT));
1477                     ; 386     itpos = (u8)((u8)1 << ((u8)SPI_IT & (u8)0x0F));
1479  00e2 a40f          	and	a,#15
1480  00e4 5f            	clrw	x
1481  00e5 97            	ld	xl,a
1482  00e6 a601          	ld	a,#1
1483  00e8 5d            	tnzw	x
1484  00e9 2704          	jreq	L65
1485  00eb               L06:
1486  00eb 48            	sll	a
1487  00ec 5a            	decw	x
1488  00ed 26fc          	jrne	L06
1489  00ef               L65:
1490  00ef 6b01          	ld	(OFST-1,sp),a
1491                     ; 389     itmask1 = (u8)((u8)SPI_IT >> (u8)4);
1493  00f1 7b03          	ld	a,(OFST+1,sp)
1494  00f3 4e            	swap	a
1495  00f4 a40f          	and	a,#15
1496  00f6 6b02          	ld	(OFST+0,sp),a
1497                     ; 391     itmask2 = (u8)((u8)1 << itmask1);
1499  00f8 5f            	clrw	x
1500  00f9 97            	ld	xl,a
1501  00fa a601          	ld	a,#1
1502  00fc 5d            	tnzw	x
1503  00fd 2704          	jreq	L26
1504  00ff               L46:
1505  00ff 48            	sll	a
1506  0100 5a            	decw	x
1507  0101 26fc          	jrne	L46
1508  0103               L26:
1509                     ; 393     enablestatus = (u8)((u8)SPI->SR & itmask2);
1511  0103 c45203        	and	a,20995
1512  0106 6b02          	ld	(OFST+0,sp),a
1513                     ; 395     if (((SPI->ICR & itpos) != RESET) && enablestatus)
1515  0108 c65202        	ld	a,20994
1516  010b 1501          	bcp	a,(OFST-1,sp)
1517  010d 2708          	jreq	L746
1519  010f 7b02          	ld	a,(OFST+0,sp)
1520  0111 2704          	jreq	L746
1521                     ; 398         pendingbitstatus = SET;
1523  0113 a601          	ld	a,#1
1525  0115 2001          	jra	L156
1526  0117               L746:
1527                     ; 403         pendingbitstatus = RESET;
1529  0117 4f            	clr	a
1530  0118               L156:
1531                     ; 406     return  pendingbitstatus;
1535  0118 5b03          	addw	sp,#3
1536  011a 81            	ret	
1579                     ; 424 void SPI_ClearITPendingBit(SPI_IT_TypeDef SPI_IT)
1579                     ; 425 {
1580                     	switch	.text
1581  011b               _SPI_ClearITPendingBit:
1583  011b 88            	push	a
1584       00000001      OFST:	set	1
1587                     ; 426     u8 itpos = 0;
1589                     ; 427     assert_param(IS_SPI_CLEAR_IT_OK(SPI_IT));
1591                     ; 432     itpos = (u8)((u8)1 << (((u8)SPI_IT & (u8)0xF0) >> 4));
1593  011c 4e            	swap	a
1594  011d a40f          	and	a,#15
1595  011f 5f            	clrw	x
1596  0120 97            	ld	xl,a
1597  0121 a601          	ld	a,#1
1598  0123 5d            	tnzw	x
1599  0124 2704          	jreq	L07
1600  0126               L27:
1601  0126 48            	sll	a
1602  0127 5a            	decw	x
1603  0128 26fc          	jrne	L27
1604  012a               L07:
1605                     ; 434     SPI->SR = (u8)(~itpos);
1607  012a 43            	cpl	a
1608  012b c75203        	ld	20995,a
1609                     ; 436 }
1612  012e 84            	pop	a
1613  012f 81            	ret	
1626                     	xdef	_SPI_ClearITPendingBit
1627                     	xdef	_SPI_GetITStatus
1628                     	xdef	_SPI_ClearFlag
1629                     	xdef	_SPI_GetFlagStatus
1630                     	xdef	_SPI_BiDirectionalLineConfig
1631                     	xdef	_SPI_GetCRCPolynomial
1632                     	xdef	_SPI_ResetCRC
1633                     	xdef	_SPI_GetCRC
1634                     	xdef	_SPI_CalculateCRCCmd
1635                     	xdef	_SPI_TransmitCRC
1636                     	xdef	_SPI_NSSInternalSoftwareCmd
1637                     	xdef	_SPI_ReceiveData
1638                     	xdef	_SPI_SendData
1639                     	xdef	_SPI_ITConfig
1640                     	xdef	_SPI_Cmd
1641                     	xdef	_SPI_Init
1642                     	xdef	_SPI_DeInit
1661                     	end
