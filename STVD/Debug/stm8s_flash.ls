   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  78                     ; 47 void FLASH_Unlock(FLASH_MemType_TypeDef MemType)
  78                     ; 48 {
  80                     	switch	.text
  81  0000               _FLASH_Unlock:
  85                     ; 50     assert_param(IS_MEMORY_TYPE_OK(MemType));
  87                     ; 53     if (MemType == FLASH_MEMTYPE_PROG)
  89  0000 4d            	tnz	a
  90  0001 2609          	jrne	L73
  91                     ; 55         FLASH->PUKR = FLASH_RASS_KEY1;
  93  0003 35565062      	mov	20578,#86
  94                     ; 56         FLASH->PUKR = FLASH_RASS_KEY2;
  96  0007 35ae5062      	mov	20578,#174
  99  000b 81            	ret	
 100  000c               L73:
 101                     ; 62         FLASH->DUKR = FLASH_RASS_KEY2; /* Warning: keys are reversed on data memory !!! */
 103  000c 35ae5064      	mov	20580,#174
 104                     ; 63         FLASH->DUKR = FLASH_RASS_KEY1;
 106  0010 35565064      	mov	20580,#86
 107                     ; 65 }
 110  0014 81            	ret	
 145                     ; 73 void FLASH_Lock(FLASH_MemType_TypeDef MemType)
 145                     ; 74 {
 146                     	switch	.text
 147  0015               _FLASH_Lock:
 151                     ; 76     assert_param(IS_MEMORY_TYPE_OK(MemType));
 153                     ; 79     if (MemType == FLASH_MEMTYPE_PROG)
 155  0015 4d            	tnz	a
 156  0016 2605          	jrne	L16
 157                     ; 81         FLASH->IAPSR = (u8)(~FLASH_IAPSR_PUL);
 159  0018 35fd505f      	mov	20575,#253
 162  001c 81            	ret	
 163  001d               L16:
 164                     ; 87         FLASH->IAPSR = (u8)(~FLASH_IAPSR_DUL);
 166  001d 35f7505f      	mov	20575,#247
 167                     ; 89 }
 170  0021 81            	ret	
 209                     ; 152 void FLASH_ProgramByte(u32 Address, u8 Data)
 209                     ; 153 {
 210                     	switch	.text
 211  0022               _FLASH_ProgramByte:
 213       00000000      OFST:	set	0
 216                     ; 155     assert_param(IS_FLASH_ADDRESS_OK(Address));
 218                     ; 156     *((PointerAttr u8*) Address) = Data;
 220  0022 7b07          	ld	a,(OFST+7,sp)
 221  0024 88            	push	a
 222  0025 7b05          	ld	a,(OFST+5,sp)
 223  0027 b700          	ld	c_x,a
 224  0029 1e06          	ldw	x,(OFST+6,sp)
 225  002b bf01          	ldw	c_x+1,x
 226  002d 84            	pop	a
 227  002e 92bd0000      	ldf	[c_x.e],a
 228                     ; 157 }
 231  0032 81            	ret	
 263                     ; 174 u8 FLASH_ReadByte(u32 Address)
 263                     ; 175 {
 264                     	switch	.text
 265  0033               _FLASH_ReadByte:
 267       00000000      OFST:	set	0
 270                     ; 177     assert_param(IS_FLASH_ADDRESS_OK(Address));
 272                     ; 180     return(*((@far u8*) Address)); /* Read byte */
 274  0033 7b04          	ld	a,(OFST+4,sp)
 275  0035 b700          	ld	c_x,a
 276  0037 1e05          	ldw	x,(OFST+5,sp)
 277  0039 bf01          	ldw	c_x+1,x
 278  003b 92bc0000      	ldf	a,[c_x.e]
 281  003f 81            	ret	
 320                     ; 212 void FLASH_ProgramWord(u32 Address, u32 Data)
 320                     ; 213 {
 321                     	switch	.text
 322  0040               _FLASH_ProgramWord:
 324       00000000      OFST:	set	0
 327                     ; 215     assert_param(IS_FLASH_ADDRESS_OK(Address));
 329                     ; 218     FLASH->CR2 |= FLASH_CR2_WPRG;
 331  0040 721c505b      	bset	20571,#6
 332                     ; 219     FLASH->NCR2 &= (u8)(~FLASH_NCR2_NWPRG);
 334  0044 721d505c      	bres	20572,#6
 335                     ; 221     *((PointerAttr u8*)Address)       = *((u8*)(&Data)); /* Write one byte - from lowest address*/
 337  0048 7b07          	ld	a,(OFST+7,sp)
 338  004a 88            	push	a
 339  004b 7b05          	ld	a,(OFST+5,sp)
 340  004d b700          	ld	c_x,a
 341  004f 1e06          	ldw	x,(OFST+6,sp)
 342  0051 bf01          	ldw	c_x+1,x
 343  0053 84            	pop	a
 344  0054 92bd0000      	ldf	[c_x.e],a
 345                     ; 222     *(((PointerAttr u8*)Address) + 1) = *((u8*)(&Data)+1); /* Write one byte*/
 347  0058 7b08          	ld	a,(OFST+8,sp)
 348  005a 88            	push	a
 349  005b 7b05          	ld	a,(OFST+5,sp)
 350  005d b700          	ld	c_x,a
 351  005f 1e06          	ldw	x,(OFST+6,sp)
 352  0061 bf01          	ldw	c_x+1,x
 353  0063 90ae0001      	ldw	y,#1
 354  0067 93            	ldw	x,y
 355  0068 84            	pop	a
 356  0069 92a70000      	ldf	([c_x.e],x),a
 357                     ; 223     *(((PointerAttr u8*)Address) + 2) = *((u8*)(&Data)+2); /* Write one byte*/
 359  006d 7b09          	ld	a,(OFST+9,sp)
 360  006f 88            	push	a
 361  0070 7b05          	ld	a,(OFST+5,sp)
 362  0072 b700          	ld	c_x,a
 363  0074 1e06          	ldw	x,(OFST+6,sp)
 364  0076 bf01          	ldw	c_x+1,x
 365  0078 905c          	incw	y
 366  007a 93            	ldw	x,y
 367  007b 84            	pop	a
 368  007c 92a70000      	ldf	([c_x.e],x),a
 369                     ; 224     *(((PointerAttr u8*)Address) + 3) = *((u8*)(&Data)+3); /* Write one byte - from higher address*/
 371  0080 7b0a          	ld	a,(OFST+10,sp)
 372  0082 88            	push	a
 373  0083 7b05          	ld	a,(OFST+5,sp)
 374  0085 b700          	ld	c_x,a
 375  0087 1e06          	ldw	x,(OFST+6,sp)
 376  0089 bf01          	ldw	c_x+1,x
 377  008b 905c          	incw	y
 378  008d 93            	ldw	x,y
 379  008e 84            	pop	a
 380  008f 92a70000      	ldf	([c_x.e],x),a
 381                     ; 225 }
 384  0093 81            	ret	
 425                     ; 234 void FLASH_ProgramOptionByte(u16 Address, u8 Data)
 425                     ; 235 {
 426                     	switch	.text
 427  0094               _FLASH_ProgramOptionByte:
 429       00000000      OFST:	set	0
 432                     ; 237     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 434                     ; 240     FLASH->CR2 |= FLASH_CR2_OPT;
 436  0094 721e505b      	bset	20571,#7
 437                     ; 241     FLASH->NCR2 &= (u8)(~FLASH_NCR2_NOPT);
 439  0098 721f505c      	bres	20572,#7
 440  009c 89            	pushw	x
 441                     ; 244     *((NEAR u8*)Address) = Data;
 443  009d 1e01          	ldw	x,(OFST+1,sp)
 444  009f 7b05          	ld	a,(OFST+5,sp)
 445  00a1 f7            	ld	(x),a
 446                     ; 245     *((NEAR u8*)(Address + 1)) = (u8)(~Data);
 448  00a2 43            	cpl	a
 449  00a3 e701          	ld	(1,x),a
 450                     ; 247     FLASH_WaitForLastOperation(FLASH_MEMTYPE_DATA);
 452  00a5 a601          	ld	a,#1
 453  00a7 cd015a        	call	_FLASH_WaitForLastOperation
 455                     ; 250     FLASH->CR2 &= (u8)(~FLASH_CR2_OPT);
 457  00aa 721f505b      	bres	20571,#7
 458                     ; 251     FLASH->NCR2 |= FLASH_NCR2_NOPT;
 460                     ; 252 }
 463  00ae 85            	popw	x
 464  00af 721e505c      	bset	20572,#7
 465  00b3 81            	ret	
 499                     ; 260 void FLASH_EraseOptionByte(u16 Address)
 499                     ; 261 {
 500                     	switch	.text
 501  00b4               _FLASH_EraseOptionByte:
 505                     ; 263     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 507                     ; 266     FLASH->CR2 |= FLASH_CR2_OPT;
 509  00b4 721e505b      	bset	20571,#7
 510                     ; 267     FLASH->NCR2 &= (u8)(~FLASH_NCR2_NOPT);
 512  00b8 721f505c      	bres	20572,#7
 513                     ; 270     *((NEAR u8*)Address) = FLASH_CLEAR_BYTE;
 515  00bc 7f            	clr	(x)
 516                     ; 271     *((NEAR u8*)(Address + 1 )) = FLASH_SET_BYTE;
 519  00bd a6ff          	ld	a,#255
 520  00bf e701          	ld	(1,x),a
 521                     ; 273     FLASH_WaitForLastOperation(FLASH_MEMTYPE_DATA);
 524  00c1 a601          	ld	a,#1
 525  00c3 cd015a        	call	_FLASH_WaitForLastOperation
 527                     ; 276     FLASH->CR2 &= (u8)(~FLASH_CR2_OPT);
 529  00c6 721f505b      	bres	20571,#7
 530                     ; 277     FLASH->NCR2 |= FLASH_NCR2_NOPT;
 532  00ca 721e505c      	bset	20572,#7
 533                     ; 278 }
 536  00ce 81            	ret	
 591                     ; 284 u16 FLASH_ReadOptionByte(u16 Address)
 591                     ; 285 {
 592                     	switch	.text
 593  00cf               _FLASH_ReadOptionByte:
 595  00cf 5204          	subw	sp,#4
 596       00000004      OFST:	set	4
 599                     ; 286     u8 value_optbyte, value_optbyte_complement = 0;
 601                     ; 287     u16 res_value = 0;
 603                     ; 290     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 605                     ; 293     value_optbyte = *((NEAR u8*)Address); /* Read option byte */
 607  00d1 f6            	ld	a,(x)
 608  00d2 6b01          	ld	(OFST-3,sp),a
 609                     ; 294     value_optbyte_complement = *(((NEAR u8*)Address) + 1); /* Read option byte complement*/
 611  00d4 e601          	ld	a,(1,x)
 612  00d6 6b02          	ld	(OFST-2,sp),a
 613                     ; 296     if (value_optbyte == (u8)(~value_optbyte_complement))
 615  00d8 43            	cpl	a
 616  00d9 1101          	cp	a,(OFST-3,sp)
 617  00db 2614          	jrne	L112
 618                     ; 298         res_value = (u16)((u16)value_optbyte << 8);
 620  00dd 7b01          	ld	a,(OFST-3,sp)
 621  00df 97            	ld	xl,a
 622  00e0 4f            	clr	a
 623  00e1 02            	rlwa	x,a
 624  00e2 1f03          	ldw	(OFST-1,sp),x
 625                     ; 299         res_value = res_value | (u16)value_optbyte_complement;
 627  00e4 5f            	clrw	x
 628  00e5 7b02          	ld	a,(OFST-2,sp)
 629  00e7 97            	ld	xl,a
 630  00e8 01            	rrwa	x,a
 631  00e9 1a04          	or	a,(OFST+0,sp)
 632  00eb 01            	rrwa	x,a
 633  00ec 1a03          	or	a,(OFST-1,sp)
 634  00ee 01            	rrwa	x,a
 636  00ef 2003          	jra	L312
 637  00f1               L112:
 638                     ; 303         res_value = FLASH_OPTIONBYTE_ERROR;
 640  00f1 ae5555        	ldw	x,#21845
 641  00f4               L312:
 642                     ; 306     return(res_value);
 646  00f4 5b04          	addw	sp,#4
 647  00f6 81            	ret	
 721                     ; 315 void FLASH_SetLowPowerMode(FLASH_LPMode_TypeDef LPMode)
 721                     ; 316 {
 722                     	switch	.text
 723  00f7               _FLASH_SetLowPowerMode:
 725  00f7 88            	push	a
 726       00000000      OFST:	set	0
 729                     ; 318     assert_param(IS_FLASH_LOW_POWER_MODE_OK(LPMode));
 731                     ; 320     FLASH->CR1 &= (u8)(~(FLASH_CR1_HALT | FLASH_CR1_AHALT)); /* Clears the two bits */
 733  00f8 c6505a        	ld	a,20570
 734  00fb a4f3          	and	a,#243
 735  00fd c7505a        	ld	20570,a
 736                     ; 321     FLASH->CR1 |= (u8)LPMode; /* Sets the new mode */
 738  0100 c6505a        	ld	a,20570
 739  0103 1a01          	or	a,(OFST+1,sp)
 740  0105 c7505a        	ld	20570,a
 741                     ; 322 }
 744  0108 84            	pop	a
 745  0109 81            	ret	
 803                     ; 330 void FLASH_SetProgrammingTime(FLASH_ProgramTime_TypeDef ProgTime)
 803                     ; 331 {
 804                     	switch	.text
 805  010a               _FLASH_SetProgrammingTime:
 809                     ; 333     assert_param(IS_FLASH_PROGRAM_TIME_OK(ProgTime));
 811                     ; 335     FLASH->CR1 &= (u8)(~FLASH_CR1_FIX);
 813  010a 7211505a      	bres	20570,#0
 814                     ; 336     FLASH->CR1 |= (u8)ProgTime;
 816  010e ca505a        	or	a,20570
 817  0111 c7505a        	ld	20570,a
 818                     ; 337 }
 821  0114 81            	ret	
 846                     ; 345 FLASH_LPMode_TypeDef FLASH_GetLowPowerMode(void)
 846                     ; 346 {
 847                     	switch	.text
 848  0115               _FLASH_GetLowPowerMode:
 852                     ; 347     return((FLASH_LPMode_TypeDef)(FLASH->CR1 & (FLASH_CR1_HALT | FLASH_CR1_AHALT)));
 854  0115 c6505a        	ld	a,20570
 855  0118 a40c          	and	a,#12
 858  011a 81            	ret	
 883                     ; 356 FLASH_ProgramTime_TypeDef FLASH_GetProgrammingTime(void)
 883                     ; 357 {
 884                     	switch	.text
 885  011b               _FLASH_GetProgrammingTime:
 889                     ; 358     return((FLASH_ProgramTime_TypeDef)(FLASH->CR1 & FLASH_CR1_FIX));
 891  011b c6505a        	ld	a,20570
 892  011e a401          	and	a,#1
 895  0120 81            	ret	
 927                     ; 367 u32 FLASH_GetBootSize(void)
 927                     ; 368 {
 928                     	switch	.text
 929  0121               _FLASH_GetBootSize:
 931  0121 5204          	subw	sp,#4
 932       00000004      OFST:	set	4
 935                     ; 369     u32 temp = 0;
 937                     ; 372     temp = (u32)((u32)FLASH->FPR * (u32)512);
 939  0123 c6505d        	ld	a,20573
 940  0126 5f            	clrw	x
 941  0127 97            	ld	xl,a
 942  0128 90ae0200      	ldw	y,#512
 943  012c cd0000        	call	c_umul
 945  012f 96            	ldw	x,sp
 946  0130 5c            	incw	x
 947  0131 cd0000        	call	c_rtol
 949                     ; 375     if (FLASH->FPR == 0xFF)
 951  0134 c6505d        	ld	a,20573
 952  0137 4c            	inc	a
 953  0138 260d          	jrne	L133
 954                     ; 377         temp += 512;
 956  013a ae0200        	ldw	x,#512
 957  013d bf02          	ldw	c_lreg+2,x
 958  013f 5f            	clrw	x
 959  0140 bf00          	ldw	c_lreg,x
 960  0142 96            	ldw	x,sp
 961  0143 5c            	incw	x
 962  0144 cd0000        	call	c_lgadd
 964  0147               L133:
 965                     ; 381     return(temp);
 967  0147 96            	ldw	x,sp
 968  0148 5c            	incw	x
 969  0149 cd0000        	call	c_ltor
 973  014c 5b04          	addw	sp,#4
 974  014e 81            	ret	
1083                     ; 393 FlagStatus FLASH_GetFlagStatus(FLASH_Flag_TypeDef FLASH_FLAG)
1083                     ; 394 {
1084                     	switch	.text
1085  014f               _FLASH_GetFlagStatus:
1087  014f 88            	push	a
1088       00000001      OFST:	set	1
1091                     ; 395     FlagStatus status = RESET;
1093                     ; 397     assert_param(IS_FLASH_FLAGS_OK(FLASH_FLAG));
1095                     ; 400     if ((FLASH->IAPSR & (u8)FLASH_FLAG) != (u8)RESET)
1097  0150 c4505f        	and	a,20575
1098  0153 2702          	jreq	L304
1099                     ; 402         status = SET; /* FLASH_FLAG is set */
1101  0155 a601          	ld	a,#1
1103  0157               L304:
1104                     ; 406         status = RESET; /* FLASH_FLAG is reset*/
1106                     ; 410     return status;
1110  0157 5b01          	addw	sp,#1
1111  0159 81            	ret	
1200                     ; 421 FLASH_Status_TypeDef FLASH_WaitForLastOperation(FLASH_MemType_TypeDef MemType)
1200                     ; 422 {
1201                     	switch	.text
1202  015a               _FLASH_WaitForLastOperation:
1204  015a 5203          	subw	sp,#3
1205       00000003      OFST:	set	3
1208                     ; 423     u8 flagstatus = 0x00;
1210  015c 0f03          	clr	(OFST+0,sp)
1211                     ; 424     u16 timeout = OPERATION_TIMEOUT;
1213  015e ae1000        	ldw	x,#4096
1214  0161 1f01          	ldw	(OFST-2,sp),x
1215                     ; 427     if (MemType == FLASH_MEMTYPE_PROG)
1217  0163 4d            	tnz	a
1218  0164 2620          	jrne	L364
1220  0166 200a          	jra	L154
1221  0168               L744:
1222                     ; 431             flagstatus = (u8)(FLASH->IAPSR & (FLASH_IAPSR_EOP |
1222                     ; 432                                               FLASH_IAPSR_WR_PG_DIS));
1224  0168 c6505f        	ld	a,20575
1225  016b a405          	and	a,#5
1226  016d 6b03          	ld	(OFST+0,sp),a
1227                     ; 433             timeout--;
1229  016f 5a            	decw	x
1230  0170 1f01          	ldw	(OFST-2,sp),x
1231  0172               L154:
1232                     ; 429         while ((flagstatus == 0x00) && (timeout != 0x00))
1234  0172 7b03          	ld	a,(OFST+0,sp)
1235  0174 2618          	jrne	L754
1237  0176 1e01          	ldw	x,(OFST-2,sp)
1238  0178 26ee          	jrne	L744
1239  017a 2012          	jra	L754
1240  017c               L164:
1241                     ; 440             flagstatus = (u8)(FLASH->IAPSR & (FLASH_IAPSR_HVOFF |
1241                     ; 441                                               FLASH_IAPSR_WR_PG_DIS));
1243  017c c6505f        	ld	a,20575
1244  017f a441          	and	a,#65
1245  0181 6b03          	ld	(OFST+0,sp),a
1246                     ; 442             timeout--;
1248  0183 5a            	decw	x
1249  0184 1f01          	ldw	(OFST-2,sp),x
1250  0186               L364:
1251                     ; 438         while ((flagstatus == 0x00) && (timeout != 0x00))
1253  0186 7b03          	ld	a,(OFST+0,sp)
1254  0188 2604          	jrne	L754
1256  018a 1e01          	ldw	x,(OFST-2,sp)
1257  018c 26ee          	jrne	L164
1258  018e               L754:
1259                     ; 453     if (timeout == 0x00 )
1261  018e 1e01          	ldw	x,(OFST-2,sp)
1262  0190 2602          	jrne	L174
1263                     ; 455         flagstatus = FLASH_STATUS_TIMEOUT;
1265  0192 a602          	ld	a,#2
1266  0194               L174:
1267                     ; 458     return((FLASH_Status_TypeDef)flagstatus);
1271  0194 5b03          	addw	sp,#3
1272  0196 81            	ret	
1285                     	xdef	_FLASH_WaitForLastOperation
1286                     	xdef	_FLASH_GetFlagStatus
1287                     	xdef	_FLASH_GetBootSize
1288                     	xdef	_FLASH_GetProgrammingTime
1289                     	xdef	_FLASH_GetLowPowerMode
1290                     	xdef	_FLASH_SetProgrammingTime
1291                     	xdef	_FLASH_SetLowPowerMode
1292                     	xdef	_FLASH_EraseOptionByte
1293                     	xdef	_FLASH_ProgramOptionByte
1294                     	xdef	_FLASH_ReadOptionByte
1295                     	xdef	_FLASH_ProgramWord
1296                     	xdef	_FLASH_ReadByte
1297                     	xdef	_FLASH_ProgramByte
1298                     	xdef	_FLASH_Lock
1299                     	xdef	_FLASH_Unlock
1300                     	xref.b	c_lreg
1301                     	xref.b	c_x
1302                     	xref.b	c_y
1321                     	xref	c_ltor
1322                     	xref	c_lgadd
1323                     	xref	c_rtol
1324                     	xref	c_umul
1325                     	end
