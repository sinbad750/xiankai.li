   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  18                     	switch	.data
  19  0000               _coco_count:
  20  0000 00            	dc.b	0
  50                     ; 40 @far @interrupt void NonHandledInterrupt(void)
  50                     ; 41 {
  51                     	switch	.text
  52  0000               f_NonHandledInterrupt:
  56                     ; 45 }
  59  0000 80            	iret	
  81                     ; 54 @far @interrupt void TRAP_IRQHandler(void)
  81                     ; 55 {
  82                     	switch	.text
  83  0001               f_TRAP_IRQHandler:
  87                     ; 59 }
  90  0001 80            	iret	
 112                     ; 85 @far @interrupt void TLI_IRQHandler(void)
 112                     ; 86 #else /* _RAISONANCE_ */
 112                     ; 87 void TLI_IRQHandler(void) interrupt 0
 112                     ; 88 #endif /* _COSMIC_ */
 112                     ; 89 {
 113                     	switch	.text
 114  0002               f_TLI_IRQHandler:
 118                     ; 93 }
 121  0002 80            	iret	
 143                     ; 103 @far @interrupt void AWU_IRQHandler(void)
 143                     ; 104 #else /* _RAISONANCE_ */
 143                     ; 105 void AWU_IRQHandler(void) interrupt 1
 143                     ; 106 #endif /* _COSMIC_ */	
 143                     ; 107 {
 144                     	switch	.text
 145  0003               f_AWU_IRQHandler:
 149                     ; 111 }
 152  0003 80            	iret	
 174                     ; 121 @far @interrupt void CLK_IRQHandler(void)
 174                     ; 122 #else /* _RAISONANCE_ */
 174                     ; 123 void CLK_IRQHandler(void) interrupt 2
 174                     ; 124 #endif /* _COSMIC_ */
 174                     ; 125 {
 175                     	switch	.text
 176  0004               f_CLK_IRQHandler:
 180                     ; 126 }
 183  0004 80            	iret	
 206                     ; 129 @far @interrupt void EXTI_PORTA_IRQHandler(void)
 206                     ; 130 #else /* _RAISONANCE_ */
 206                     ; 131 void EXTI_PORTA_IRQHandler(void) interrupt 3
 206                     ; 132 #endif /* _COSMIC_ */
 206                     ; 133 {
 207                     	switch	.text
 208  0005               f_EXTI_PORTA_IRQHandler:
 212                     ; 137 }
 215  0005 80            	iret	
 238                     ; 147 @far @interrupt void EXTI_PORTB_IRQHandler(void)
 238                     ; 148 #else /* _RAISONANCE_ */
 238                     ; 149 void EXTI_PORTB_IRQHandler(void) interrupt 4
 238                     ; 150 #endif /* _COSMIC_ */
 238                     ; 151 {
 239                     	switch	.text
 240  0006               f_EXTI_PORTB_IRQHandler:
 244                     ; 152 }
 247  0006 80            	iret	
 270                     ; 162 @far @interrupt void EXTI_PORTC_IRQHandler(void)
 270                     ; 163 #else /* _RAISONANCE_ */
 270                     ; 164 void EXTI_PORTC_IRQHandler(void) interrupt 5
 270                     ; 165 #endif /* _COSMIC_ */
 270                     ; 166 {
 271                     	switch	.text
 272  0007               f_EXTI_PORTC_IRQHandler:
 276                     ; 170 }
 279  0007 80            	iret	
 302                     ; 180 @far @interrupt void EXTI_PORTD_IRQHandler(void)
 302                     ; 181 #else /* _RAISONANCE_ */
 302                     ; 182 void EXTI_PORTD_IRQHandler(void) interrupt 6
 302                     ; 183 #endif /* _COSMIC_ */
 302                     ; 184 {
 303                     	switch	.text
 304  0008               f_EXTI_PORTD_IRQHandler:
 308                     ; 188 }
 311  0008 80            	iret	
 334                     ; 198 @far @interrupt void EXTI_PORTE_IRQHandler(void)
 334                     ; 199 #else /* _RAISONANCE_ */
 334                     ; 200 void EXTI_PORTE_IRQHandler(void) interrupt 7
 334                     ; 201 #endif /* _COSMIC_ */
 334                     ; 202 {
 335                     	switch	.text
 336  0009               f_EXTI_PORTE_IRQHandler:
 340                     ; 205  }
 343  0009 80            	iret	
 365                     ; 272 @far @interrupt void SPI_IRQHandler(void)
 365                     ; 273 #else /* _RAISONANCE_ */
 365                     ; 274 void SPI_IRQHandler(void) interrupt 10
 365                     ; 275 #endif /* _COSMIC_ */
 365                     ; 276 {
 366                     	switch	.text
 367  000a               f_SPI_IRQHandler:
 371                     ; 280 }
 374  000a 80            	iret	
 397                     ; 290 @far @interrupt void TIM1_UPD_OVF_TRG_BRK_IRQHandler(void)
 397                     ; 291 #else /* _RAISONANCE_ */
 397                     ; 292 void TIM1_UPD_OVF_TRG_BRK_IRQHandler(void) interrupt 11
 397                     ; 293 #endif /* _COSMIC_ */
 397                     ; 294 {
 398                     	switch	.text
 399  000b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 403                     ; 298 }
 406  000b 80            	iret	
 429                     ; 308 @far @interrupt void TIM1_CAP_COM_IRQHandler(void)
 429                     ; 309 #else /* _RAISONANCE_ */
 429                     ; 310 void TIM1_CAP_COM_IRQHandler(void) interrupt 12
 429                     ; 311 #endif /* _COSMIC_ */
 429                     ; 312 {
 430                     	switch	.text
 431  000c               f_TIM1_CAP_COM_IRQHandler:
 435                     ; 314 }
 438  000c 80            	iret	
 461                     ; 361 @far @interrupt void TIM2_UPD_OVF_BRK_IRQHandler(void)
 461                     ; 362 #else /* _RAISONANCE_ */
 461                     ; 363 void TIM2_UPD_OVF_BRK_IRQHandler(void) interrupt 13
 461                     ; 364 #endif /* _COSMIC_ */
 461                     ; 365 {
 462                     	switch	.text
 463  000d               f_TIM2_UPD_OVF_BRK_IRQHandler:
 467                     ; 369 }
 470  000d 80            	iret	
 493                     ; 379 @far @interrupt void TIM2_CAP_COM_IRQHandler(void)
 493                     ; 380 #else /* _RAISONANCE_ */
 493                     ; 381 void TIM2_CAP_COM_IRQHandler(void) interrupt 14
 493                     ; 382 #endif /* _COSMIC_ */
 493                     ; 383 {
 494                     	switch	.text
 495  000e               f_TIM2_CAP_COM_IRQHandler:
 499                     ; 387 }
 502  000e 80            	iret	
 525                     ; 399 @far @interrupt void TIM3_UPD_OVF_BRK_IRQHandler(void)
 525                     ; 400 #else /* _RAISONANCE_ */
 525                     ; 401 void TIM3_UPD_OVF_BRK_IRQHandler(void) interrupt 15
 525                     ; 402 #endif /* _COSMIC_ */
 525                     ; 403 {
 526                     	switch	.text
 527  000f               f_TIM3_UPD_OVF_BRK_IRQHandler:
 531                     ; 407 }
 534  000f 80            	iret	
 557                     ; 417 @far @interrupt void TIM3_CAP_COM_IRQHandler(void)
 557                     ; 418 #else /* _RAISONANCE_ */
 557                     ; 419 void TIM3_CAP_COM_IRQHandler(void) interrupt 16
 557                     ; 420 #endif /* _COSMIC_ */
 557                     ; 421 {
 558                     	switch	.text
 559  0010               f_TIM3_CAP_COM_IRQHandler:
 563                     ; 425 }
 566  0010 80            	iret	
 588                     ; 470 @far @interrupt void I2C_IRQHandler(void)
 588                     ; 471 #else /* _RAISONANCE_ */
 588                     ; 472 void I2C_IRQHandler(void) interrupt 19
 588                     ; 473 #endif /* _COSMIC_ */
 588                     ; 474 {
 589                     	switch	.text
 590  0011               f_I2C_IRQHandler:
 594                     ; 478 }
 597  0011 80            	iret	
 620                     ; 489 @far @interrupt void UART2_TX_IRQHandler(void)
 620                     ; 490 #else /* _RAISONANCE_ */
 620                     ; 491 void UART2_TX_IRQHandler(void) interrupt 20
 620                     ; 492 #endif /* _COSMIC_ */
 620                     ; 493 {
 621                     	switch	.text
 622  0012               f_UART2_TX_IRQHandler:
 626                     ; 498 }
 629  0012 80            	iret	
 675                     ; 508 @far @interrupt void UART2_RX_IRQHandler(void)
 675                     ; 509 #else /* _RAISONANCE_ */
 675                     ; 510 void UART2_RX_IRQHandler(void) interrupt 21
 675                     ; 511 #endif /* _COSMIC_ */
 675                     ; 512 {
 676                     	switch	.text
 677  0013               f_UART2_RX_IRQHandler:
 679       00000002      OFST:	set	2
 680  0013 3b0002        	push	c_x+2
 681  0016 be00          	ldw	x,c_x
 682  0018 89            	pushw	x
 683  0019 3b0002        	push	c_y+2
 684  001c be00          	ldw	x,c_y
 685  001e 89            	pushw	x
 686  001f 89            	pushw	x
 689                     ; 520 	UART2_ClearITPendingBit(UART2_FLAG_RXNE);
 691  0020 ae0020        	ldw	x,#32
 692  0023 cd0000        	call	_UART2_ClearITPendingBit
 694                     ; 522            data=(UART2_ReceiveData8()); 
 696  0026 cd0000        	call	_UART2_ReceiveData8
 698  0029 6b02          	ld	(OFST+0,sp),a
 699                     ; 523 	     SDATA=UART2->SR ;	 
 701  002b c65240        	ld	a,21056
 702                     ; 525 	if(up_state==UP_STATE_IDLE)
 704  002e c60000        	ld	a,_up_state
 705  0031 2631          	jrne	L752
 706                     ; 528 	      if(coco_count)
 708  0033 c60000        	ld	a,_coco_count
 709  0036 2706          	jreq	LC001
 710                     ; 529 		  	coco_count--;
 712  0038 725a0000      	dec	_coco_count
 713                     ; 531               if(coco_count==0)
 715  003c 2616          	jrne	L362
 716  003e               LC001:
 717                     ; 533 		if((data=='U')||(data=='p'))
 719  003e 7b02          	ld	a,(OFST+0,sp)
 720  0040 a155          	cp	a,#85
 721  0042 2704          	jreq	L762
 723  0044 a170          	cp	a,#112
 724  0046 2604          	jrne	L562
 725  0048               L762:
 726                     ; 535 			rx_count=0x00;
 728  0048 725f0000      	clr	_rx_count
 729  004c               L562:
 730                     ; 536 		     if(data=='p')
 732  004c a170          	cp	a,#112
 733  004e 2604          	jrne	L362
 734                     ; 537 		       coco_count=5;
 736  0050 35050000      	mov	_coco_count,#5
 737  0054               L362:
 738                     ; 540 		rx_buff[rx_count]=data;			
 740  0054 c60000        	ld	a,_rx_count
 741  0057 5f            	clrw	x
 742  0058 97            	ld	xl,a
 743  0059 7b02          	ld	a,(OFST+0,sp)
 744  005b d70000        	ld	(_rx_buff,x),a
 745                     ; 541 		rx_count++;
 747  005e 725c0000      	inc	_rx_count
 749  0062 2005          	jra	L372
 750  0064               L752:
 751                     ; 548 		Upgrade_RxData_Process(data);
 753  0064 7b02          	ld	a,(OFST+0,sp)
 754  0066 cd0000        	call	_Upgrade_RxData_Process
 756  0069               L372:
 757                     ; 550 }
 760  0069 5b02          	addw	sp,#2
 761  006b 85            	popw	x
 762  006c bf00          	ldw	c_y,x
 763  006e 320002        	pop	c_y+2
 764  0071 85            	popw	x
 765  0072 bf00          	ldw	c_x,x
 766  0074 320002        	pop	c_x+2
 767  0077 80            	iret	
 789                     ; 615 @far @interrupt void ADC1_IRQHandler(void)
 789                     ; 616 #else /* _RAISONANCE_ */
 789                     ; 617 void ADC1_IRQHandler(void) interrupt 22
 789                     ; 618 #endif /* _COSMIC_ */
 789                     ; 619 {
 790                     	switch	.text
 791  0078               f_ADC1_IRQHandler:
 795                     ; 623 }
 798  0078 80            	iret	
 833                     ; 649 @far @interrupt void TIM4_UPD_OVF_IRQHandler(void)
 833                     ; 650 #else /* _RAISONANCE_ */
 833                     ; 651 void TIM4_UPD_OVF_IRQHandler(void) interrupt 23
 833                     ; 652 #endif /* _COSMIC_ */
 833                     ; 653 {
 834                     	switch	.text
 835  0079               f_TIM4_UPD_OVF_IRQHandler:
 837  0079 3b0002        	push	c_x+2
 838  007c be00          	ldw	x,c_x
 839  007e 89            	pushw	x
 840  007f 3b0002        	push	c_y+2
 841  0082 be00          	ldw	x,c_y
 842  0084 89            	pushw	x
 845                     ; 654 	TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
 847  0085 a601          	ld	a,#1
 848  0087 cd0000        	call	_TIM4_ClearITPendingBit
 850                     ; 655 	pwm_value++;
 852  008a 725c0002      	inc	_pwm_value
 853                     ; 656 	if(pwm_value>19)
 855  008e c60002        	ld	a,_pwm_value
 856  0091 a114          	cp	a,#20
 857  0093 2504          	jrult	L513
 858                     ; 657 	        pwm_value=0x00;
 860  0095 4f            	clr	a
 861  0096 c70002        	ld	_pwm_value,a
 862  0099               L513:
 863                     ; 658 		      vLed_Light_Process(pwm_value);
 865  0099 cd0000        	call	_vLed_Light_Process
 867                     ; 660 	t10ms++;	
 869  009c 725c0003      	inc	_t10ms
 870                     ; 661 	system_20ms_tick++;
 872  00a0 725c0000      	inc	_system_20ms_tick
 873                     ; 662 	system_1Ms_Timer();
 875  00a4 cd0000        	call	_system_1Ms_Timer
 877                     ; 663 	if(t10ms>9)
 879  00a7 c60003        	ld	a,_t10ms
 880  00aa a10a          	cp	a,#10
 881  00ac 2512          	jrult	L713
 882                     ; 665 		t10ms=0x00;
 884  00ae 725f0003      	clr	_t10ms
 885                     ; 666 		system_800ms_tick++;
 887  00b2 725c0000      	inc	_system_800ms_tick
 888                     ; 667 		vLedTick_10Ms();
 890  00b6 cd0000        	call	_vLedTick_10Ms
 892                     ; 668 		t1second++;
 894  00b9 ce0000        	ldw	x,_t1second
 895  00bc 5c            	incw	x
 896  00bd cf0000        	ldw	_t1second,x
 897  00c0               L713:
 898                     ; 672 	if(t1second>99)
 900  00c0 ce0000        	ldw	x,_t1second
 901  00c3 a30064        	cpw	x,#100
 902  00c6 2515          	jrult	L123
 903                     ; 674 	                system_2s_tick++;
 905  00c8 725c0000      	inc	_system_2s_tick
 906                     ; 675 			t1second=0x00;
 908  00cc 5f            	clrw	x
 909  00cd cf0000        	ldw	_t1second,x
 910                     ; 676 			if(disp_timer)
 912  00d0 c60000        	ld	a,_disp_timer
 913  00d3 2704          	jreq	L323
 914                     ; 677 				disp_timer--;
 916  00d5 725a0000      	dec	_disp_timer
 917  00d9               L323:
 918                     ; 679 			system_1s_Timer_FLAG=1;
 920  00d9 35010000      	mov	_system_1s_Timer_FLAG,#1
 921  00dd               L123:
 922                     ; 681 }
 925  00dd 85            	popw	x
 926  00de bf00          	ldw	c_y,x
 927  00e0 320002        	pop	c_y+2
 928  00e3 85            	popw	x
 929  00e4 bf00          	ldw	c_x,x
 930  00e6 320002        	pop	c_x+2
 931  00e9 80            	iret	
 954                     ; 692 @far @interrupt void EEPROM_EEC_IRQHandler(void)
 954                     ; 693 #else /* _RAISONANCE_ */
 954                     ; 694 void EEPROM_EEC_IRQHandler(void) interrupt 24
 954                     ; 695 #endif /* _COSMIC_ */
 954                     ; 696 {
 955                     	switch	.text
 956  00ea               f_EEPROM_EEC_IRQHandler:
 960                     ; 700 }
 963  00ea 80            	iret	
