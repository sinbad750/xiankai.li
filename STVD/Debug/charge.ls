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
 110  0000               _battery_charge:
 111  0000 03            	dc.b	3
 112  0001               _flag_charge_ing:
 113  0001 01            	dc.b	1
 114  0002               _system_800ms_tick:
 115  0002 00            	dc.b	0
 116  0003               _need_cut_time:
 117  0003 00            	dc.b	0
 118  0004               _need_cut_time2:
 119  0004 00            	dc.b	0
 120  0005               _Link_State:
 121  0005 02            	dc.b	2
 122  0006               _battery_quantity:
 123  0006 05            	dc.b	5
 124  0007               _voltage:
 125  0007 000a          	dc.w	10
 194                     ; 92 void Calculate_Voltage(u16 adc_value)
 194                     ; 93 {
 196                     	switch	.text
 197  0000               _Calculate_Voltage:
 199  0000 89            	pushw	x
 200  0001 5205          	subw	sp,#5
 201       00000005      OFST:	set	5
 204                     ; 95 	u16 sum=0x00;
 206  0003 5f            	clrw	x
 207  0004 1f04          	ldw	(OFST-1,sp),x
 208                     ; 97 	U1=33*adc_value/1023;
 210  0006 90ae0021      	ldw	y,#33
 211  000a 1e06          	ldw	x,(OFST+1,sp)
 212  000c cd0000        	call	c_imul
 214  000f 90ae03ff      	ldw	y,#1023
 215  0013 65            	divw	x,y
 216                     ; 98 	U2=U1*(604+220)/600;
 218  0014 90ae0338      	ldw	y,#824
 219  0018 cd0000        	call	c_imul
 221  001b 90ae0258      	ldw	y,#600
 222  001f 65            	divw	x,y
 223  0020 1f02          	ldw	(OFST-3,sp),x
 224                     ; 99 	vol_buff[vol_cnt]=U2;
 226  0022 5f            	clrw	x
 227  0023 c60001        	ld	a,_vol_cnt
 228  0026 97            	ld	xl,a
 229  0027 58            	sllw	x
 230  0028 1602          	ldw	y,(OFST-3,sp)
 231  002a df0002        	ldw	(_vol_buff,x),y
 232                     ; 100 	vol_cnt++;
 234  002d 725c0001      	inc	_vol_cnt
 235                     ; 101 	if(vol_cnt>9)
 237  0031 c60001        	ld	a,_vol_cnt
 238  0034 a10a          	cp	a,#10
 239  0036 2522          	jrult	L16
 240                     ; 104 		for(i=0;i<10;i++)
 242  0038 4f            	clr	a
 243  0039 6b01          	ld	(OFST-4,sp),a
 244  003b               L36:
 245                     ; 105 		sum+=vol_buff[i];
 247  003b 5f            	clrw	x
 248  003c 97            	ld	xl,a
 249  003d 58            	sllw	x
 250  003e de0002        	ldw	x,(_vol_buff,x)
 251  0041 72fb04        	addw	x,(OFST-1,sp)
 252  0044 1f04          	ldw	(OFST-1,sp),x
 253                     ; 104 		for(i=0;i<10;i++)
 255  0046 0c01          	inc	(OFST-4,sp)
 258  0048 7b01          	ld	a,(OFST-4,sp)
 259  004a a10a          	cp	a,#10
 260  004c 25ed          	jrult	L36
 261                     ; 106 			voltage=sum/10;
 263  004e 90ae000a      	ldw	y,#10
 264  0052 65            	divw	x,y
 265  0053 cf0007        	ldw	_voltage,x
 266                     ; 107 		vol_cnt=0x00;
 268  0056 725f0001      	clr	_vol_cnt
 269  005a               L16:
 270                     ; 109 }
 273  005a 5b07          	addw	sp,#7
 274  005c 81            	ret	
 277                     	switch	.data
 278  0009               L37_times:
 279  0009 00            	dc.b	0
 280                     	switch	.bss
 281  0000               L17_prev_quantity:
 282  0000 00            	ds.b	1
 382                     ; 112 void  Voltage_Detect(u16 adc_value)
 382                     ; 113 {
 383                     	switch	.text
 384  005d               _Voltage_Detect:
 386  005d 89            	pushw	x
 387  005e 88            	push	a
 388       00000001      OFST:	set	1
 391                     ; 118 	if(adc_value<_3P4V)   //6.6
 393  005f a30316        	cpw	x,#790
 394  0062 2404          	jruge	L141
 395                     ; 119 		quantity=Electric_Need_Cut;
 397  0064 a601          	ld	a,#1
 399  0066 202f          	jp	LC001
 400  0068               L141:
 401                     ; 122 	else if(adc_value>=_3P4V&&adc_value<_3P5V) 
 403  0068 1e02          	ldw	x,(OFST+1,sp)
 404  006a a30316        	cpw	x,#790
 405  006d 2505          	jrult	L541
 407  006f a30320        	cpw	x,#800
 408                     ; 123 		quantity=Electric_Empty;
 410  0072 250a          	jrult	LC002
 411  0074               L541:
 412                     ; 125 	else if(adc_value>=_3P5V&&adc_value<_3P6V) 
 414  0074 a30320        	cpw	x,#800
 415  0077 2509          	jrult	L151
 417  0079 a30326        	cpw	x,#806
 418  007c 2404          	jruge	L151
 419                     ; 126 		quantity=Electric_Empty;
 421  007e               LC002:
 423  007e a602          	ld	a,#2
 425  0080 2015          	jp	LC001
 426  0082               L151:
 427                     ; 128 	else if (adc_value>=_3P6V&&adc_value<_4P1V)     //7.8V 
 429  0082 a30326        	cpw	x,#806
 430  0085 2509          	jrult	L551
 432  0087 a303ac        	cpw	x,#940
 433  008a 2404          	jruge	L551
 434                     ; 129 		quantity=Electric_Near_Full;
 436  008c a604          	ld	a,#4
 438  008e 2007          	jp	LC001
 439  0090               L551:
 440                     ; 131 	else if (adc_value>=_4P1V)     //7.8V 
 442  0090 a303ac        	cpw	x,#940
 443  0093 2504          	jrult	L341
 444                     ; 132 		quantity=Electric_Full;
 446  0095 a605          	ld	a,#5
 447  0097               LC001:
 448  0097 6b01          	ld	(OFST+0,sp),a
 449  0099               L341:
 450                     ; 134 	if(prev_quantity!=quantity)
 452  0099 c60000        	ld	a,L17_prev_quantity
 453  009c 1101          	cp	a,(OFST+0,sp)
 454  009e 270b          	jreq	L361
 455                     ; 136 		times=0x00;
 457  00a0 725f0009      	clr	L37_times
 458                     ; 137 		prev_quantity=quantity;
 460  00a4 7b01          	ld	a,(OFST+0,sp)
 461  00a6 c70000        	ld	L17_prev_quantity,a
 463  00a9 2017          	jra	L561
 464  00ab               L361:
 465                     ; 141 		times++;
 467  00ab 725c0009      	inc	L37_times
 468                     ; 142 		if(times>2)
 470  00af c60009        	ld	a,L37_times
 471  00b2 a103          	cp	a,#3
 472  00b4 250c          	jrult	L561
 473                     ; 145 			if(battery_quantity>quantity)
 475  00b6 c60006        	ld	a,_battery_quantity
 476  00b9 1101          	cp	a,(OFST+0,sp)
 477  00bb 2305          	jrule	L561
 478                     ; 146 				battery_quantity=quantity;
 480  00bd 7b01          	ld	a,(OFST+0,sp)
 481  00bf c70006        	ld	_battery_quantity,a
 482  00c2               L561:
 483                     ; 149 	Calculate_Voltage(adc_value);
 485  00c2 1e02          	ldw	x,(OFST+1,sp)
 486  00c4 cd0000        	call	_Calculate_Voltage
 488                     ; 150 }
 491  00c7 5b03          	addw	sp,#3
 492  00c9 81            	ret	
 540                     ; 153 void Battery_Charge_Status(void)    //Every 800MS loop a time.
 540                     ; 154 {
 541                     	switch	.text
 542  00ca               _Battery_Charge_Status:
 544  00ca 88            	push	a
 545       00000001      OFST:	set	1
 548                     ; 160 					  if(!Battery_Charge_Pin_Status())
 550  00cb 4b08          	push	#8
 551  00cd ae5000        	ldw	x,#20480
 552  00d0 cd0000        	call	_GPIO_ReadInputPin
 554  00d3 5b01          	addw	sp,#1
 555  00d5 4d            	tnz	a
 556  00d6 261b          	jrne	L112
 557                     ; 163 					  if( charge_time>200)
 559  00d8 ce0000        	ldw	x,_charge_time
 560  00db a300c9        	cpw	x,#201
 561  00de 256e          	jrult	L712
 562                     ; 165 						battery_charge=_Charge_Ing;       //Charging
 564  00e0 35010000      	mov	_battery_charge,#1
 565                     ; 167 						if(!flag_charge_ing)
 567  00e4 725d0001      	tnz	_flag_charge_ing
 568  00e8 2664          	jrne	L712
 569                     ; 169 						flag_charge_ing=1;
 571  00ea 35010001      	mov	_flag_charge_ing,#1
 572                     ; 170 						charge_changeto_disconent_flag=0;
 574  00ee c70000        	ld	_charge_changeto_disconent_flag,a
 575  00f1 205b          	jra	L712
 576  00f3               L112:
 577                     ; 183 						battery_charge=_Charge_None;
 579  00f3 725f0000      	clr	_battery_charge
 580                     ; 184 						if(flag_charge_ing)
 582  00f7 c60001        	ld	a,_flag_charge_ing
 583  00fa 2752          	jreq	L712
 584                     ; 186 						flag_charge_ing=0;
 586  00fc 725f0001      	clr	_flag_charge_ing
 587                     ; 187 						charge_changeto_disconent_flag=0;
 589  0100 725f0000      	clr	_charge_changeto_disconent_flag
 590                     ; 189 						if(Wireless_State==_Wireless_None_Connect)
 592  0104 c60000        	ld	a,_Wireless_State
 593  0107 2625          	jrne	L322
 594                     ; 191                                                    if(OFF_USB_CHARGE_FLG)
 596  0109 c60000        	ld	a,_OFF_USB_CHARGE_FLG
 597  010c 2720          	jreq	L322
 598                     ; 193                                                    	 AMP_MUTE(ON);
 600  010e 4b80          	push	#128
 601  0110 ae5014        	ldw	x,#20500
 602  0113 cd0000        	call	_GPIO_WriteLow
 604  0116 84            	pop	a
 605                     ; 194                                                       Power_off_ready(ON);
 608  0117 4b08          	push	#8
 609  0119 ae500f        	ldw	x,#20495
 610  011c cd0000        	call	_GPIO_WriteLow
 612  011f ae03e8        	ldw	x,#1000
 613  0122 84            	pop	a
 614                     ; 195 							       Wait_For_mSec(1000);
 616  0123 cd0000        	call	_Wait_For_mSec
 618                     ; 196 							        standby_flag=1;
 620  0126 35010000      	mov	_standby_flag,#1
 621                     ; 197 								 OFF_USB_CHARGE_FLG=0;
 623  012a 725f0000      	clr	_OFF_USB_CHARGE_FLG
 624  012e               L322:
 625                     ; 202 							if(Link_State==Link_None)
 627  012e c60005        	ld	a,_Link_State
 628  0131 4a            	dec	a
 629  0132 261a          	jrne	L712
 630                     ; 205 						battery_quantity=Electric_Full;
 632  0134 35050006      	mov	_battery_quantity,#5
 633                     ; 206 						Get_Battery_temper_Status();
 635  0138 cd0220        	call	_Get_Battery_temper_Status
 637                     ; 207 						for(i=0;i<8;i++)
 639  013b 0f01          	clr	(OFST+0,sp)
 640  013d               L132:
 641                     ; 209 							Get_Battery_Status();
 643  013d cd0208        	call	_Get_Battery_Status
 645                     ; 210 							Wait_For_mSec(5);
 647  0140 ae0005        	ldw	x,#5
 648  0143 cd0000        	call	_Wait_For_mSec
 650                     ; 207 						for(i=0;i<8;i++)
 652  0146 0c01          	inc	(OFST+0,sp)
 655  0148 7b01          	ld	a,(OFST+0,sp)
 656  014a a108          	cp	a,#8
 657  014c 25ef          	jrult	L132
 658  014e               L712:
 659                     ; 248 }
 662  014e 84            	pop	a
 663  014f 81            	ret	
 696                     ; 249 void Battery_Status_Detect(void)
 696                     ; 250 {
 697                     	switch	.text
 698  0150               _Battery_Status_Detect:
 702                     ; 251 	if(Link_State==Link_On)
 704  0150 c60005        	ld	a,_Link_State
 705  0153 2651          	jrne	L742
 706                     ; 254 	    	if(!standby_charge_flag)
 708  0155 c60000        	ld	a,_standby_charge_flag
 709  0158 2609          	jrne	L152
 710                     ; 255 	              CHARGE_EN(OFF);
 712  015a 4b40          	push	#64
 713  015c ae5000        	ldw	x,#20480
 714  015f cd0000        	call	_GPIO_WriteHigh
 716  0162 84            	pop	a
 717  0163               L152:
 718                     ; 257 		if(!Main_Link_Status())
 720  0163 4b20          	push	#32
 721  0165 ae5005        	ldw	x,#20485
 722  0168 cd0000        	call	_GPIO_ReadInputPin
 724  016b 5b01          	addw	sp,#1
 725  016d 4d            	tnz	a
 726  016e 2703cc0207    	jrne	L162
 727                     ; 259 		      link_to_dislinktime++;
 729  0173 725c0000      	inc	_link_to_dislinktime
 730                     ; 260 			 if(link_to_dislinktime>20)
 732  0177 c60000        	ld	a,_link_to_dislinktime
 733  017a a115          	cp	a,#21
 734  017c 2523          	jrult	L552
 735                     ; 262 			       Link_State=Link_None;
 737  017e 35010005      	mov	_Link_State,#1
 738                     ; 263                            Batt_16v_SW(ON);
 740  0182 4b80          	push	#128
 741  0184 ae500f        	ldw	x,#20495
 742  0187 cd0000        	call	_GPIO_WriteHigh
 744  018a 84            	pop	a
 745                     ; 264 				CHARGE_EN(ON);
 747  018b 4b40          	push	#64
 748  018d ae5000        	ldw	x,#20480
 749  0190 cd0000        	call	_GPIO_WriteLow
 751  0193 725f0000      	clr	_link_to_dislinktime
 752  0197 35010000      	mov	_disp_timer,#1
 753  019b 725f0001      	clr	_flag_charge_ing
 754                     ; 265 				link_to_dislinktime=0;
 756                     ; 266 			       disp_timer=1;
 759                     ; 273 			flag_charge_ing=0;
 761  019f 2060          	jp	LC003
 762  01a1               L552:
 763                     ; 270 			 	 disp_timer=3;
 765  01a1 35030000      	mov	_disp_timer,#3
 766                     ; 271 			 	  return;
 769  01a5 81            	ret	
 770  01a6               L742:
 771                     ; 282 		if(Main_Link_Status())
 773  01a6 4b20          	push	#32
 774  01a8 ae5005        	ldw	x,#20485
 775  01ab cd0000        	call	_GPIO_ReadInputPin
 777  01ae 5b01          	addw	sp,#1
 778  01b0 4d            	tnz	a
 779  01b1 2750          	jreq	L362
 780                     ; 284 			Link_State=Link_On;
 782  01b3 725f0005      	clr	_Link_State
 783                     ; 285 			   Batt_16v_SW(OFF);
 785  01b7 4b80          	push	#128
 786  01b9 ae500f        	ldw	x,#20495
 787  01bc cd0000        	call	_GPIO_WriteLow
 789  01bf 725f0000      	clr	_link_to_dislinktime
 790  01c3 84            	pop	a
 791  01c4 725d0000      	tnz	_standby_charge_flag
 792                     ; 286 			link_to_dislinktime=0;
 794                     ; 287 			if(standby_charge_flag)
 796  01c8 270a          	jreq	L562
 797                     ; 288 			 CHARGE_EN(ON);
 799  01ca 4b40          	push	#64
 800  01cc ae5000        	ldw	x,#20480
 801  01cf cd0000        	call	_GPIO_WriteLow
 804  01d2 2008          	jra	L762
 805  01d4               L562:
 806                     ; 290 			 CHARGE_EN(OFF);	
 808  01d4 4b40          	push	#64
 809  01d6 ae5000        	ldw	x,#20480
 810  01d9 cd0000        	call	_GPIO_WriteHigh
 812  01dc               L762:
 813  01dc 725d0000      	tnz	_standby_flag
 814  01e0 84            	pop	a
 815                     ; 293 			if(standby_flag)
 817  01e1 2724          	jreq	L162
 818                     ; 295 		           standby_flag=0;
 820  01e3 725f0000      	clr	_standby_flag
 821                     ; 296 		   AMP_MUTE(OFF);	
 823  01e7 4b80          	push	#128
 824  01e9 ae5014        	ldw	x,#20500
 825  01ec cd0000        	call	_GPIO_WriteHigh
 827  01ef 84            	pop	a
 828                     ; 297 		   Batt_16v_SW(ON);
 831  01f0 4b80          	push	#128
 832  01f2 ae500f        	ldw	x,#20495
 833  01f5 cd0000        	call	_GPIO_WriteHigh
 835  01f8 84            	pop	a
 836                     ; 298 		   System_Standby(ON);
 838  01f9 4b08          	push	#8
 839  01fb ae500a        	ldw	x,#20490
 840  01fe cd0000        	call	_GPIO_WriteHigh
 842  0201               LC003:
 843  0201 84            	pop	a
 846  0202 81            	ret	
 847  0203               L362:
 848                     ; 304 			Link_State=Link_None;
 850  0203 35010005      	mov	_Link_State,#1
 851  0207               L162:
 852                     ; 308 }
 855  0207 81            	ret	
 884                     ; 313 void Get_Battery_Status(void)
 884                     ; 314 {
 885                     	switch	.text
 886  0208               _Get_Battery_Status:
 890                     ; 316 	ADC1_ClearFlag();
 892  0208 cd0000        	call	_ADC1_ClearFlag
 894                     ; 317        Init_ADC9();
 896  020b cd0000        	call	_Init_ADC9
 899  020e               L703:
 900                     ; 318       while(ADC1_GetFlagStatus()==RESET) ;
 902  020e cd0000        	call	_ADC1_GetFlagStatus
 904  0211 4d            	tnz	a
 905  0212 27fa          	jreq	L703
 906                     ; 319          ADC1_ClearFlag();
 908  0214 cd0000        	call	_ADC1_ClearFlag
 910                     ; 321 	adc_value=ADC1_GetConversionValue();
 912  0217 cd0000        	call	_ADC1_GetConversionValue
 914  021a cf0016        	ldw	_adc_value,x
 915                     ; 322 	Voltage_Detect(adc_value);
 918                     ; 323 }
 921  021d cc005d        	jp	_Voltage_Detect
 950                     ; 325 void Get_Battery_temper_Status(void)
 950                     ; 326 {
 951                     	switch	.text
 952  0220               _Get_Battery_temper_Status:
 956                     ; 327 	ADC1_ClearFlag();
 958  0220 cd0000        	call	_ADC1_ClearFlag
 960                     ; 328        Init_ADC1();
 962  0223 cd0000        	call	_Init_ADC1
 965  0226               L523:
 966                     ; 329        while(ADC1_GetFlagStatus()==RESET) ;
 968  0226 cd0000        	call	_ADC1_GetFlagStatus
 970  0229 4d            	tnz	a
 971  022a 27fa          	jreq	L523
 972                     ; 330        ADC1_ClearFlag();
 974  022c cd0000        	call	_ADC1_ClearFlag
 976                     ; 332      temper_value=ADC1_GetConversionValue();
 978  022f cd0000        	call	_ADC1_GetConversionValue
 980  0232 cf0000        	ldw	_temper_value,x
 981                     ; 334 }
 984  0235 81            	ret	
