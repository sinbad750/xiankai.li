   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
 107                     ; 11 void initUart(UART1_Mode_TypeDef type)
 107                     ; 12 {	
 109                     	switch	.text
 110  0000               _initUart:
 114                     ; 13 	UART2_Init((u32)9600, UART2_WORDLENGTH_8D, UART2_STOPBITS_1, UART2_PARITY_NO,     UART2_SYNCMODE_CLOCK_DISABLE, type);
 116  0000 88            	push	a
 117  0001 4b80          	push	#128
 118  0003 4b00          	push	#0
 119  0005 4b00          	push	#0
 120  0007 4b00          	push	#0
 121  0009 ae2580        	ldw	x,#9600
 122  000c 89            	pushw	x
 123  000d 5f            	clrw	x
 124  000e 89            	pushw	x
 125  000f cd0000        	call	_UART2_Init
 127  0012 5b09          	addw	sp,#9
 128                     ; 18 	UART2_ITConfig(UART2_IT_RXNE_OR, ENABLE);
 130  0014 4b01          	push	#1
 131  0016 ae0205        	ldw	x,#517
 132  0019 cd0000        	call	_UART2_ITConfig
 134  001c 84            	pop	a
 135                     ; 21 	UART2_Cmd(ENABLE);
 137  001d a601          	ld	a,#1
 139                     ; 22 }
 142  001f cc0000        	jp	_UART2_Cmd
 183                     ; 27 void myputc(u8 c)
 183                     ; 28 {
 184                     	switch	.text
 185  0022               _myputc:
 187  0022 89            	pushw	x
 188       00000002      OFST:	set	2
 191                     ; 30  	j = 30000;
 193  0023 ae7530        	ldw	x,#30000
 194  0026 1f01          	ldw	(OFST-1,sp),x
 195                     ; 32 	UART2_SendData8(c);
 197  0028 cd0000        	call	_UART2_SendData8
 200  002b 2003          	jra	L56
 201  002d               L36:
 202                     ; 38 		       j--;
 204  002d 5a            	decw	x
 205  002e 1f01          	ldw	(OFST-1,sp),x
 206  0030               L56:
 207                     ; 35 	while ((UART2_GetFlagStatus(UART2_FLAG_TC) == RESET)&&j)
 209  0030 ae0040        	ldw	x,#64
 210  0033 cd0000        	call	_UART2_GetFlagStatus
 212  0036 4d            	tnz	a
 213  0037 2604          	jrne	L17
 215  0039 1e01          	ldw	x,(OFST-1,sp)
 216  003b 26f0          	jrne	L36
 217  003d               L17:
 218                     ; 42 }
 221  003d 85            	popw	x
 222  003e 81            	ret	
 261                     ; 45 void Wait_For_mSec(u16 n)
 261                     ; 46 {
 262                     	switch	.text
 263  003f               _Wait_For_mSec:
 265  003f 89            	pushw	x
 266  0040 89            	pushw	x
 267       00000002      OFST:	set	2
 270  0041 2009          	jra	L311
 271  0043               L111:
 272                     ; 51 		for(m=0;m<2500;m++)
 274  0043 5f            	clrw	x
 275  0044               L711:
 279  0044 5c            	incw	x
 282  0045 a309c4        	cpw	x,#2500
 283  0048 25fa          	jrult	L711
 284  004a 1f01          	ldw	(OFST-1,sp),x
 285  004c               L311:
 286                     ; 48 	while(n--)
 288  004c 1e03          	ldw	x,(OFST+1,sp)
 289  004e 5a            	decw	x
 290  004f 1f03          	ldw	(OFST+1,sp),x
 291  0051 5c            	incw	x
 292  0052 26ef          	jrne	L111
 293                     ; 54 }
 296  0054 5b04          	addw	sp,#4
 297  0056 81            	ret	
 340                     ; 56 void myputstr(unsigned char  *pFmt)
 340                     ; 57 {
 341                     	switch	.text
 342  0057               _myputstr:
 344  0057 89            	pushw	x
 345  0058 88            	push	a
 346       00000001      OFST:	set	1
 349  0059 1e02          	ldw	x,(OFST+1,sp)
 350  005b               L541:
 351                     ; 62 	ucBff = *pFmt; // get a character
 353  005b f6            	ld	a,(x)
 354  005c 6b01          	ld	(OFST+0,sp),a
 355                     ; 63 	if (ucBff == '\0') // check end of string
 357  005e 2603          	jrne	L151
 358                     ; 64 	break;
 359                     ; 68 }
 362  0060 5b03          	addw	sp,#3
 363  0062 81            	ret	
 364  0063               L151:
 365                     ; 65 	myputc(ucBff);  // put a character
 367  0063 adbd          	call	_myputc
 369                     ; 66 	pFmt++;           // next
 371  0065 1e02          	ldw	x,(OFST+1,sp)
 372  0067 5c            	incw	x
 373  0068 1f02          	ldw	(OFST+1,sp),x
 375  006a 20ef          	jra	L541
 378                     	switch	.data
 379  0000               _up_state:
 380  0000 00            	dc.b	0
 405                     ; 123 void Updata_Start(void)
 405                     ; 124 {
 406                     	switch	.text
 407  006c               _Updata_Start:
 411                     ; 125 	block_num=0x00;
 413  006c 5f            	clrw	x
 414  006d cf0000        	ldw	_block_num,x
 415                     ; 126 	rx_count=0x00;
 417  0070 725f0003      	clr	_rx_count
 418                     ; 127 	up_state=UP_STATE_START;
 420  0074 35010000      	mov	_up_state,#1
 421                     ; 130 	myputc('U');
 423  0078 a655          	ld	a,#85
 425                     ; 131 }
 428  007a 20a6          	jp	_myputc
 452                     ; 132 u8  Upg_Device(void)
 452                     ; 133 {
 453                     	switch	.text
 454  007c               _Upg_Device:
 458                     ; 134 	if(rx_buff[0]!='U') return UPG_DEVICE_NONE;
 460  007c c60004        	ld	a,_rx_buff
 461  007f a155          	cp	a,#85
 462  0081 2702          	jreq	L371
 465  0083 4f            	clr	a
 468  0084 81            	ret	
 469  0085               L371:
 470                     ; 135 	if(rx_buff[1]!='P') return UPG_DEVICE_NONE;
 472  0085 c60005        	ld	a,_rx_buff+1
 473  0088 a150          	cp	a,#80
 474  008a 2702          	jreq	L571
 477  008c 4f            	clr	a
 480  008d 81            	ret	
 481  008e               L571:
 482                     ; 136 	if(rx_buff[2]!='G') return UPG_DEVICE_NONE;
 484  008e c60006        	ld	a,_rx_buff+2
 485  0091 a147          	cp	a,#71
 486  0093 2702          	jreq	L771
 489  0095 4f            	clr	a
 492  0096 81            	ret	
 493  0097               L771:
 494                     ; 137 	if(rx_buff[3]!='R') return UPG_DEVICE_NONE;
 496  0097 c60007        	ld	a,_rx_buff+3
 497  009a a152          	cp	a,#82
 498  009c 2702          	jreq	L102
 501  009e 4f            	clr	a
 504  009f 81            	ret	
 505  00a0               L102:
 506                     ; 139 	if(rx_buff[4]=='M') 
 508  00a0 c60008        	ld	a,_rx_buff+4
 509  00a3 a14d          	cp	a,#77
 510  00a5 2603          	jrne	L302
 511                     ; 140 		return UPG_MCU;
 513  00a7 a601          	ld	a,#1
 516  00a9 81            	ret	
 517  00aa               L302:
 518                     ; 141 	else if(rx_buff[4]=='W') 
 520  00aa a157          	cp	a,#87
 521  00ac 2603          	jrne	L702
 522                     ; 142 		return UPG_WIRELESS;
 524  00ae a602          	ld	a,#2
 527  00b0 81            	ret	
 528  00b1               L702:
 529                     ; 144 	else if(rx_buff[4]=='A') 
 531  00b1 a141          	cp	a,#65
 532  00b3 2603          	jrne	L312
 533                     ; 145 		return ASK_VER;
 535  00b5 a603          	ld	a,#3
 538  00b7 81            	ret	
 539  00b8               L312:
 540                     ; 148 		return UPG_DEVICE_NONE;
 542  00b8 4f            	clr	a
 545  00b9 81            	ret	
 590                     ; 150 bool Is_Connect_Code(void)
 590                     ; 151 {
 591                     	switch	.text
 592  00ba               _Is_Connect_Code:
 596                     ; 152         if(rx_buff[0]=='p')
 598  00ba c60004        	ld	a,_rx_buff
 599  00bd a170          	cp	a,#112
 600  00bf 2603          	jrne	L732
 601                     ; 153 			return TRUE;
 603  00c1 a601          	ld	a,#1
 606  00c3 81            	ret	
 607  00c4               L732:
 608                     ; 154 		return FALSE;
 610  00c4 4f            	clr	a
 613  00c5 81            	ret	
 646                     ; 157 void vClear_RxBuff(void)
 646                     ; 158 {
 647                     	switch	.text
 648  00c6               _vClear_RxBuff:
 650  00c6 88            	push	a
 651       00000001      OFST:	set	1
 654                     ; 160 	for(i=0;i<130;i++)
 656  00c7 4f            	clr	a
 657  00c8 6b01          	ld	(OFST+0,sp),a
 658  00ca               L552:
 659                     ; 161 		rx_buff[i]=0xff;
 661  00ca 5f            	clrw	x
 662  00cb 97            	ld	xl,a
 663  00cc a6ff          	ld	a,#255
 664  00ce d70004        	ld	(_rx_buff,x),a
 665                     ; 160 	for(i=0;i<130;i++)
 667  00d1 0c01          	inc	(OFST+0,sp)
 670  00d3 7b01          	ld	a,(OFST+0,sp)
 671  00d5 a182          	cp	a,#130
 672  00d7 25f1          	jrult	L552
 673                     ; 162 }
 676  00d9 84            	pop	a
 677  00da 81            	ret	
 703                     ; 163 void vRxData_Start(void)
 703                     ; 164 {
 704                     	switch	.text
 705  00db               _vRxData_Start:
 709                     ; 165 	rx_count=0x00;
 711  00db 725f0003      	clr	_rx_count
 712                     ; 166 	check_sum=0x00;
 714  00df 725f0002      	clr	_check_sum
 715                     ; 167 	up_state=UP_STATE_RXBYTE_CNT;
 717  00e3 35020000      	mov	_up_state,#2
 718                     ; 168 }
 721  00e7 81            	ret	
 746                     ; 169 bool vUpg_Over(void)
 746                     ; 170 {
 747                     	switch	.text
 748  00e8               _vUpg_Over:
 752                     ; 171 	if(block_num<1024)  //768   96k
 754  00e8 ce0000        	ldw	x,_block_num
 755  00eb a30400        	cpw	x,#1024
 756  00ee 2402          	jruge	L303
 757                     ; 172 	return FALSE;
 759  00f0 4f            	clr	a
 762  00f1 81            	ret	
 763  00f2               L303:
 764                     ; 173 	return TRUE;
 766  00f2 a601          	ld	a,#1
 769  00f4 81            	ret	
 816                     ; 178 void Upgrade_RxData_Process(u8 rxdat)
 816                     ; 179 {
 817                     	switch	.text
 818  00f5               _Upgrade_RxData_Process:
 820  00f5 88            	push	a
 821       00000000      OFST:	set	0
 824                     ; 180           switch(up_state)
 826  00f6 c60000        	ld	a,_up_state
 828                     ; 225 			case UP_STATE_IDLE:
 828                     ; 226 			break;
 829  00f9 4a            	dec	a
 830  00fa 2709          	jreq	L503
 831  00fc 4a            	dec	a
 832  00fd 2710          	jreq	L703
 833  00ff 4a            	dec	a
 834  0100 2734          	jreq	L113
 835  0102 cc018d        	jra	L333
 836  0105               L503:
 837                     ; 182 		case UP_STATE_START:
 837                     ; 183 		if(rxdat==':')
 839  0105 7b01          	ld	a,(OFST+1,sp)
 840  0107 a13a          	cp	a,#58
 841  0109 26f7          	jrne	L333
 842                     ; 184 			vRxData_Start();
 844  010b adce          	call	_vRxData_Start
 846  010d 207e          	jra	L333
 847  010f               L703:
 848                     ; 186 		case UP_STATE_RXBYTE_CNT:
 848                     ; 187 		   if(rx_count<0x80)   /*128  Byte Input*****/
 850  010f c60003        	ld	a,_rx_count
 851  0112 a180          	cp	a,#128
 852  0114 2416          	jruge	L733
 853                     ; 189 			rx_buff[rx_count]=rxdat;
 855  0116 5f            	clrw	x
 856  0117 97            	ld	xl,a
 857  0118 7b01          	ld	a,(OFST+1,sp)
 858  011a d70004        	ld	(_rx_buff,x),a
 859                     ; 190 			check_sum+=rxdat;
 861  011d c60002        	ld	a,_check_sum
 862  0120 1b01          	add	a,(OFST+1,sp)
 863  0122 c70002        	ld	_check_sum,a
 864                     ; 191 			rx_count++;
 866  0125 725c0003      	inc	_rx_count
 867  0129 c60003        	ld	a,_rx_count
 868  012c               L733:
 869                     ; 193 		   if(rx_count==0x80)  /*128 Byte Ok****/
 871  012c a180          	cp	a,#128
 872  012e 265d          	jrne	L333
 873                     ; 194 			   up_state=UP_STATE_CHECKSUM;
 875  0130 35030000      	mov	_up_state,#3
 876  0134 2057          	jra	L333
 877  0136               L113:
 878                     ; 197 		   case UP_STATE_CHECKSUM:
 878                     ; 198 			rx_buff[rx_count]=rxdat;
 880  0136 c60003        	ld	a,_rx_count
 881  0139 5f            	clrw	x
 882  013a 97            	ld	xl,a
 883  013b 7b01          	ld	a,(OFST+1,sp)
 884  013d d70004        	ld	(_rx_buff,x),a
 885                     ; 199 			if(check_sum==rxdat)   /*Check OK*/
 887  0140 c60002        	ld	a,_check_sum
 888  0143 1101          	cp	a,(OFST+1,sp)
 889  0145 263d          	jrne	L343
 890                     ; 201 				Wireless_Tx_Upgrade(rx_buff);
 892  0147 ae0004        	ldw	x,#_rx_buff
 893  014a cd0000        	call	_Wireless_Tx_Upgrade
 895                     ; 202 				block_num++;
 897  014d ce0000        	ldw	x,_block_num
 898  0150 5c            	incw	x
 899  0151 cf0000        	ldw	_block_num,x
 900                     ; 203 				vLed_Display_Upg(block_num);
 902  0154 c60001        	ld	a,_block_num+1
 903  0157 cd0000        	call	_vLed_Display_Upg
 905                     ; 204 				if(vUpg_Over())
 907  015a ad8c          	call	_vUpg_Over
 909  015c 4d            	tnz	a
 910  015d 2721          	jreq	L543
 911                     ; 206 					myputc('#');
 913  015f a623          	ld	a,#35
 914  0161 cd0022        	call	_myputc
 916                     ; 207 					up_state=UP_STATE_IDLE;
 918  0164 725f0000      	clr	_up_state
 919                     ; 208 					GPIO_Init(UART_Port, UART_Port_TX_Pin, GPIO_MODE_IN_FL_NO_IT);  /*for uart 2 tx***/
 921  0168 4b00          	push	#0
 922  016a 4b20          	push	#32
 923  016c ae500f        	ldw	x,#20495
 924  016f cd0000        	call	_GPIO_Init
 926  0172 85            	popw	x
 927                     ; 210 	                           UART2_DeInit();
 929  0173 cd0000        	call	_UART2_DeInit
 931                     ; 212                                   initUart(UART2_MODE_RX_ENABLE);
 933  0176 a608          	ld	a,#8
 934  0178 cd0000        	call	_initUart
 936                     ; 213 					Wireless_Reset();
 938  017b cd0000        	call	_Wireless_Reset
 940                     ; 215 					break;
 942  017e 200d          	jra	L333
 943  0180               L543:
 944                     ; 218 					myputc('.');
 946  0180 a62e          	ld	a,#46
 948  0182 2002          	jra	L153
 949  0184               L343:
 950                     ; 221 				myputc('k');
 952  0184 a66b          	ld	a,#107
 954  0186               L153:
 955  0186 cd0022        	call	_myputc
 956                     ; 222 			up_state=UP_STATE_START;
 958  0189 35010000      	mov	_up_state,#1
 959                     ; 223 			break;
 961                     ; 225 			case UP_STATE_IDLE:
 961                     ; 226 			break;
 963  018d               L333:
 964                     ; 228 }
 967  018d 84            	pop	a
 968  018e 81            	ret	
 996                     ; 230 void Wireless_Enter_Upgrade(void)
 996                     ; 231 {  
 997                     	switch	.text
 998  018f               _Wireless_Enter_Upgrade:
1002                     ; 233         UART2_DeInit();
1004  018f cd0000        	call	_UART2_DeInit
1006                     ; 234         initUart(UART2_MODE_TXRX_ENABLE);
1008  0192 a60c          	ld	a,#12
1009  0194 cd0000        	call	_initUart
1011                     ; 235 	 vClear_RxBuff();
1013  0197 cd00c6        	call	_vClear_RxBuff
1015                     ; 236 	 Wireless_Upg_Init();
1018                     ; 238 }
1021  019a cc0000        	jp	_Wireless_Upg_Init
1051                     ; 243 void  MCU_Upgrade(void)
1051                     ; 244 {
1052                     	switch	.text
1053  019d               _MCU_Upgrade:
1057                     ; 245         UART2_Cmd(DISABLE);
1059  019d 4f            	clr	a
1060  019e cd0000        	call	_UART2_Cmd
1062                     ; 247 	FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
1064  01a1 4f            	clr	a
1065  01a2 cd0000        	call	_FLASH_SetProgrammingTime
1067                     ; 249 	FLASH_Unlock(FLASH_MEMTYPE_DATA);
1069  01a5 a601          	ld	a,#1
1070  01a7 cd0000        	call	_FLASH_Unlock
1072                     ; 251 	FLASH_ProgramByte((0x4050), 'U');
1074  01aa 4b55          	push	#85
1075  01ac ae4050        	ldw	x,#16464
1076  01af 89            	pushw	x
1077  01b0 5f            	clrw	x
1078  01b1 89            	pushw	x
1079  01b2 cd0000        	call	_FLASH_ProgramByte
1081  01b5 5b05          	addw	sp,#5
1082                     ; 253 	FLASH_Lock(FLASH_MEMTYPE_DATA);
1084  01b7 a601          	ld	a,#1
1085  01b9 cd0000        	call	_FLASH_Lock
1087                     ; 256 	Wireless_Reset();
1089  01bc cd0000        	call	_Wireless_Reset
1091                     ; 258 	WWDG_SWReset();
1094                     ; 259 }
1097  01bf cc0000        	jp	_WWDG_SWReset
1128                     ; 261 void Upgrade_Loop(void)
1128                     ; 262 {
1129                     	switch	.text
1130  01c2               _Upgrade_Loop:
1134                     ; 263 	if(rx_count==0x05)
1136  01c2 c60003        	ld	a,_rx_count
1137  01c5 a105          	cp	a,#5
1138  01c7 2631          	jrne	L304
1139                     ; 267 		if(Upg_Device()==UPG_WIRELESS)
1141  01c9 cd007c        	call	_Upg_Device
1143  01cc a102          	cp	a,#2
1144  01ce 2602          	jrne	L504
1145                     ; 268 			Wireless_Enter_Upgrade();
1147  01d0 adbd          	call	_Wireless_Enter_Upgrade
1149  01d2               L504:
1150                     ; 271 		if(Upg_Device()==UPG_MCU)
1152  01d2 cd007c        	call	_Upg_Device
1154  01d5 4a            	dec	a
1155  01d6 2602          	jrne	L704
1156                     ; 272 			MCU_Upgrade();
1158  01d8 adc3          	call	_MCU_Upgrade
1160  01da               L704:
1161                     ; 273 		if(Upg_Device()==ASK_VER)
1163  01da cd007c        	call	_Upg_Device
1165  01dd a103          	cp	a,#3
1166  01df 2607          	jrne	L114
1167                     ; 275 			Send_Surr_Info();
1169  01e1 cd0000        	call	_Send_Surr_Info
1171                     ; 276 			rx_count=0;
1173  01e4 725f0003      	clr	_rx_count
1174  01e8               L114:
1175                     ; 278 	if((Is_Connect_Code())&&(up_state==UP_STATE_IDLE))
1177  01e8 cd00ba        	call	_Is_Connect_Code
1179  01eb 4d            	tnz	a
1180  01ec 270c          	jreq	L304
1182  01ee c60000        	ld	a,_up_state
1183  01f1 2607          	jrne	L304
1184                     ; 280 			Wireless_Write_ConectCode();
1186  01f3 cd0000        	call	_Wireless_Write_ConectCode
1188                     ; 281 			rx_count=0;
1190  01f6 725f0003      	clr	_rx_count
1191  01fa               L304:
1192                     ; 285 }
1195  01fa 81            	ret	
1288                     	xdef	_vUpg_Over
1289                     	xdef	_vRxData_Start
1290                     	xdef	_vClear_RxBuff
1291                     	xdef	_Is_Connect_Code
1292                     	xdef	_Upg_Device
1293                     	switch	.bss
1294  0000               _block_num:
1295  0000 0000          	ds.b	2
1296                     	xdef	_block_num
1297  0002               _check_sum:
1298  0002 00            	ds.b	1
1299                     	xdef	_check_sum
1300                     	xdef	_myputstr
1301                     	xdef	_MCU_Upgrade
1302                     	xdef	_Updata_Start
1303                     	xdef	_Wait_For_mSec
1304                     	xdef	_Upgrade_RxData_Process
1305                     	xdef	_Upgrade_Loop
1306                     	xdef	_myputc
1307                     	xdef	_initUart
1308                     	xdef	_up_state
1309  0003               _rx_count:
1310  0003 00            	ds.b	1
1311                     	xdef	_rx_count
1312  0004               _rx_buff:
1313  0004 000000000000  	ds.b	130
1314                     	xdef	_rx_buff
1315                     	xref	_vLed_Display_Upg
1316                     	xref	_Send_Surr_Info
1317                     	xref	_Wireless_Write_ConectCode
1318                     	xdef	_Wireless_Enter_Upgrade
1319                     	xref	_Wireless_Upg_Init
1320                     	xref	_Wireless_Tx_Upgrade
1321                     	xref	_Wireless_Reset
1322                     	xref	_WWDG_SWReset
1323                     	xref	_UART2_GetFlagStatus
1324                     	xref	_UART2_SendData8
1325                     	xref	_UART2_ITConfig
1326                     	xref	_UART2_Cmd
1327                     	xref	_UART2_Init
1328                     	xref	_UART2_DeInit
1329                     	xref	_GPIO_Init
1330                     	xref	_FLASH_SetProgrammingTime
1331                     	xref	_FLASH_ProgramByte
1332                     	xref	_FLASH_Lock
1333                     	xref	_FLASH_Unlock
1353                     	end