1005                     	switch	.bss
1006  0000               _t1second:
1007  0000 0000          	ds.b	2
1008                     	xdef	_t1second
1009  0002               _pwm_value:
1010  0002 00            	ds.b	1
1011                     	xdef	_pwm_value
1012  0003               _t10ms:
1013  0003 00            	ds.b	1
1014                     	xdef	_t10ms
1015                     	xdef	_coco_count
1016                     	xref	_system_800ms_tick
1017                     	xref	_vLedTick_10Ms
1018                     	xref	_disp_timer
1019                     	xref	_system_1Ms_Timer
1020                     	xref	_vLed_Light_Process
1021                     	xref	_system_1s_Timer_FLAG
1022                     	xref	_system_2s_tick
1023                     	xref	_system_20ms_tick
1024                     	xref	_Upgrade_RxData_Process
1025                     	xref	_up_state
1026                     	xref	_rx_count
1027                     	xref	_rx_buff
1028                     	xdef	f_EEPROM_EEC_IRQHandler
1029                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1030                     	xdef	f_ADC1_IRQHandler
1031                     	xdef	f_UART2_TX_IRQHandler
1032                     	xdef	f_UART2_RX_IRQHandler
1033                     	xdef	f_I2C_IRQHandler
1034                     	xdef	f_TIM3_CAP_COM_IRQHandler
1035                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1036                     	xdef	f_TIM2_CAP_COM_IRQHandler
1037                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1038                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1039                     	xdef	f_TIM1_CAP_COM_IRQHandler
1040                     	xdef	f_SPI_IRQHandler
1041                     	xdef	f_EXTI_PORTE_IRQHandler
1042                     	xdef	f_EXTI_PORTD_IRQHandler
1043                     	xdef	f_EXTI_PORTC_IRQHandler
1044                     	xdef	f_EXTI_PORTB_IRQHandler
1045                     	xdef	f_EXTI_PORTA_IRQHandler
1046                     	xdef	f_CLK_IRQHandler
1047                     	xdef	f_AWU_IRQHandler
1048                     	xdef	f_TLI_IRQHandler
1049                     	xdef	f_TRAP_IRQHandler
1050                     	xdef	f_NonHandledInterrupt
1051                     	xref	_UART2_ClearITPendingBit
1052                     	xref	_UART2_ReceiveData8
1053                     	xref	_TIM4_ClearITPendingBit
1054                     	xref.b	c_x
1055                     	xref.b	c_y
1075                     	end