1020                     ; 337 void Charge_Manager_Loop(void)  // loop every 
1020                     ; 338 {
1021                     	switch	.text
1022  0236               _Charge_Manager_Loop:
1026                     ; 339         Battery_Status_Detect();
1028  0236 cd0150        	call	_Battery_Status_Detect
1030                     ; 341 	if(system_800ms_tick>40)   //800ms  //35
1032  0239 c60002        	ld	a,_system_800ms_tick
1033  023c a129          	cp	a,#41
1034  023e 256b          	jrult	L143
1035                     ; 343 		       system_800ms_tick=0x00;
1037  0240 725f0002      	clr	_system_800ms_tick
1038                     ; 344 		        Get_Battery_Status(); 
1040  0244 adc2          	call	_Get_Battery_Status
1042                     ; 345 			  Get_Battery_temper_Status();
1044  0246 add8          	call	_Get_Battery_temper_Status
1046                     ; 346 		if(Link_State==Link_On)
1048  0248 c60005        	ld	a,_Link_State
1049  024b 2608          	jrne	L343
1050                     ; 351 	         Battery_Charge_Status();
1052  024d cd00ca        	call	_Battery_Charge_Status
1054                     ; 352 	         need_cut_time=0;
1056  0250 725f0003      	clr	_need_cut_time
1059  0254 81            	ret	
1060  0255               L343:
1061                     ; 357 			 Battery_Charge_Status(); //5v usb charge happen		
1063  0255 cd00ca        	call	_Battery_Charge_Status
1065                     ; 358 		      if(	flag_charge_ing==0)
1067  0258 c60001        	ld	a,_flag_charge_ing
1068  025b 264e          	jrne	L143
1069                     ; 361 			if(battery_quantity==Electric_Need_Cut)
1071  025d c60006        	ld	a,_battery_quantity
1072  0260 4a            	dec	a
1073  0261 2648          	jrne	L143
1074                     ; 363                           if(Wireless_State==_Wireless_None_Connect)                            
1076  0263 c60000        	ld	a,_Wireless_State
1077  0266 2622          	jrne	L353
1078                     ; 365                           	 need_cut_time++;
1080  0268 725c0003      	inc	_need_cut_time
1081                     ; 366 			          if(need_cut_time>=5)
1083  026c c60003        	ld	a,_need_cut_time
1084  026f a105          	cp	a,#5
1085  0271 2538          	jrult	L143
1086                     ; 368 			                AMP_MUTE(ON);
1088  0273 4b80          	push	#128
1089  0275 ae5014        	ldw	x,#20500
1090  0278 cd0000        	call	_GPIO_WriteLow
1092  027b 84            	pop	a
1093                     ; 369                                    Power_off_ready(ON);
1096  027c 4b08          	push	#8
1097  027e ae500f        	ldw	x,#20495
1098  0281 cd0000        	call	_GPIO_WriteLow
1100  0284 725f0003      	clr	_need_cut_time
1101                     ; 370 				         need_cut_time=0;
1103  0288 2020          	jp	LC004
1104  028a               L353:
1105                     ; 375                           	       need_cut_time++;
1107  028a 725c0003      	inc	_need_cut_time
1108                     ; 376                           	      if(need_cut_time>=3)
1110  028e c60003        	ld	a,_need_cut_time
1111  0291 a103          	cp	a,#3
1112  0293 2516          	jrult	L143
1113                     ; 378                           	        need_cut_time=0;
1115  0295 725f0003      	clr	_need_cut_time
1116                     ; 379 			              AMP_MUTE(ON);
1118  0299 4b80          	push	#128
1119  029b ae5014        	ldw	x,#20500
1120  029e cd0000        	call	_GPIO_WriteLow
1122  02a1 84            	pop	a
1123                     ; 380                                   Power_off_ready(ON);
1126  02a2 4b08          	push	#8
1127  02a4 ae500f        	ldw	x,#20495
1128  02a7 cd0000        	call	_GPIO_WriteLow
1130  02aa               LC004:
1131  02aa 84            	pop	a
1132  02ab               L143:
1133                     ; 387 }
1136  02ab 81            	ret	
1308                     	xdef	_Battery_Charge_Status
1309                     	xdef	_Calculate_Voltage
1310                     	switch	.bss
1311  0001               _vol_cnt:
1312  0001 00            	ds.b	1
1313                     	xdef	_vol_cnt
1314  0002               _vol_buff:
1315  0002 000000000000  	ds.b	20
1316                     	xdef	_vol_buff
1317                     	xdef	_Voltage_Detect
1318                     	xdef	_need_cut_time2
1319                     	xdef	_need_cut_time
1320                     	xref	_Init_ADC1
1321                     	xref	_Init_ADC9
1322                     	xref	_charge_changeto_disconent_flag
1323                     	xref	_OFF_USB_CHARGE_FLG
1324                     	xref	_charge_time
1325                     	xref	_standby_charge_flag
1326                     	xref	_temper_value
1327                     	xref	_link_to_dislinktime
1328                     	xref	_standby_flag
1329                     	xdef	_flag_charge_ing
1330                     	xdef	_Link_State
1331                     	xref	_Wireless_State
1332                     	xref	_disp_timer
1333                     	xdef	_Get_Battery_temper_Status
1334                     	xdef	_Get_Battery_Status
1335                     	xdef	_Charge_Manager_Loop
1336                     	xdef	_Battery_Status_Detect
1337                     	xdef	_voltage
1338                     	xdef	_system_800ms_tick
1339                     	xdef	_battery_charge
1340                     	xdef	_battery_quantity
1341  0016               _adc_value:
1342  0016 0000          	ds.b	2
1343                     	xdef	_adc_value
1344                     	xref	_Wait_For_mSec
1345                     	xref	_GPIO_ReadInputPin
1346                     	xref	_GPIO_WriteLow
1347                     	xref	_GPIO_WriteHigh
1348                     	xref	_ADC1_ClearFlag
1349                     	xref	_ADC1_GetFlagStatus
1350                     	xref	_ADC1_GetConversionValue
1351                     	xref.b	c_x
1371                     	xref	c_imul
1372                     	end
