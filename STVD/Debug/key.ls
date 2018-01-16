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
 110  0000               _STB_FLAG:
 111  0000 00            	dc.b	0
 112  0001               _shor_key:
 113  0001 00            	dc.b	0
 114  0002               _shor_key_time:
 115  0002 00            	dc.b	0
 116  0003               _key_was_ready:
 117  0003 00            	dc.b	0
 118  0004               _bt_do_not_reconnect_flag:
 119  0004 00            	dc.b	0
 120  0005               _BT_R_nfc_disable_flag:
 121  0005 00            	dc.b	0
 122  0006               _i2c_buzy_flag:
 123  0006 00            	dc.b	0
 163                     ; 22 void Power_onoff_board(u8 onoff)
 163                     ; 23 
 163                     ; 24 {
 165                     	switch	.text
 166  0000               _Power_onoff_board:
 170                     ; 25    if(onoff)
 172  0000 4d            	tnz	a
 173  0001 270a          	jreq	L15
 174                     ; 27    	GPIO_WriteLow(GPIOB, GPIO_PIN_2);
 176  0003 4b04          	push	#4
 177  0005 ae5005        	ldw	x,#20485
 178  0008 cd0000        	call	_GPIO_WriteLow
 181  000b 2008          	jra	L35
 182  000d               L15:
 183                     ; 31    	GPIO_WriteHigh(GPIOB, GPIO_PIN_2);
 185  000d 4b04          	push	#4
 186  000f ae5005        	ldw	x,#20485
 187  0012 cd0000        	call	_GPIO_WriteHigh
 189  0015               L35:
 190  0015 84            	pop	a
 191                     ; 34 }
 194  0016 81            	ret	
 223                     ; 36 void Power_Off_direct(void)
 223                     ; 37 {
 224                     	switch	.text
 225  0017               _Power_Off_direct:
 229                     ; 39 	STB_FLAG=1;
 231  0017 a601          	ld	a,#1
 232  0019 c70000        	ld	_STB_FLAG,a
 233                     ; 40 	info_Tx_Wireless_Sod_BT_mode(1);
 235  001c cd0000        	call	_info_Tx_Wireless_Sod_BT_mode
 237                     ; 41 	Wait_For_mSec(300);	
 239  001f ae012c        	ldw	x,#300
 240  0022 cd0000        	call	_Wait_For_mSec
 242                     ; 42        System_PowerOff();	
 244  0025 cd0000        	call	_System_PowerOff
 246                     ; 43 	GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_OUT_PP_HIGH_FAST);	
 248  0028 4bf0          	push	#240
 249  002a 4b04          	push	#4
 250  002c ae5005        	ldw	x,#20485
 251  002f cd0000        	call	_GPIO_Init
 253  0032 4f            	clr	a
 254  0033 85            	popw	x
 255                     ; 44 	Power_onoff_board(OFF);
 258                     ; 46 }
 261  0034 20ca          	jp	_Power_onoff_board
 294                     ; 51 unsigned char Key_Value(void)
 294                     ; 52 {
 295                     	switch	.text
 296  0036               _Key_Value:
 298  0036 88            	push	a
 299       00000001      OFST:	set	1
 302                     ; 54 	temp=0;
 304                     ; 59        temp = GPIO_ReadInputPin(GPIOC,GPIO_PIN_2); // POWER KEY DETECT
 306  0037 4b04          	push	#4
 307  0039 ae500a        	ldw	x,#20490
 308  003c cd0000        	call	_GPIO_ReadInputPin
 310  003f 5b01          	addw	sp,#1
 311  0041 6b01          	ld	(OFST+0,sp),a
 312                     ; 61 	if(temp == 0x00)
 314  0043 2605          	jrne	L101
 315                     ; 62 		return 0x02;
 317  0045 a602          	ld	a,#2
 320  0047 5b01          	addw	sp,#1
 321  0049 81            	ret	
 322  004a               L101:
 323                     ; 73 	temp = GPIO_ReadInputPin(GPIOB,GPIO_PIN_6);// SOD KEY 
 325  004a 4b40          	push	#64
 326  004c ae5005        	ldw	x,#20485
 327  004f cd0000        	call	_GPIO_ReadInputPin
 329  0052 5b01          	addw	sp,#1
 330  0054 6b01          	ld	(OFST+0,sp),a
 331                     ; 75 	if(temp == 0x00)
 333  0056 2605          	jrne	L301
 334                     ; 76 		return 0x04;
 336  0058 a604          	ld	a,#4
 339  005a 5b01          	addw	sp,#1
 340  005c 81            	ret	
 341  005d               L301:
 342                     ; 79 	return KEY_DUMMY;
 344  005d 4f            	clr	a
 347  005e 5b01          	addw	sp,#1
 348  0060 81            	ret	
 351                     	switch	.data
 352  0007               L701_prev_key:
 353  0007 00            	dc.b	0
 354                     	switch	.bss
 355  0000               L501_repeat_count:
 356  0000 0000          	ds.b	2
 404                     ; 84 void Key_Scan(void)
 404                     ; 85 {
 405                     	switch	.text
 406  0061               _Key_Scan:
 408  0061 88            	push	a
 409       00000001      OFST:	set	1
 412                     ; 90   if(key_was_ready)
 414  0062 c60003        	ld	a,_key_was_ready
 415  0065 2702          	jreq	L731
 416                     ; 91   	return;
 419  0067 84            	pop	a
 420  0068 81            	ret	
 421  0069               L731:
 422                     ; 94 		key_was_press=FALSE;
 424  0069 c70002        	ld	_key_was_press,a
 425                     ; 95 		if(KEY_DUMMY!=Key_Value())
 427  006c adc8          	call	_Key_Value
 429  006e 4d            	tnz	a
 430  006f 271f          	jreq	L141
 431                     ; 97 			curr_key=Key_Value();
 433  0071 adc3          	call	_Key_Value
 435  0073 6b01          	ld	(OFST+0,sp),a
 436                     ; 98 			if(curr_key==prev_key)
 438  0075 c10007        	cp	a,L701_prev_key
 439  0078 260f          	jrne	L541
 440                     ; 100 				if(repeat_count<500)
 442  007a ce0000        	ldw	x,L501_repeat_count
 443  007d a301f4        	cpw	x,#500
 444  0080 2404          	jruge	L741
 445                     ; 101 					repeat_count++;
 447  0082 5c            	incw	x
 448  0083 cf0000        	ldw	L501_repeat_count,x
 449  0086               L741:
 450                     ; 102 					key_command=curr_key;
 452  0086 c70003        	ld	_key_command,a
 453  0089               L541:
 454                     ; 104 			key_was_press=TRUE;
 456  0089 35010002      	mov	_key_was_press,#1
 457                     ; 105 			prev_key=curr_key;
 459  008d c70007        	ld	L701_prev_key,a
 460  0090               L141:
 461                     ; 109   switch(key_command)
 463  0090 c60003        	ld	a,_key_command
 465                     ; 147 	default:
 465                     ; 148 		break;
 466  0093 4a            	dec	a
 467  0094 2711          	jreq	L111
 468  0096 4a            	dec	a
 469  0097 270e          	jreq	L111
 470  0099 4a            	dec	a
 471  009a 270b          	jreq	L111
 472  009c 4a            	dec	a
 473  009d 2708          	jreq	L111
 474  009f 4a            	dec	a
 475  00a0 2734          	jreq	L311
 476  00a2 4a            	dec	a
 477  00a3 2731          	jreq	L311
 478  00a5 2045          	jra	L351
 479  00a7               L111:
 480                     ; 111   	case 0x01:
 480                     ; 112 	case 0x02:
 480                     ; 113 	case 0x03:
 480                     ; 114 	case 0x04:
 480                     ; 115 		if((repeat_count>3)&&(repeat_count<100)&&(!key_was_press))
 482  00a7 ce0000        	ldw	x,L501_repeat_count
 483  00aa a30004        	cpw	x,#4
 484  00ad 2514          	jrult	L551
 486  00af a30064        	cpw	x,#100
 487  00b2 240f          	jruge	L551
 489  00b4 c60002        	ld	a,_key_was_press
 490  00b7 260a          	jrne	L551
 491                     ; 117 				key_command |= SHORT_PRESS;
 493  00b9 721e0003      	bset	_key_command,#7
 494                     ; 118 				key_was_ready=TRUE;
 496  00bd 35010003      	mov	_key_was_ready,#1
 497                     ; 119 				return;
 500  00c1 84            	pop	a
 501  00c2 81            	ret	
 502  00c3               L551:
 503                     ; 121 		else if(repeat_count>200)
 505  00c3 a300c9        	cpw	x,#201
 506  00c6 2524          	jrult	L351
 507                     ; 123 			        key_command |= LONG_PRESS;
 509  00c8 721c0003      	bset	_key_command,#6
 510                     ; 124 				 key_was_ready=TRUE;
 512  00cc 35010003      	mov	_key_was_ready,#1
 513                     ; 125 				 repeat_count=0;
 515  00d0 5f            	clrw	x
 516  00d1 cf0000        	ldw	L501_repeat_count,x
 517                     ; 126 				 return;
 520  00d4 84            	pop	a
 521  00d5 81            	ret	
 522  00d6               L311:
 523                     ; 132 	case 0x05:
 523                     ; 133 	case 0x06:
 523                     ; 134 		
 523                     ; 135 	        if(repeat_count>180)
 525  00d6 ce0000        	ldw	x,L501_repeat_count
 526  00d9 a300b5        	cpw	x,#181
 527  00dc 250e          	jrult	L351
 528                     ; 137 			        key_command |= LONG_PRESS;
 530  00de 721c0003      	bset	_key_command,#6
 531                     ; 138 				key_was_ready=TRUE;
 533  00e2 35010003      	mov	_key_was_ready,#1
 534                     ; 139 				repeat_count=0;
 536  00e6 5f            	clrw	x
 537  00e7 cf0000        	ldw	L501_repeat_count,x
 538                     ; 140 				return;
 541  00ea 84            	pop	a
 542  00eb 81            	ret	
 543                     ; 147 	default:
 543                     ; 148 		break;
 545  00ec               L351:
 546                     ; 150   if(!key_was_press)
 548  00ec c60002        	ld	a,_key_was_press
 549  00ef 260a          	jrne	L561
 550                     ; 152 	  	prev_key=KEY_DUMMY;
 552  00f1 c70007        	ld	L701_prev_key,a
 553                     ; 153 		key_command=KEY_DUMMY;
 555  00f4 c70003        	ld	_key_command,a
 556                     ; 154 		repeat_count=0;
 558  00f7 5f            	clrw	x
 559  00f8 cf0000        	ldw	L501_repeat_count,x
 560  00fb               L561:
 561                     ; 156 }
 564  00fb 84            	pop	a
 565  00fc 81            	ret	
 608                     ; 159 void Key_Service(void)
 608                     ; 160 {
 609                     	switch	.text
 610  00fd               _Key_Service:
 612  00fd 88            	push	a
 613       00000001      OFST:	set	1
 616                     ; 162   KeyCode=KEY_DUMMY;
 618  00fe 0f01          	clr	(OFST+0,sp)
 619                     ; 163   if(key_was_ready)
 621  0100 c60003        	ld	a,_key_was_ready
 622  0103 2709          	jreq	L712
 623                     ; 165 			KeyCode=key_command;
 625  0105 c60003        	ld	a,_key_command
 626  0108 6b01          	ld	(OFST+0,sp),a
 627                     ; 166 			key_was_ready=FALSE;
 629  010a 725f0003      	clr	_key_was_ready
 630  010e               L712:
 631                     ; 169   switch(KeyCode)
 633  010e 7b01          	ld	a,(OFST+0,sp)
 635                     ; 258 		default:
 635                     ; 259 		break;
 636  0110 a042          	sub	a,#66
 637  0112 2718          	jreq	L761
 638  0114 a003          	sub	a,#3
 639  0116 2603cc01b2    	jreq	L322
 640  011b 4a            	dec	a
 641  011c 27fa          	jreq	L322
 642  011e a03c          	sub	a,#60
 643  0120 2717          	jreq	L171
 644  0122 a006          	sub	a,#6
 645  0124 2603cc01ab    	jreq	L371
 646  0129 cc01b2        	jra	L322
 647  012c               L761:
 648                     ; 172 		case KEY_LONG_POWER: 
 648                     ; 173 
 648                     ; 174 			  if(!Battery_Charge_Pin_Status())	
 650  012c 4b08          	push	#8
 651  012e ae5000        	ldw	x,#20480
 652  0131 cd0000        	call	_GPIO_ReadInputPin
 654  0134 5b01          	addw	sp,#1
 655  0136 4d            	tnz	a
 656  0137 2079          	jra	L322
 657  0139               L171:
 658                     ; 185 		case KEY_SHORT_POWER:   
 658                     ; 186 
 658                     ; 187 			
 658                     ; 188               if(Battery_Charge_Pin_Status())
 660  0139 4b08          	push	#8
 661  013b ae5000        	ldw	x,#20480
 662  013e cd0000        	call	_GPIO_ReadInputPin
 664  0141 5b01          	addw	sp,#1
 665  0143 4d            	tnz	a
 666  0144 2748          	jreq	L722
 667                     ; 191                        if(standby_flag)
 669  0146 c60000        	ld	a,_standby_flag
 670  0149 2726          	jreq	L132
 671                     ; 193                                     	 standby_flag=0;
 673  014b 725f0000      	clr	_standby_flag
 674                     ; 196 					         System_Standby(ON);	
 676  014f 4b08          	push	#8
 677  0151 ae500a        	ldw	x,#20490
 678  0154 cd0000        	call	_GPIO_WriteHigh
 680  0157 84            	pop	a
 681                     ; 198                                          if(Link_State==Link_None)
 684  0158 c60000        	ld	a,_Link_State
 685  015b 4a            	dec	a
 686  015c 2609          	jrne	L332
 687                     ; 199 					        Batt_16v_SW(ON);
 689  015e 4b80          	push	#128
 690  0160 ae500f        	ldw	x,#20495
 691  0163 cd0000        	call	_GPIO_WriteHigh
 693  0166 84            	pop	a
 694  0167               L332:
 695                     ; 201 		                            AMP_MUTE(OFF);
 697  0167 4b80          	push	#128
 698  0169 ae5014        	ldw	x,#20500
 699  016c cd0000        	call	_GPIO_WriteHigh
 703  016f 201a          	jp	LC001
 704  0171               L132:
 705                     ; 207               	      AMP_MUTE(ON);
 707  0171 4b80          	push	#128
 708  0173 ae5014        	ldw	x,#20500
 709  0176 cd0000        	call	_GPIO_WriteLow
 711  0179 84            	pop	a
 712                     ; 208 			      MCU_POWER_SW(OFF);
 715  017a 4b02          	push	#2
 716  017c ae500a        	ldw	x,#20490
 717  017f cd0000        	call	_GPIO_WriteLow
 719  0182 84            	pop	a
 720                     ; 209 		             Power_off_ready(ON);					 
 722  0183 4b08          	push	#8
 723  0185 ae500f        	ldw	x,#20495
 724  0188 cd0000        	call	_GPIO_WriteLow
 726  018b               LC001:
 727  018b 84            	pop	a
 728  018c 2008          	jra	L732
 729  018e               L722:
 730                     ; 214 		       shor_key++;	
 732  018e 725c0001      	inc	_shor_key
 733                     ; 215 			 shor_key_time=2;
 735  0192 35020002      	mov	_shor_key_time,#2
 736  0196               L732:
 737                     ; 219 		 if(shor_key==5)
 739  0196 c60001        	ld	a,_shor_key
 740  0199 a105          	cp	a,#5
 741  019b 2615          	jrne	L322
 742                     ; 222 		 	shor_key=0;
 744  019d 725f0001      	clr	_shor_key
 745                     ; 224                     key_command=KEY_GO_PAIRNG;
 747  01a1 35880003      	mov	_key_command,#136
 748                     ; 225                     key_was_ready=TRUE;
 750  01a5 35010003      	mov	_key_was_ready,#1
 751  01a9 2007          	jra	L322
 752  01ab               L371:
 753                     ; 233 			Wireless_Goto_Pairing();
 755  01ab cd0000        	call	_Wireless_Goto_Pairing
 757                     ; 234 			pairing_flag=80;
 759  01ae 35500000      	mov	_pairing_flag,#80
 760                     ; 237 		 	  break;  
 762                     ; 258 		default:
 762                     ; 259 		break;
 764  01b2               L322:
 765                     ; 261 }
 768  01b2 84            	pop	a
 769  01b3 81            	ret	
 887                     	xdef	_Key_Value
 888                     	switch	.bss
 889  0002               _key_was_press:
 890  0002 00            	ds.b	1
 891                     	xdef	_key_was_press
 892                     	xdef	_Power_Off_direct
 893                     	xdef	_Key_Scan
 894                     	xdef	_Key_Service
 895                     	xdef	_Power_onoff_board
 896                     	xdef	_shor_key
 897                     	xdef	_shor_key_time
 898                     	xdef	_bt_do_not_reconnect_flag
 899                     	xdef	_STB_FLAG
 900  0003               _key_command:
 901  0003 00            	ds.b	1
 902                     	xdef	_key_command
 903                     	xdef	_i2c_buzy_flag
 904                     	xdef	_BT_R_nfc_disable_flag
 905                     	xdef	_key_was_ready
 906                     	xref	_Wireless_Goto_Pairing
 907                     	xref	_info_Tx_Wireless_Sod_BT_mode
 908                     	xref	_System_PowerOff
 909                     	xref	_Link_State
 910                     	xref	_Wait_For_mSec
 911                     	xref	_pairing_flag
 912                     	xref	_standby_flag
 913                     	xref	_GPIO_ReadInputPin
 914                     	xref	_GPIO_WriteLow
 915                     	xref	_GPIO_WriteHigh
 916                     	xref	_GPIO_Init
 936                     	end
