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
 110  0000               _f_spistatus:
 111  0000 00            	dc.b	0
 112  0001               _tSpiWriteAddr:
 113  0001 00000000      	dc.l	0
 114  0005               _WREN:
 115  0005 06            	dc.b	6
 116  0006               _Tx_Buffer:
 117  0006 4b4b4b00      	dc.b	"KKK",0
 163                     ; 93 u8 SPI_FLASH_SendByte(u8 tData)
 163                     ; 94 {
 165                     	switch	.text
 166  0000               _SPI_FLASH_SendByte:
 168  0000 88            	push	a
 169       00000001      OFST:	set	1
 172                     ; 96    DD=SPI_DSP_SendByte(tData);
 174  0001 cd0000        	call	_SPI_DSP_SendByte
 176                     ; 97    return DD;
 180  0004 5b01          	addw	sp,#1
 181  0006 81            	ret	
 205                     ; 101 void SPI_FLASH_CS_LOW(void)
 205                     ; 102 {
 206                     	switch	.text
 207  0007               _SPI_FLASH_CS_LOW:
 211                     ; 103 GPIO_WriteLow(GPIOE,GPIO_PIN_5);
 213  0007 4b20          	push	#32
 214  0009 ae5014        	ldw	x,#20500
 215  000c cd0000        	call	_GPIO_WriteLow
 217  000f 84            	pop	a
 218                     ; 104 }
 221  0010 81            	ret	
 245                     ; 108 void SPI_FLASH_CS_HIGH(void)
 245                     ; 109 {
 246                     	switch	.text
 247  0011               _SPI_FLASH_CS_HIGH:
 251                     ; 110 GPIO_WriteHigh(GPIOE,GPIO_PIN_5);
 253  0011 4b20          	push	#32
 254  0013 ae5014        	ldw	x,#20500
 255  0016 cd0000        	call	_GPIO_WriteHigh
 257  0019 84            	pop	a
 258                     ; 111 }
 261  001a 81            	ret	
 287                     ; 114 void Spi_Flash_init(void) 
 287                     ; 115 
 287                     ; 116 { 
 288                     	switch	.text
 289  001b               _Spi_Flash_init:
 293                     ; 118 DEVICE_ID = ReadDeviceID();//¶ÁÈ¡Flash ID 
 295  001b ad0c          	call	_ReadDeviceID
 297  001d cf0002        	ldw	_DEVICE_ID,x
 298                     ; 120 Flash_ChipErase();//Flash ²Á³ý 
 301                     ; 122 } 
 304  0020 cc0271        	jp	_Flash_ChipErase
 332                     ; 133 void SpiDelay(void) 
 332                     ; 134 
 332                     ; 135 { 
 333                     	switch	.text
 334  0023               _SpiDelay:
 338                     ; 137 nop(); 
 341  0023 9d            	nop	
 343                     ; 139 nop(); 
 347  0024 9d            	nop	
 349                     ; 141 nop(); 
 353  0025 9d            	nop	
 355                     ; 143 nop(); 
 359  0026 9d            	nop	
 361                     ; 145 nop(); 
 365  0027 9d            	nop	
 367                     ; 147 } 
 371  0028 81            	ret	
 407                     ; 163 u16 ReadDeviceID(void) 
 407                     ; 164 
 407                     ; 165 { 
 408                     	switch	.text
 409  0029               _ReadDeviceID:
 411  0029 89            	pushw	x
 412       00000002      OFST:	set	2
 415                     ; 167 u16 DeviceID=0; 
 417                     ; 169 SPI_FLASH_CS_LOW(); 
 419  002a addb          	call	_SPI_FLASH_CS_LOW
 421                     ; 171 f_spistatus=1; 
 423  002c 35010000      	mov	_f_spistatus,#1
 424                     ; 173 SPI_FLASH_SendByte(0x90); 
 426  0030 a690          	ld	a,#144
 427  0032 adcc          	call	_SPI_FLASH_SendByte
 429                     ; 175 SPI_FLASH_SendByte(0x00); 
 431  0034 4f            	clr	a
 432  0035 adc9          	call	_SPI_FLASH_SendByte
 434                     ; 177 SPI_FLASH_SendByte(0x00); 
 436  0037 4f            	clr	a
 437  0038 adc6          	call	_SPI_FLASH_SendByte
 439                     ; 179 SPI_FLASH_SendByte(0x00); 
 441  003a 4f            	clr	a
 442  003b adc3          	call	_SPI_FLASH_SendByte
 444                     ; 181 DeviceID = (SPI_FLASH_SendByte(0xff) << 8); 
 446  003d a6ff          	ld	a,#255
 447  003f adbf          	call	_SPI_FLASH_SendByte
 449  0041 97            	ld	xl,a
 450  0042 4f            	clr	a
 451  0043 02            	rlwa	x,a
 452  0044 1f01          	ldw	(OFST-1,sp),x
 453                     ; 183 DeviceID |= SPI_FLASH_SendByte(0xff); 
 455  0046 a6ff          	ld	a,#255
 456  0048 adb6          	call	_SPI_FLASH_SendByte
 458  004a 5f            	clrw	x
 459  004b 97            	ld	xl,a
 460  004c 01            	rrwa	x,a
 461  004d 1a02          	or	a,(OFST+0,sp)
 462  004f 01            	rrwa	x,a
 463  0050 1a01          	or	a,(OFST-1,sp)
 464  0052 01            	rrwa	x,a
 465  0053 1f01          	ldw	(OFST-1,sp),x
 466                     ; 185 SPI_FLASH_CS_HIGH(); 
 468  0055 adba          	call	_SPI_FLASH_CS_HIGH
 470                     ; 187 return DeviceID; 
 472  0057 1e01          	ldw	x,(OFST-1,sp)
 475  0059 5b02          	addw	sp,#2
 476  005b 81            	ret	
 512                     ; 191 void vFlash_Read_Status(void)
 512                     ; 192 {
 513                     	switch	.text
 514  005c               _vFlash_Read_Status:
 516  005c 88            	push	a
 517       00000001      OFST:	set	1
 520                     ; 194 	unsigned char read_statu_com=0x05;
 522  005d a605          	ld	a,#5
 523  005f 6b01          	ld	(OFST+0,sp),a
 524                     ; 195 	SPI_FLASH_CS_HIGH(); 
 526  0061 adae          	call	_SPI_FLASH_CS_HIGH
 528                     ; 198 	SPI_FLASH_CS_LOW(); 
 530  0063 ada2          	call	_SPI_FLASH_CS_LOW
 532                     ; 200       Flash_status_buf=SPI_FLASH_SendByte(read_statu_com);
 534  0065 7b01          	ld	a,(OFST+0,sp)
 535  0067 ad97          	call	_SPI_FLASH_SendByte
 537  0069 5f            	clrw	x
 538  006a 97            	ld	xl,a
 539  006b cf0000        	ldw	_Flash_status_buf,x
 540                     ; 202 	SPI_FLASH_CS_HIGH(); 
 542  006e ada1          	call	_SPI_FLASH_CS_HIGH
 544                     ; 204 }
 547  0070 84            	pop	a
 548  0071 81            	ret	
 585                     ; 260 void SPI_FLASH_SectorErase(u32 SectorAddr)
 585                     ; 261 {
 586                     	switch	.text
 587  0072               _SPI_FLASH_SectorErase:
 589       00000000      OFST:	set	0
 592                     ; 265   SPI_FLASH_WriteEnable();
 594  0072 cd0282        	call	_SPI_FLASH_WriteEnable
 596                     ; 271   SPI_FLASH_CS_LOW();
 598  0075 ad90          	call	_SPI_FLASH_CS_LOW
 600                     ; 275   SPI_FLASH_SendByte(SE);
 602  0077 a620          	ld	a,#32
 603  0079 ad85          	call	_SPI_FLASH_SendByte
 605                     ; 279   SPI_FLASH_SendByte((SectorAddr & 0xFF0000) >> 16);
 607  007b 96            	ldw	x,sp
 608  007c 1c0003        	addw	x,#OFST+3
 609  007f cd0000        	call	c_ltor
 611  0082 3f03          	clr	c_lreg+3
 612  0084 3f02          	clr	c_lreg+2
 613  0086 3f00          	clr	c_lreg
 614  0088 a610          	ld	a,#16
 615  008a cd0000        	call	c_lursh
 617  008d b603          	ld	a,c_lreg+3
 618  008f cd0000        	call	_SPI_FLASH_SendByte
 620                     ; 283   SPI_FLASH_SendByte((SectorAddr & 0xFF00) >> 8);
 622  0092 96            	ldw	x,sp
 623  0093 1c0003        	addw	x,#OFST+3
 624  0096 cd0000        	call	c_ltor
 626  0099 3f03          	clr	c_lreg+3
 627  009b 3f01          	clr	c_lreg+1
 628  009d 3f00          	clr	c_lreg
 629  009f a608          	ld	a,#8
 630  00a1 cd0000        	call	c_lursh
 632  00a4 b603          	ld	a,c_lreg+3
 633  00a6 cd0000        	call	_SPI_FLASH_SendByte
 635                     ; 287   SPI_FLASH_SendByte(SectorAddr & 0xFF);
 637  00a9 7b06          	ld	a,(OFST+6,sp)
 638  00ab cd0000        	call	_SPI_FLASH_SendByte
 640                     ; 291   SPI_FLASH_CS_HIGH();
 643                     ; 293 }
 646  00ae cc0011        	jp	_SPI_FLASH_CS_HIGH
 700                     ; 299 void SPI_FLASH_PageWrite(u8* pBuffer, u32 WriteAddr, u16 NumByteToWrite)
 700                     ; 300 
 700                     ; 301 {
 701                     	switch	.text
 702  00b1               _SPI_FLASH_PageWrite:
 704  00b1 89            	pushw	x
 705       00000000      OFST:	set	0
 708                     ; 304   SPI_FLASH_WriteEnable();
 710  00b2 cd0282        	call	_SPI_FLASH_WriteEnable
 712                     ; 308   SPI_FLASH_CS_LOW();
 714  00b5 cd0007        	call	_SPI_FLASH_CS_LOW
 716                     ; 312   SPI_FLASH_SendByte(PP);
 718  00b8 a602          	ld	a,#2
 719  00ba cd0000        	call	_SPI_FLASH_SendByte
 721                     ; 316   SPI_FLASH_SendByte((WriteAddr & 0xFF0000) >> 16);
 723  00bd 96            	ldw	x,sp
 724  00be 1c0005        	addw	x,#OFST+5
 725  00c1 cd0000        	call	c_ltor
 727  00c4 3f03          	clr	c_lreg+3
 728  00c6 3f02          	clr	c_lreg+2
 729  00c8 3f00          	clr	c_lreg
 730  00ca a610          	ld	a,#16
 731  00cc cd0000        	call	c_lursh
 733  00cf b603          	ld	a,c_lreg+3
 734  00d1 cd0000        	call	_SPI_FLASH_SendByte
 736                     ; 320   SPI_FLASH_SendByte((WriteAddr & 0xFF00) >> 8);
 738  00d4 96            	ldw	x,sp
 739  00d5 1c0005        	addw	x,#OFST+5
 740  00d8 cd0000        	call	c_ltor
 742  00db 3f03          	clr	c_lreg+3
 743  00dd 3f01          	clr	c_lreg+1
 744  00df 3f00          	clr	c_lreg
 745  00e1 a608          	ld	a,#8
 746  00e3 cd0000        	call	c_lursh
 748  00e6 b603          	ld	a,c_lreg+3
 749  00e8 cd0000        	call	_SPI_FLASH_SendByte
 751                     ; 324   SPI_FLASH_SendByte(WriteAddr & 0xFF);
 753  00eb 7b08          	ld	a,(OFST+8,sp)
 754  00ed cd0000        	call	_SPI_FLASH_SendByte
 757  00f0 200b          	jra	L302
 758  00f2               L102:
 759                     ; 329   SPI_FLASH_SendByte(*pBuffer);
 761  00f2 1e01          	ldw	x,(OFST+1,sp)
 762  00f4 f6            	ld	a,(x)
 763  00f5 cd0000        	call	_SPI_FLASH_SendByte
 765                     ; 331   pBuffer++;  
 767  00f8 1e01          	ldw	x,(OFST+1,sp)
 768  00fa 5c            	incw	x
 769  00fb 1f01          	ldw	(OFST+1,sp),x
 770  00fd               L302:
 771                     ; 326   while(NumByteToWrite--)
 773  00fd 1e09          	ldw	x,(OFST+9,sp)
 774  00ff 5a            	decw	x
 775  0100 1f09          	ldw	(OFST+9,sp),x
 776  0102 5c            	incw	x
 777  0103 26ed          	jrne	L102
 778                     ; 335   SPI_FLASH_CS_HIGH();
 780  0105 cd0011        	call	_SPI_FLASH_CS_HIGH
 782                     ; 337 }
 785  0108 85            	popw	x
 786  0109 81            	ret	
 872                     ; 345 void SPI_FLASH_BufferWrite(u8* pBuffer, u32 WriteAddr, u16 NumByteToWrite)
 872                     ; 346 
 872                     ; 347 
 872                     ; 348 {
 873                     	switch	.text
 874  010a               _SPI_FLASH_BufferWrite:
 876  010a 89            	pushw	x
 877  010b 5206          	subw	sp,#6
 878       00000006      OFST:	set	6
 881                     ; 350   u8 NumOfPage = 0, NumOfSingle = 0, Addr = 0, count = 0, temp = 0;
 891                     ; 352   Addr = WriteAddr % SPI_FLASH_PAGESIZE;
 893  010d 7b0e          	ld	a,(OFST+8,sp)
 894  010f 6b03          	ld	(OFST-3,sp),a
 895                     ; 354   count = SPI_FLASH_PAGESIZE - Addr;
 897  0111 4f            	clr	a
 898  0112 1003          	sub	a,(OFST-3,sp)
 899  0114 6b06          	ld	(OFST+0,sp),a
 900                     ; 356   NumOfPage =  NumByteToWrite / SPI_FLASH_PAGESIZE;
 902  0116 7b0f          	ld	a,(OFST+9,sp)
 903  0118 6b05          	ld	(OFST-1,sp),a
 904                     ; 358   NumOfSingle = NumByteToWrite % SPI_FLASH_PAGESIZE;
 906  011a 7b10          	ld	a,(OFST+10,sp)
 907  011c 6b04          	ld	(OFST-2,sp),a
 908                     ; 360   if (Addr == 0) /* WriteAddr is SPI_FLASH_PAGESIZE aligned  */
 910  011e 0d03          	tnz	(OFST-3,sp)
 911  0120 263a          	jrne	L342
 912                     ; 364     if (NumOfPage == 0) /* NumByteToWrite < SPI_FLASH_PAGESIZE */
 914  0122 7b05          	ld	a,(OFST-1,sp)
 915  0124 262b          	jrne	L352
 916                     ; 367       SPI_FLASH_PageWrite(pBuffer, WriteAddr, NumByteToWrite);
 919  0126 206c          	jp	L362
 920  0128               L152:
 921                     ; 377         SPI_FLASH_PageWrite(pBuffer, WriteAddr, SPI_FLASH_PAGESIZE);
 923  0128 ae0100        	ldw	x,#256
 924  012b 89            	pushw	x
 925  012c 1e0f          	ldw	x,(OFST+9,sp)
 926  012e 89            	pushw	x
 927  012f 1e0f          	ldw	x,(OFST+9,sp)
 928  0131 89            	pushw	x
 929  0132 1e0d          	ldw	x,(OFST+7,sp)
 930  0134 cd00b1        	call	_SPI_FLASH_PageWrite
 932  0137 5b06          	addw	sp,#6
 933                     ; 379         WriteAddr +=  SPI_FLASH_PAGESIZE;
 935  0139 ae0100        	ldw	x,#256
 936  013c bf02          	ldw	c_lreg+2,x
 937  013e 5f            	clrw	x
 938  013f bf00          	ldw	c_lreg,x
 939  0141 96            	ldw	x,sp
 940  0142 1c000b        	addw	x,#OFST+5
 941  0145 cd0000        	call	c_lgadd
 943                     ; 381          pBuffer += SPI_FLASH_PAGESIZE;
 945  0148 1e07          	ldw	x,(OFST+1,sp)
 946  014a 1c0100        	addw	x,#256
 947  014d 1f07          	ldw	(OFST+1,sp),x
 948  014f 7b05          	ld	a,(OFST-1,sp)
 949  0151               L352:
 950                     ; 374       while (NumOfPage--)
 952  0151 0a05          	dec	(OFST-1,sp)
 953  0153 4d            	tnz	a
 954  0154 26d2          	jrne	L152
 955                     ; 384       SPI_FLASH_PageWrite(pBuffer, WriteAddr, NumOfSingle);
 957  0156 7b04          	ld	a,(OFST-2,sp)
 958  0158               LC003:
 960  0158 5f            	clrw	x
 961  0159 97            	ld	xl,a
 963  015a 203a          	jp	LC001
 964  015c               L342:
 965                     ; 394     if (NumOfPage == 0) /* NumByteToWrite < SPI_FLASH_PAGESIZE */
 967  015c 0d05          	tnz	(OFST-1,sp)
 968  015e 2647          	jrne	L162
 969                     ; 398       if (NumOfSingle > count) /* (NumByteToWrite + WriteAddr) > SPI_FLASH_PAGESIZE */
 971  0160 1006          	sub	a,(OFST+0,sp)
 972  0162 2330          	jrule	L362
 973                     ; 402         temp = NumOfSingle - count;
 975  0164 6b03          	ld	(OFST-3,sp),a
 976                     ; 404         SPI_FLASH_PageWrite(pBuffer, WriteAddr, count);
 978  0166 5f            	clrw	x
 979  0167 7b06          	ld	a,(OFST+0,sp)
 980  0169 97            	ld	xl,a
 981  016a 89            	pushw	x
 982  016b 1e0f          	ldw	x,(OFST+9,sp)
 983  016d 89            	pushw	x
 984  016e 1e0f          	ldw	x,(OFST+9,sp)
 985  0170 89            	pushw	x
 986  0171 1e0d          	ldw	x,(OFST+7,sp)
 987  0173 cd00b1        	call	_SPI_FLASH_PageWrite
 989  0176 5b06          	addw	sp,#6
 990                     ; 406         WriteAddr +=  count;
 992  0178 7b06          	ld	a,(OFST+0,sp)
 993  017a 96            	ldw	x,sp
 994  017b 1c000b        	addw	x,#OFST+5
 995  017e 88            	push	a
 996  017f cd0000        	call	c_lgadc
 998  0182 84            	pop	a
 999                     ; 408         pBuffer += count;
1001  0183 7b06          	ld	a,(OFST+0,sp)
1002  0185 5f            	clrw	x
1003  0186 97            	ld	xl,a
1004  0187 1f01          	ldw	(OFST-5,sp),x
1005  0189 1e07          	ldw	x,(OFST+1,sp)
1006  018b 72fb01        	addw	x,(OFST-5,sp)
1007  018e 1f07          	ldw	(OFST+1,sp),x
1008                     ; 410         SPI_FLASH_PageWrite(pBuffer, WriteAddr, temp);
1010  0190 7b03          	ld	a,(OFST-3,sp)
1013  0192 20c4          	jp	LC003
1014  0194               L362:
1015                     ; 417       SPI_FLASH_PageWrite(pBuffer, WriteAddr, NumByteToWrite);
1018  0194 1e0f          	ldw	x,(OFST+9,sp)
1020  0196               LC001:
1021  0196 89            	pushw	x
1022  0197 1e0f          	ldw	x,(OFST+9,sp)
1023  0199 89            	pushw	x
1024  019a 1e0f          	ldw	x,(OFST+9,sp)
1025  019c 89            	pushw	x
1026  019d 1e0d          	ldw	x,(OFST+7,sp)
1027  019f cd00b1        	call	_SPI_FLASH_PageWrite
1028  01a2 5b06          	addw	sp,#6
1029  01a4               L752:
1030                     ; 461 }
1033  01a4 5b08          	addw	sp,#8
1034  01a6 81            	ret	
1035  01a7               L162:
1036                     ; 425       NumByteToWrite -= count;
1038  01a7 7b06          	ld	a,(OFST+0,sp)
1039  01a9 5f            	clrw	x
1040  01aa 97            	ld	xl,a
1041  01ab 1f01          	ldw	(OFST-5,sp),x
1042  01ad 1e0f          	ldw	x,(OFST+9,sp)
1043  01af 72f001        	subw	x,(OFST-5,sp)
1044  01b2 1f0f          	ldw	(OFST+9,sp),x
1045                     ; 427       NumOfPage =  NumByteToWrite / SPI_FLASH_PAGESIZE;
1047  01b4 7b0f          	ld	a,(OFST+9,sp)
1048  01b6 6b05          	ld	(OFST-1,sp),a
1049                     ; 429       NumOfSingle = NumByteToWrite % SPI_FLASH_PAGESIZE;
1051  01b8 7b10          	ld	a,(OFST+10,sp)
1052  01ba 6b04          	ld	(OFST-2,sp),a
1053                     ; 431       SPI_FLASH_PageWrite(pBuffer, WriteAddr, count);
1055  01bc 5f            	clrw	x
1056  01bd 7b06          	ld	a,(OFST+0,sp)
1057  01bf 97            	ld	xl,a
1058  01c0 89            	pushw	x
1059  01c1 1e0f          	ldw	x,(OFST+9,sp)
1060  01c3 89            	pushw	x
1061  01c4 1e0f          	ldw	x,(OFST+9,sp)
1062  01c6 89            	pushw	x
1063  01c7 1e0d          	ldw	x,(OFST+7,sp)
1064  01c9 cd00b1        	call	_SPI_FLASH_PageWrite
1066  01cc 5b06          	addw	sp,#6
1067                     ; 433       WriteAddr +=  count;
1069  01ce 7b06          	ld	a,(OFST+0,sp)
1070  01d0 96            	ldw	x,sp
1071  01d1 1c000b        	addw	x,#OFST+5
1072  01d4 88            	push	a
1073  01d5 cd0000        	call	c_lgadc
1075  01d8 84            	pop	a
1076                     ; 435       pBuffer += count;
1078  01d9 7b06          	ld	a,(OFST+0,sp)
1079  01db 5f            	clrw	x
1080  01dc 97            	ld	xl,a
1081  01dd 1f01          	ldw	(OFST-5,sp),x
1082  01df 1e07          	ldw	x,(OFST+1,sp)
1083  01e1 72fb01        	addw	x,(OFST-5,sp)
1085  01e4 2025          	jra	L372
1086  01e6               L172:
1087                     ; 441         SPI_FLASH_PageWrite(pBuffer, WriteAddr, SPI_FLASH_PAGESIZE);
1089  01e6 ae0100        	ldw	x,#256
1090  01e9 89            	pushw	x
1091  01ea 1e0f          	ldw	x,(OFST+9,sp)
1092  01ec 89            	pushw	x
1093  01ed 1e0f          	ldw	x,(OFST+9,sp)
1094  01ef 89            	pushw	x
1095  01f0 1e0d          	ldw	x,(OFST+7,sp)
1096  01f2 cd00b1        	call	_SPI_FLASH_PageWrite
1098  01f5 5b06          	addw	sp,#6
1099                     ; 443         WriteAddr +=  SPI_FLASH_PAGESIZE;
1101  01f7 ae0100        	ldw	x,#256
1102  01fa bf02          	ldw	c_lreg+2,x
1103  01fc 5f            	clrw	x
1104  01fd bf00          	ldw	c_lreg,x
1105  01ff 96            	ldw	x,sp
1106  0200 1c000b        	addw	x,#OFST+5
1107  0203 cd0000        	call	c_lgadd
1109                     ; 445         pBuffer += SPI_FLASH_PAGESIZE;
1111  0206 1e07          	ldw	x,(OFST+1,sp)
1112  0208 1c0100        	addw	x,#256
1113  020b               L372:
1114  020b 1f07          	ldw	(OFST+1,sp),x
1115                     ; 437       while (NumOfPage--)
1117  020d 7b05          	ld	a,(OFST-1,sp)
1118  020f 0a05          	dec	(OFST-1,sp)
1119  0211 4d            	tnz	a
1120  0212 26d2          	jrne	L172
1121                     ; 449       if (NumOfSingle != 0)
1123  0214 7b04          	ld	a,(OFST-2,sp)
1124  0216 278c          	jreq	L752
1125                     ; 453         SPI_FLASH_PageWrite(pBuffer, WriteAddr, NumOfSingle);
1127  0218 cc0158        	jp	LC003
1180                     ; 470 void SPI_FLASH_BufferRead(u8* pBuffer, u32 ReadAddr, u16 NumByteToRead)
1180                     ; 471 
1180                     ; 472 
1180                     ; 473 {
1181                     	switch	.text
1182  021b               _SPI_FLASH_BufferRead:
1184  021b 89            	pushw	x
1185       00000000      OFST:	set	0
1188                     ; 476   SPI_FLASH_CS_LOW();
1190  021c cd0007        	call	_SPI_FLASH_CS_LOW
1192                     ; 480   SPI_FLASH_SendByte(READ);
1194  021f a603          	ld	a,#3
1195  0221 cd0000        	call	_SPI_FLASH_SendByte
1197                     ; 484   SPI_FLASH_SendByte((ReadAddr & 0xFF0000) >> 16);
1199  0224 96            	ldw	x,sp
1200  0225 1c0005        	addw	x,#OFST+5
1201  0228 cd0000        	call	c_ltor
1203  022b 3f03          	clr	c_lreg+3
1204  022d 3f02          	clr	c_lreg+2
1205  022f 3f00          	clr	c_lreg
1206  0231 a610          	ld	a,#16
1207  0233 cd0000        	call	c_lursh
1209  0236 b603          	ld	a,c_lreg+3
1210  0238 cd0000        	call	_SPI_FLASH_SendByte
1212                     ; 488   SPI_FLASH_SendByte((ReadAddr& 0xFF00) >> 8);
1214  023b 96            	ldw	x,sp
1215  023c 1c0005        	addw	x,#OFST+5
1216  023f cd0000        	call	c_ltor
1218  0242 3f03          	clr	c_lreg+3
1219  0244 3f01          	clr	c_lreg+1
1220  0246 3f00          	clr	c_lreg
1221  0248 a608          	ld	a,#8
1222  024a cd0000        	call	c_lursh
1224  024d b603          	ld	a,c_lreg+3
1225  024f cd0000        	call	_SPI_FLASH_SendByte
1227                     ; 492   SPI_FLASH_SendByte(ReadAddr & 0xFF);
1229  0252 7b08          	ld	a,(OFST+8,sp)
1230  0254 cd0000        	call	_SPI_FLASH_SendByte
1233  0257 200b          	jra	L523
1234  0259               L323:
1235                     ; 499     *pBuffer = SPI_FLASH_SendByte(DUMMY_BYTE);
1237  0259 a6a5          	ld	a,#165
1238  025b cd0000        	call	_SPI_FLASH_SendByte
1240  025e 1e01          	ldw	x,(OFST+1,sp)
1241  0260 f7            	ld	(x),a
1242                     ; 503     pBuffer++;
1244  0261 5c            	incw	x
1245  0262 1f01          	ldw	(OFST+1,sp),x
1246  0264               L523:
1247                     ; 494   while (NumByteToRead--)  /* while there is data to be read */
1249  0264 1e09          	ldw	x,(OFST+9,sp)
1250  0266 5a            	decw	x
1251  0267 1f09          	ldw	(OFST+9,sp),x
1252  0269 5c            	incw	x
1253  026a 26ed          	jrne	L323
1254                     ; 508   SPI_FLASH_CS_HIGH();
1256  026c cd0011        	call	_SPI_FLASH_CS_HIGH
1258                     ; 510 }
1261  026f 85            	popw	x
1262  0270 81            	ret	
1290                     ; 526 void Flash_ChipErase(void) 
1290                     ; 527 
1290                     ; 528 { 
1291                     	switch	.text
1292  0271               _Flash_ChipErase:
1296                     ; 532 SPI_FLASH_WriteEnable(); 
1298  0271 ad0f          	call	_SPI_FLASH_WriteEnable
1300                     ; 534 SPI_FLASH_CS_LOW(); 
1302  0273 cd0007        	call	_SPI_FLASH_CS_LOW
1304                     ; 536 f_spistatus=2; 
1306  0276 35020000      	mov	_f_spistatus,#2
1307                     ; 538 SPI_DSP_SendByte(0xc7); 
1309  027a a6c7          	ld	a,#199
1310  027c cd0000        	call	_SPI_DSP_SendByte
1312                     ; 540 SPI_FLASH_CS_HIGH(); 
1315                     ; 546 } 
1318  027f cc0011        	jp	_SPI_FLASH_CS_HIGH
1347                     ; 560 void SPI_FLASH_WriteEnable(void) 
1347                     ; 561 
1347                     ; 562 { 
1348                     	switch	.text
1349  0282               _SPI_FLASH_WriteEnable:
1353                     ; 564 SPI_FLASH_CS_LOW(); 
1355  0282 cd0007        	call	_SPI_FLASH_CS_LOW
1357                     ; 566 SpiDelay(); 
1359  0285 cd0023        	call	_SpiDelay
1361                     ; 568 f_spistatus=3; 
1363  0288 35030000      	mov	_f_spistatus,#3
1364                     ; 570 SPI_DSP_SendByte(WREN); 
1366  028c a606          	ld	a,#6
1367  028e cd0000        	call	_SPI_DSP_SendByte
1369                     ; 572 SPI_FLASH_CS_HIGH(); 
1372                     ; 574 } 
1375  0291 cc0011        	jp	_SPI_FLASH_CS_HIGH
1435                     	xdef	_SPI_FLASH_BufferRead
1436                     	xdef	_SPI_FLASH_BufferWrite
1437                     	xdef	_SPI_FLASH_PageWrite
1438                     	xdef	_SPI_FLASH_SectorErase
1439                     	xdef	_vFlash_Read_Status
1440                     	xdef	_SPI_FLASH_CS_HIGH
1441                     	xdef	_SPI_FLASH_CS_LOW
1442                     	xdef	_Tx_Buffer
1443                     	switch	.bss
1444  0000               _Flash_status_buf:
1445  0000 0000          	ds.b	2
1446                     	xdef	_Flash_status_buf
1447                     	xdef	_WREN
1448                     	xdef	_tSpiWriteAddr
1449                     	xdef	_f_spistatus
1450  0002               _DEVICE_ID:
1451  0002 0000          	ds.b	2
1452                     	xdef	_DEVICE_ID
1453                     	xref	_SPI_DSP_SendByte
1454                     	xdef	_Spi_Flash_init
1455                     	xdef	_ReadDeviceID
1456                     	xdef	_SPI_FLASH_SendByte
1457                     	xdef	_Flash_ChipErase
1458                     	xdef	_SPI_FLASH_WriteEnable
1459                     	xdef	_SpiDelay
1460                     	xref	_GPIO_WriteLow
1461                     	xref	_GPIO_WriteHigh
1462                     	xref.b	c_lreg
1482                     	xref	c_lgadc
1483                     	xref	c_lgadd
1484                     	xref	c_lursh
1485                     	xref	c_ltor
1486                     	end
