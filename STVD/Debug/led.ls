   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  18                     	switch	.data
  19  0000               _r_pwm_value:
  20  0000 00            	dc.b	0
  21  0001               _y_pwm_value:
  22  0001 00            	dc.b	0
  23  0002               _w_pwm_value:
  24  0002 00            	dc.b	0
  25  0003               _b_pwm_value:
  26  0003 00            	dc.b	0
  27  0004               _s_pwm_value:
  28  0004 00            	dc.b	0
  29  0005               _disp_index:
  30  0005 00            	dc.b	0
  31  0006               _disp_timer:
  32  0006 00            	dc.b	0
  33  0007               L3_pwm_backup:
  34  0007 00            	dc.b	0
  35  0008               L5_w_time_backup:
  36  0008 00            	dc.b	0
  85                     ; 30 void vLed_Disp_DisConnect(void)
  85                     ; 31 {
  87                     	switch	.text
  88  0000               _vLed_Disp_DisConnect:
  92                     ; 35 		if(r_light_timer!=0) return;
  94  0000 ce0009        	ldw	x,_r_light_timer
  95  0003 2701          	jreq	L33
  99  0005 81            	ret	
 100  0006               L33:
 101                     ; 37 		w_pwm_value=LIGHTLY_0P4;
 103  0006 725f0002      	clr	_w_pwm_value
 104                     ; 39 		r_pwm_value=LIGHTLY_0P4;
 106  000a 725f0000      	clr	_r_pwm_value
 107                     ; 41 		if(pwm_backup==LIGHTLY_2P4)
 109  000e c60007        	ld	a,L3_pwm_backup
 110  0011 a10a          	cp	a,#10
 111  0013 2606          	jrne	L53
 112                     ; 42 		w_pwm_value=LIGHTLY_0P4;
 114  0015 725f0002      	clr	_w_pwm_value
 116  0019 2004          	jra	L73
 117  001b               L53:
 118                     ; 45 		w_pwm_value=LIGHTLY_2P4;
 120  001b 350a0002      	mov	_w_pwm_value,#10
 121  001f               L73:
 122                     ; 48 		pwm_backup=w_pwm_value;
 124  001f 5500020007    	mov	L3_pwm_backup,_w_pwm_value
 125                     ; 50 		r_light_timer=_200MS;
 127  0024 ae0032        	ldw	x,#50
 128  0027 cf0009        	ldw	_r_light_timer,x
 129                     ; 52 }
 132  002a 81            	ret	
 135                     	switch	.data
 136  0009               L14_r_time_backup:
 137  0009 00            	dc.b	0
 171                     ; 54 void vLed_Disp_Parring(void)
 171                     ; 55 {
 172                     	switch	.text
 173  002b               _vLed_Disp_Parring:
 177                     ; 57 	if(r_light_timer!=0) return;
 179  002b ce0009        	ldw	x,_r_light_timer
 180  002e 2701          	jreq	L75
 184  0030 81            	ret	
 185  0031               L75:
 186                     ; 58 	if(r_time_backup==LIGHTLY_2P4)
 188  0031 c60009        	ld	a,L14_r_time_backup
 189  0034 a10a          	cp	a,#10
 190  0036 260a          	jrne	L16
 191                     ; 60 		r_pwm_value=LIGHTLY_0P4;
 193  0038 725f0000      	clr	_r_pwm_value
 194                     ; 61 		r_time_backup=LIGHTLY_0P4;
 196  003c 725f0009      	clr	L14_r_time_backup
 198  0040 2008          	jra	L36
 199  0042               L16:
 200                     ; 65 		r_pwm_value=LIGHTLY_2P4;
 202  0042 350a0000      	mov	_r_pwm_value,#10
 203                     ; 66 		r_time_backup=LIGHTLY_2P4;
 205  0046 350a0009      	mov	L14_r_time_backup,#10
 206  004a               L36:
 207                     ; 68 	w_pwm_value=LIGHTLY_0P4;
 209  004a 725f0002      	clr	_w_pwm_value
 210                     ; 69 	y_pwm_value=LIGHTLY_0P4;
 212  004e 725f0001      	clr	_y_pwm_value
 213                     ; 70 	r_light_timer=_100MS;    
 215  0052 ae0014        	ldw	x,#20
 216  0055 cf0009        	ldw	_r_light_timer,x
 217                     ; 71 }
 220  0058 81            	ret	
 223                     	switch	.bss
 224  0000               L56_r_pwm_backup:
 225  0000 00            	ds.b	1
 259                     ; 72 void vLed_Disp_BatteryEmpty(void)
 259                     ; 73 {
 260                     	switch	.text
 261  0059               _vLed_Disp_BatteryEmpty:
 265                     ; 75 	if(r_light_timer!=0) return ;
 267  0059 ce0009        	ldw	x,_r_light_timer
 268  005c 2701          	jreq	L301
 272  005e 81            	ret	
 273  005f               L301:
 274                     ; 76 	w_pwm_value=LIGHTLY_0P4;
 276  005f 725f0002      	clr	_w_pwm_value
 277                     ; 77 	if(r_pwm_backup==LIGHTLY_2P4)
 279  0063 c60000        	ld	a,L56_r_pwm_backup
 280  0066 a10a          	cp	a,#10
 281  0068 2606          	jrne	L501
 282                     ; 78 		r_pwm_value=LIGHTLY_1P20;
 284  006a 35010000      	mov	_r_pwm_value,#1
 286  006e 2004          	jra	L701
 287  0070               L501:
 288                     ; 80 		r_pwm_value=LIGHTLY_2P4;
 290  0070 350a0000      	mov	_r_pwm_value,#10
 291  0074               L701:
 292                     ; 81 	r_light_timer=_300MS;
 294  0074 ae003c        	ldw	x,#60
 295  0077 cf0009        	ldw	_r_light_timer,x
 296                     ; 82 	r_pwm_backup=r_pwm_value;
 298  007a 5500000000    	mov	L56_r_pwm_backup,_r_pwm_value
 299                     ; 83 }
 302  007f 81            	ret	
 331                     ; 85 void vLed_Disp_Charge_Full(void)
 331                     ; 86 {
 332                     	switch	.text
 333  0080               _vLed_Disp_Charge_Full:
 337                     ; 87 	y_pwm_value=LIGHTLY_0P4;
 339  0080 725f0001      	clr	_y_pwm_value
 340                     ; 88 	r_pwm_value=LIGHTLY_0P4;
 342  0084 725f0000      	clr	_r_pwm_value
 343                     ; 89 	w_pwm_value=LIGHTLY_2P4;
 345  0088 350a0002      	mov	_w_pwm_value,#10
 346                     ; 90 	if(!disp_timer)
 348  008c c60006        	ld	a,_disp_timer
 349  008f 2604          	jrne	L121
 350                     ; 92 		disp_index=Disp_Separate;
 352  0091 35060005      	mov	_disp_index,#6
 353  0095               L121:
 354                     ; 93 }
 357  0095 81            	ret	
 385                     ; 95 void vLed_Disp_BatteryCharge(void)
 385                     ; 96 {
 386                     	switch	.text
 387  0096               _vLed_Disp_BatteryCharge:
 391                     ; 98 	r_pwm_value=LIGHTLY_4P4;
 393  0096 35140000      	mov	_r_pwm_value,#20
 394                     ; 99 	w_pwm_value=LIGHTLY_0P4;
 396  009a 725f0002      	clr	_w_pwm_value
 397                     ; 100 	if(battery_charge==_Charge_Full)   
 399  009e c60000        	ld	a,_battery_charge
 400  00a1 a102          	cp	a,#2
 401  00a3 2604          	jrne	L331
 402                     ; 105 		disp_index=Disp_Separate;
 404  00a5 35060005      	mov	_disp_index,#6
 405  00a9               L331:
 406                     ; 107 }
 409  00a9 81            	ret	
 437                     ; 110 void vLed_Disp_USB_BatteryCharge(void)
 437                     ; 111 {
 438                     	switch	.text
 439  00aa               _vLed_Disp_USB_BatteryCharge:
 443                     ; 113 	r_pwm_value=LIGHTLY_4P4;
 445  00aa 35140000      	mov	_r_pwm_value,#20
 446                     ; 114 	w_pwm_value=LIGHTLY_0P4;
 448  00ae 725f0002      	clr	_w_pwm_value
 449                     ; 115 	if(battery_charge==_Charge_Full)   
 451  00b2 c60000        	ld	a,_battery_charge
 452  00b5 a102          	cp	a,#2
 453  00b7 2604          	jrne	L541
 454                     ; 120 		disp_index=Disp_Separate;
 456  00b9 35060005      	mov	_disp_index,#6
 457  00bd               L541:
 458                     ; 122 }
 461  00bd 81            	ret	
 487                     ; 123 void vLed_Disp_BatteryLow(void)  //Red 50%->100% replace each other
 487                     ; 124 {
 488                     	switch	.text
 489  00be               _vLed_Disp_BatteryLow:
 493                     ; 125 	 r_pwm_value=LIGHTLY_2P4;
 495  00be 350a0000      	mov	_r_pwm_value,#10
 496                     ; 126 	w_pwm_value=LIGHTLY_0P4;
 498  00c2 725f0002      	clr	_w_pwm_value
 499                     ; 127 }
 502  00c6 81            	ret	
 530                     ; 128 void vLed_Disp_BatteryCharge_TimeOut(void)
 530                     ; 129 {
 531                     	switch	.text
 532  00c7               _vLed_Disp_BatteryCharge_TimeOut:
 536                     ; 142 	r_pwm_value=LIGHTLY_0P4;
 538  00c7 725f0000      	clr	_r_pwm_value
 539                     ; 143 	w_pwm_value=LIGHTLY_0P4;
 541  00cb 725f0002      	clr	_w_pwm_value
 542                     ; 145 	if(battery_charge==_Charge_Ing)    //Yellow On always
 544  00cf c60000        	ld	a,_battery_charge
 545  00d2 a101          	cp	a,#1
 546  00d4 2605          	jrne	L171
 547                     ; 146 		disp_index=Disp_Charging;
 549  00d6 35070005      	mov	_disp_index,#7
 552  00da 81            	ret	
 553  00db               L171:
 554                     ; 147 	else if(battery_charge==_Charge_Full)
 556  00db a102          	cp	a,#2
 557  00dd 2604          	jrne	L371
 558                     ; 149 		disp_index=Disp_Separate;
 560  00df 35060005      	mov	_disp_index,#6
 561  00e3               L371:
 562                     ; 150 }
 565  00e3 81            	ret	
 592                     ; 152 void vLed_Disp_Docked(void)
 592                     ; 153 {
 593                     	switch	.text
 594  00e4               _vLed_Disp_Docked:
 598                     ; 155 	r_pwm_value=LIGHTLY_0P4;
 600  00e4 725f0000      	clr	_r_pwm_value
 601                     ; 157       w_pwm_value=LIGHTLY_1P4;
 603  00e8 35050002      	mov	_w_pwm_value,#5
 604                     ; 159 	if(battery_charge==_Charge_Ing)
 606  00ec c60000        	ld	a,_battery_charge
 607  00ef 4a            	dec	a
 608  00f0 2605          	jrne	L702
 609                     ; 160 		disp_index=Disp_Charging;
 611  00f2 35070005      	mov	_disp_index,#7
 614  00f6 81            	ret	
 615  00f7               L702:
 616                     ; 161 	else if(battery_charge==_Charge_None)
 618  00f7 c60000        	ld	a,_battery_charge
 619  00fa 2604          	jrne	L112
 620                     ; 162 		disp_index=Disp_Separate;
 622  00fc 35060005      	mov	_disp_index,#6
 623  0100               L112:
 624                     ; 164 }
 627  0100 81            	ret	
 655                     ; 165 void vLed_Disp_Docking(void)   //  2Second White On--->OFF
 655                     ; 166 {
 656                     	switch	.text
 657  0101               _vLed_Disp_Docking:
 661                     ; 168 	r_pwm_value=LIGHTLY_0P4;
 663  0101 725f0000      	clr	_r_pwm_value
 664                     ; 169 	w_pwm_value=LIGHTLY_4P4;
 666  0105 35140002      	mov	_w_pwm_value,#20
 667                     ; 170 	if(!disp_timer)
 669  0109 c60006        	ld	a,_disp_timer
 670  010c 2604          	jrne	L522
 671                     ; 172 		if(battery_charge==_Charge_Full)
 673                     ; 176 		        disp_index=Disp_Docked; 
 675                     ; 180 		           disp_index=Disp_Docked;    //White from OFF to  ON
 678  010e 35040005      	mov	_disp_index,#4
 679  0112               L522:
 680                     ; 187 }
 683  0112 81            	ret	
 712                     ; 191 void vLed_Disp_UnDocking(void)
 712                     ; 192 {
 713                     	switch	.text
 714  0113               _vLed_Disp_UnDocking:
 718                     ; 193 	if(w_light_timer!=0) return ;
 720  0113 ce0005        	ldw	x,_w_light_timer
 721  0116 2701          	jreq	L342
 725  0118 81            	ret	
 726  0119               L342:
 727                     ; 194 	y_pwm_value=LIGHTLY_0P4;
 729  0119 725f0001      	clr	_y_pwm_value
 730                     ; 195 	r_pwm_value=LIGHTLY_0P4;
 732  011d 725f0000      	clr	_r_pwm_value
 733                     ; 196 	if(w_pwm_value<10)
 735  0121 c60002        	ld	a,_w_pwm_value
 736  0124 a10a          	cp	a,#10
 737  0126 2406          	jruge	L542
 738                     ; 197 		w_pwm_value++;
 740  0128 725c0002      	inc	_w_pwm_value
 742  012c 2004          	jra	L742
 743  012e               L542:
 744                     ; 199 		disp_index=Disp_Separate;    //White from OFF to  ON
 746  012e 35060005      	mov	_disp_index,#6
 747  0132               L742:
 748                     ; 200 	w_light_timer=_200MS;
 750  0132 ae0032        	ldw	x,#50
 751  0135 cf0005        	ldw	_w_light_timer,x
 752                     ; 201 }
 755  0138 81            	ret	
 784                     ; 202 void vLed_Disp_Docking_BatteryLow(void)   //  2Second White On--->OFF
 784                     ; 203 {
 785                     	switch	.text
 786  0139               _vLed_Disp_Docking_BatteryLow:
 790                     ; 204 	if(r_light_timer!=0) return ;
 792  0139 ce0009        	ldw	x,_r_light_timer
 793  013c 2701          	jreq	L162
 797  013e 81            	ret	
 798  013f               L162:
 799                     ; 205 	y_pwm_value=LIGHTLY_0P4;
 801  013f 725f0001      	clr	_y_pwm_value
 802                     ; 206 	w_pwm_value=LIGHTLY_0P4;
 804  0143 725f0002      	clr	_w_pwm_value
 805                     ; 207 	if(r_pwm_value)
 807  0147 c60000        	ld	a,_r_pwm_value
 808  014a 2706          	jreq	L362
 809                     ; 208 		r_pwm_value--;
 811  014c 725a0000      	dec	_r_pwm_value
 813  0150 2004          	jra	L562
 814  0152               L362:
 815                     ; 210 		disp_index=Disp_Charging;    //White from OFF to  ON
 817  0152 35070005      	mov	_disp_index,#7
 818  0156               L562:
 819                     ; 211 	r_light_timer=_100MS;
 821  0156 ae0014        	ldw	x,#20
 822  0159 cf0009        	ldw	_r_light_timer,x
 823                     ; 212 }
 826  015c 81            	ret	
 856                     ; 213 void vLed_Disp_UnDocking_BatteryLow(void)
 856                     ; 214 {
 857                     	switch	.text
 858  015d               _vLed_Disp_UnDocking_BatteryLow:
 862                     ; 215 	if(r_light_timer!=0) return ;
 864  015d ce0009        	ldw	x,_r_light_timer
 865  0160 2701          	jreq	L772
 869  0162 81            	ret	
 870  0163               L772:
 871                     ; 216 	y_pwm_value=LIGHTLY_0P4;
 873  0163 725f0001      	clr	_y_pwm_value
 874                     ; 217 	w_pwm_value=LIGHTLY_0P4;
 876  0167 725f0002      	clr	_w_pwm_value
 877                     ; 218 	if(r_pwm_value<10)
 879  016b c60000        	ld	a,_r_pwm_value
 880  016e a10a          	cp	a,#10
 881  0170 2406          	jruge	L103
 882                     ; 219 		r_pwm_value++;
 884  0172 725c0000      	inc	_r_pwm_value
 886  0176 2011          	jra	L303
 887  0178               L103:
 888                     ; 222 		if (battery_quantity==Electric_Low)
 890  0178 c60000        	ld	a,_battery_quantity
 891  017b a103          	cp	a,#3
 892  017d 2606          	jrne	L503
 893                     ; 223 			disp_index=Disp_Battery_Low;    //White from OFF to  ON
 895  017f 350a0005      	mov	_disp_index,#10
 897  0183 2004          	jra	L303
 898  0185               L503:
 899                     ; 225 			disp_index=Disp_Battery_Empty;    //White from OFF to  ON
 901  0185 350b0005      	mov	_disp_index,#11
 902  0189               L303:
 903                     ; 227 	r_light_timer=_200MS;
 905  0189 ae0032        	ldw	x,#50
 906  018c cf0009        	ldw	_r_light_timer,x
 907                     ; 228 }
 910  018f 81            	ret	
 935                     ; 229 void vLed_Disp_Separate(void)  //30 second
 935                     ; 230 {   
 936                     	switch	.text
 937  0190               _vLed_Disp_Separate:
 941                     ; 232 	r_pwm_value=LIGHTLY_0P4;
 943  0190 725f0000      	clr	_r_pwm_value
 944                     ; 234       w_pwm_value=LIGHTLY_1P4  ;
 946  0194 35050002      	mov	_w_pwm_value,#5
 947                     ; 235 }
 950  0198 81            	ret	
 979                     ; 237 void vLed_Disp_pre_Separate(void)
 979                     ; 238 {
 980                     	switch	.text
 981  0199               _vLed_Disp_pre_Separate:
 985                     ; 251 	r_pwm_value=LIGHTLY_0P4;
 987  0199 725f0000      	clr	_r_pwm_value
 988                     ; 252 	w_pwm_value=LIGHTLY_4P4;
 990  019d 35140002      	mov	_w_pwm_value,#20
 991                     ; 253 	if(!disp_timer)
 993  01a1 c60006        	ld	a,_disp_timer
 994  01a4 2604          	jrne	L133
 995                     ; 255 		if(battery_charge==_Charge_Full)
 997                     ; 259 		        disp_index=Disp_Docked; 
 999                     ; 263 		           disp_index=Disp_Docked;    //White from OFF to  ON
1002  01a6 35040005      	mov	_disp_index,#4
1003  01aa               L133:
1004                     ; 266 }
1007  01aa 81            	ret	
1010                     	switch	.data
1011  000a               L733_test_cnt:
1012  000a 00            	dc.b	0
1048                     ; 267 void Wireless_Display_Test_Mode(void)
1048                     ; 268 {
1049                     	switch	.text
1050  01ab               _Wireless_Display_Test_Mode:
1054                     ; 270   	if(r_light_timer!=0) 
1056  01ab ce0009        	ldw	x,_r_light_timer
1057  01ae 2701          	jreq	L553
1058                     ; 271 		return ;
1061  01b0 81            	ret	
1062  01b1               L553:
1063                     ; 272 	test_cnt++;
1065  01b1 725c000a      	inc	L733_test_cnt
1066                     ; 273 	y_pwm_value=LIGHTLY_2P4;
1068  01b5 350a0001      	mov	_y_pwm_value,#10
1069                     ; 274 	r_pwm_value=LIGHTLY_2P4;
1071  01b9 350a0000      	mov	_r_pwm_value,#10
1072                     ; 275 	w_pwm_value=LIGHTLY_2P4;
1074  01bd 350a0002      	mov	_w_pwm_value,#10
1075                     ; 276 	r_light_timer=_100MS;
1077  01c1 ae0014        	ldw	x,#20
1078  01c4 cf0009        	ldw	_r_light_timer,x
1079                     ; 277 	if(test_cnt>10)
1081  01c7 c6000a        	ld	a,L733_test_cnt
1082  01ca a10b          	cp	a,#11
1083  01cc 2503          	jrult	L753
1084                     ; 278 	    System_PowerOff();
1086  01ce cd0000        	call	_System_PowerOff
1088  01d1               L753:
1089                     ; 279 }
1092  01d1 81            	ret	
1129                     ; 281 void vLed_Light_Process(u8 pwm_value)
1129                     ; 282 {
1130                     	switch	.text
1131  01d2               _vLed_Light_Process:
1133  01d2 88            	push	a
1134       00000000      OFST:	set	0
1137                     ; 283        if(STB_FLAG)
1139  01d3 c60000        	ld	a,_STB_FLAG
1140  01d6 2702          	jreq	L573
1141                     ; 284 	return;
1144  01d8 84            	pop	a
1145  01d9 81            	ret	
1146  01da               L573:
1147                     ; 286 	if(r_pwm_value>pwm_value)
1149  01da c60000        	ld	a,_r_pwm_value
1150  01dd 1101          	cp	a,(OFST+1,sp)
1151  01df 230a          	jrule	L773
1152                     ; 287 		GPIO_WriteLow(GPIOA,GPIO_PIN_4);
1154  01e1 4b10          	push	#16
1155  01e3 ae5000        	ldw	x,#20480
1156  01e6 cd0000        	call	_GPIO_WriteLow
1159  01e9 2008          	jra	L104
1160  01eb               L773:
1161                     ; 289 		GPIO_WriteHigh(GPIOA,GPIO_PIN_4);
1163  01eb 4b10          	push	#16
1164  01ed ae5000        	ldw	x,#20480
1165  01f0 cd0000        	call	_GPIO_WriteHigh
1167  01f3               L104:
1168  01f3 84            	pop	a
1169                     ; 292 	if(w_pwm_value>pwm_value)
1171  01f4 c60002        	ld	a,_w_pwm_value
1172  01f7 1101          	cp	a,(OFST+1,sp)
1173  01f9 230a          	jrule	L304
1174                     ; 293 		GPIO_WriteLow(GPIOA,GPIO_PIN_5);
1176  01fb 4b20          	push	#32
1177  01fd ae5000        	ldw	x,#20480
1178  0200 cd0000        	call	_GPIO_WriteLow
1181  0203 2008          	jra	L504
1182  0205               L304:
1183                     ; 295 		GPIO_WriteHigh(GPIOA,GPIO_PIN_5);
1185  0205 4b20          	push	#32
1186  0207 ae5000        	ldw	x,#20480
1187  020a cd0000        	call	_GPIO_WriteHigh
1189  020d               L504:
1190  020d 84            	pop	a
1191                     ; 298 }
1194  020e 84            	pop	a
1195  020f 81            	ret	
1229                     ; 299 void vLed_Display_Upg(u8 flash_type)
1229                     ; 300 {
1230                     	switch	.text
1231  0210               _vLed_Display_Upg:
1233  0210 88            	push	a
1234       00000000      OFST:	set	0
1237                     ; 302 	w_pwm_value=LIGHTLY_0P4;
1239  0211 725f0002      	clr	_w_pwm_value
1240                     ; 303 	r_pwm_value=LIGHTLY_0P4;
1242  0215 725f0000      	clr	_r_pwm_value
1243                     ; 304 	if(flash_type%2==0)
1245  0219 a501          	bcp	a,#1
1246  021b 2606          	jrne	L324
1247                     ; 305 		r_pwm_value=LIGHTLY_2P4;
1249  021d 350a0000      	mov	_r_pwm_value,#10
1251  0221 200a          	jra	L524
1252  0223               L324:
1253                     ; 306 	else if(flash_type%2==1)
1255  0223 7b01          	ld	a,(OFST+1,sp)
1256  0225 a401          	and	a,#1
1257  0227 2704          	jreq	L524
1258                     ; 307 		w_pwm_value=LIGHTLY_2P4;
1260  0229 350a0002      	mov	_w_pwm_value,#10
1261  022d               L524:
1262                     ; 309 }
1265  022d 84            	pop	a
1266  022e 81            	ret	
1294                     ; 310 void vLedTick_10Ms(void)
1294                     ; 311 {
1295                     	switch	.text
1296  022f               _vLedTick_10Ms:
1300                     ; 312 	if(r_light_timer) 
1302  022f ce0009        	ldw	x,_r_light_timer
1303  0232 2704          	jreq	L144
1304                     ; 313 	r_light_timer--;
1306  0234 5a            	decw	x
1307  0235 cf0009        	ldw	_r_light_timer,x
1308  0238               L144:
1309                     ; 314 	if(y_light_timer) 
1311  0238 ce0007        	ldw	x,_y_light_timer
1312  023b 2704          	jreq	L344
1313                     ; 315 	y_light_timer--;
1315  023d 5a            	decw	x
1316  023e cf0007        	ldw	_y_light_timer,x
1317  0241               L344:
1318                     ; 316 	if(w_light_timer) 
1320  0241 ce0005        	ldw	x,_w_light_timer
1321  0244 2704          	jreq	L544
1322                     ; 317 	w_light_timer--;
1324  0246 5a            	decw	x
1325  0247 cf0005        	ldw	_w_light_timer,x
1326  024a               L544:
1327                     ; 319 	if(b_light_timer) 
1329  024a ce0003        	ldw	x,_b_light_timer
1330  024d 2704          	jreq	L744
1331                     ; 320 	b_light_timer--;
1333  024f 5a            	decw	x
1334  0250 cf0003        	ldw	_b_light_timer,x
1335  0253               L744:
1336                     ; 321 	if(s_light_timer) 
1338  0253 ce0001        	ldw	x,_s_light_timer
1339  0256 2704          	jreq	L154
1340                     ; 322 	s_light_timer--;
1342  0258 5a            	decw	x
1343  0259 cf0001        	ldw	_s_light_timer,x
1344  025c               L154:
1345                     ; 323 }
1348  025c 81            	ret	
1374                     ; 328 void vLed_Disp_Sod_Stereo(void)
1374                     ; 329 {
1375                     	switch	.text
1376  025d               _vLed_Disp_Sod_Stereo:
1380                     ; 330     s_pwm_value=LIGHTLY_4P4;
1382  025d 35140004      	mov	_s_pwm_value,#20
1383                     ; 331     b_pwm_value=LIGHTLY_4P4;
1385  0261 35140003      	mov	_b_pwm_value,#20
1386                     ; 332 }
1389  0265 81            	ret	
1414                     ; 335 void vLed_Disp_Standby(void)
1414                     ; 336 {
1415                     	switch	.text
1416  0266               _vLed_Disp_Standby:
1420                     ; 337     w_pwm_value=LIGHTLY_0P4;
1422  0266 725f0002      	clr	_w_pwm_value
1423                     ; 338     r_pwm_value=LIGHTLY_0P4;
1425  026a 725f0000      	clr	_r_pwm_value
1426                     ; 339 }
1429  026e 81            	ret	
1471                     .const:	section	.text
1472  0000               L431:
1473  0000 028a          	dc.w	L574
1474  0002 028d          	dc.w	L774
1475  0004 02a2          	dc.w	L515
1476  0006 0290          	dc.w	L105
1477  0008 0293          	dc.w	L305
1478  000a 0296          	dc.w	L505
1479  000c 0299          	dc.w	L705
1480  000e 029f          	dc.w	L315
1481  0010 02a2          	dc.w	L515
1482  0012 029c          	dc.w	L115
1483  0014 02a5          	dc.w	L715
1484  0016 02a8          	dc.w	L125
1485  0018 02ab          	dc.w	L325
1486  001a 02ae          	dc.w	L525
1487  001c 02b9          	dc.w	L755
1488  001e 02b9          	dc.w	L755
1489  0020 02b1          	dc.w	L725
1490  0022 02b7          	dc.w	L335
1491  0024 02b4          	dc.w	L135
1492                     ; 342 void Led_Display_Loop(void)
1492                     ; 343 {
1493                     	switch	.text
1494  026f               _Led_Display_Loop:
1498                     ; 350    if(led_test_time)
1500  026f c60000        	ld	a,_led_test_time
1501  0272 2701          	jreq	L155
1502                     ; 351    	return;
1505  0274 81            	ret	
1506  0275               L155:
1507                     ; 352    if(led_test_time1)
1509  0275 c60000        	ld	a,_led_test_time1
1510  0278 2701          	jreq	L355
1511                     ; 353    	return;
1514  027a 81            	ret	
1515  027b               L355:
1516                     ; 354 	switch(disp_index)
1518  027b c60005        	ld	a,_disp_index
1520                     ; 424 	default:
1520                     ; 425 	break;
1521  027e 4a            	dec	a
1522  027f a113          	cp	a,#19
1523  0281 2436          	jruge	L755
1524  0283 5f            	clrw	x
1525  0284 97            	ld	xl,a
1526  0285 58            	sllw	x
1527  0286 de0000        	ldw	x,(L431,x)
1528  0289 fc            	jp	(x)
1529                     ; 358 	case Disp_None:
1529                     ; 359 	break;
1531  028a               L574:
1532                     ; 361 	case Disp_Dis_Connect:
1532                     ; 362 		vLed_Disp_DisConnect();
1535                     ; 363 	break;
1538  028a cc0000        	jp	_vLed_Disp_DisConnect
1539  028d               L774:
1540                     ; 365 	case Disp_Connecting:
1540                     ; 366 		vLed_Disp_Parring();
1543                     ; 367 	break;
1546  028d cc002b        	jp	_vLed_Disp_Parring
1547  0290               L105:
1548                     ; 368 	case Disp_Docked:
1548                     ; 369 		vLed_Disp_Docked();
1551                     ; 370 	break;
1554  0290 cc00e4        	jp	_vLed_Disp_Docked
1555  0293               L305:
1556                     ; 371 	case Disp_UnDocking:
1556                     ; 372 		vLed_Disp_UnDocking();
1559                     ; 373 	break;
1562  0293 cc0113        	jp	_vLed_Disp_UnDocking
1563  0296               L505:
1564                     ; 374 	case Disp_Separate:
1564                     ; 375 	       vLed_Disp_Separate();
1567                     ; 376 	break;
1570  0296 cc0190        	jp	_vLed_Disp_Separate
1571  0299               L705:
1572                     ; 378 	case Disp_Charging:
1572                     ; 379 		vLed_Disp_BatteryCharge();
1575                     ; 380 	break;
1578  0299 cc0096        	jp	_vLed_Disp_BatteryCharge
1579  029c               L115:
1580                     ; 382 	case Disp_Battery_Low:
1580                     ; 383 		vLed_Disp_BatteryLow();
1583                     ; 384 	break;
1586  029c cc00be        	jp	_vLed_Disp_BatteryLow
1587  029f               L315:
1588                     ; 386 	case Disp_Battery_Low_UnDocking:
1588                     ; 387 		vLed_Disp_UnDocking_BatteryLow();
1591                     ; 388 	break;
1594  029f cc015d        	jp	_vLed_Disp_UnDocking_BatteryLow
1595  02a2               L515:
1596                     ; 390 	case Disp_Battery_Low_Docking:
1596                     ; 391 	case Disp_Docking:
1596                     ; 392 		vLed_Disp_Docking();
1599                     ; 394 	break;
1602  02a2 cc0101        	jp	_vLed_Disp_Docking
1603  02a5               L715:
1604                     ; 395 	case Disp_Battery_Empty:
1604                     ; 396 		vLed_Disp_BatteryEmpty();
1607                     ; 397 	break;
1610  02a5 cc0059        	jp	_vLed_Disp_BatteryEmpty
1611  02a8               L125:
1612                     ; 398 	case Disp_Battery_Err:
1612                     ; 399 	        vLed_Disp_BatteryCharge_TimeOut();
1615                     ; 400 	break;
1618  02a8 cc00c7        	jp	_vLed_Disp_BatteryCharge_TimeOut
1619  02ab               L325:
1620                     ; 402 	case Disp_Charge_Full:
1620                     ; 403 		vLed_Disp_Charge_Full();
1623                     ; 404 	break;
1626  02ab cc0080        	jp	_vLed_Disp_Charge_Full
1627  02ae               L525:
1628                     ; 406 	case Disp_Test_MODE:
1628                     ; 407 	   Wireless_Display_Test_Mode();
1631                     ; 408 	break;
1634  02ae cc01ab        	jp	_Wireless_Display_Test_Mode
1635  02b1               L725:
1636                     ; 410 	case Disp_USB_charge:
1636                     ; 411 	      vLed_Disp_USB_BatteryCharge();
1639                     ; 412 	break;
1642  02b1 cc00aa        	jp	_vLed_Disp_USB_BatteryCharge
1643  02b4               L135:
1644                     ; 414    	case Disp_pre_Separate:
1644                     ; 415 	      vLed_Disp_pre_Separate();
1647                     ; 416 	break;
1650  02b4 cc0199        	jp	_vLed_Disp_pre_Separate
1651  02b7               L335:
1652                     ; 417 	case Disp_standby:
1652                     ; 418 
1652                     ; 419 	       vLed_Disp_Standby();  
1654  02b7 adad          	call	_vLed_Disp_Standby
1656                     ; 420 	break;
1658                     ; 422 	case Disp_Upg:
1658                     ; 423 	break;
1660                     ; 424 	default:
1660                     ; 425 	break;
1662  02b9               L755:
1663                     ; 433 }
1666  02b9 81            	ret	
1923                     	xdef	_vLed_Disp_Sod_Stereo
1924                     	xdef	_Wireless_Display_Test_Mode
1925                     	xdef	_vLed_Disp_Separate
1926                     	xdef	_vLed_Disp_UnDocking_BatteryLow
1927                     	xdef	_vLed_Disp_Docking_BatteryLow
1928                     	xdef	_vLed_Disp_UnDocking
1929                     	xdef	_vLed_Disp_Docking
1930                     	xdef	_vLed_Disp_Docked
1931                     	xdef	_vLed_Disp_Charge_Full
1932                     	switch	.bss
1933  0001               _s_light_timer:
1934  0001 0000          	ds.b	2
1935                     	xdef	_s_light_timer
1936  0003               _b_light_timer:
1937  0003 0000          	ds.b	2
1938                     	xdef	_b_light_timer
1939  0005               _w_light_timer:
1940  0005 0000          	ds.b	2
1941                     	xdef	_w_light_timer
1942  0007               _y_light_timer:
1943  0007 0000          	ds.b	2
1944                     	xdef	_y_light_timer
1945  0009               _r_light_timer:
1946  0009 0000          	ds.b	2
1947                     	xdef	_r_light_timer
1948                     	xref	_STB_FLAG
1949                     	xref	_System_PowerOff
1950                     	xref	_battery_charge
1951                     	xref	_battery_quantity
1952                     	xref	_led_test_time1
1953                     	xref	_led_test_time
1954                     	xdef	_s_pwm_value
1955                     	xdef	_b_pwm_value
1956                     	xdef	_w_pwm_value
1957                     	xdef	_y_pwm_value
1958                     	xdef	_r_pwm_value
1959                     	xdef	_vLed_Disp_pre_Separate
1960                     	xdef	_vLed_Disp_Standby
1961                     	xdef	_vLed_Disp_USB_BatteryCharge
1962                     	xdef	_Led_Display_Loop
1963                     	xdef	_vLed_Display_Upg
1964                     	xdef	_vLed_Disp_BatteryCharge_TimeOut
1965                     	xdef	_vLed_Disp_BatteryCharge
1966                     	xdef	_vLed_Disp_BatteryLow
1967                     	xdef	_vLed_Disp_Parring
1968                     	xdef	_vLed_Disp_DisConnect
1969                     	xdef	_vLedTick_10Ms
1970                     	xdef	_vLed_Light_Process
1971                     	xdef	_vLed_Disp_BatteryEmpty
1972                     	xdef	_disp_timer
1973                     	xdef	_disp_index
1974                     	xref	_GPIO_WriteLow
1975                     	xref	_GPIO_WriteHigh
1995                     	end
