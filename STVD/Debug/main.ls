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
 110  0000               _test_flash_ID:
 111  0000 0000          	dc.w	0
 112  0002               _power_on_time:
 113  0002 00            	dc.b	0
 114  0003               _system_20ms_tick:
 115  0003 00            	dc.b	0
 116  0004               _rest_wireless_time:
 117  0004 00            	dc.b	0
 118  0005               _LR_Flag:
 119  0005 00            	dc.b	0
 120  0006               _standby_flag:
 121  0006 00            	dc.b	0
 122  0007               _RX_disconnect_time:
 123  0007 00            	dc.b	0
 124  0008               _Pre_Wireless_State:
 125  0008 00            	dc.b	0
 126  0009               _timer_20s:
 127  0009 00            	dc.b	0
 128  000a               _wireless_int_pin_ERROR:
 129  000a 0000          	dc.w	0
 130  000c               _pairing_flag:
 131  000c 00            	dc.b	0
 132  000d               _system_1s_Timer_FLAG:
 133  000d 00            	dc.b	0
 134  000e               _led_test_time:
 135  000e 00            	dc.b	0
 136  000f               _led_test_time1:
 137  000f 00            	dc.b	0
 138  0010               _connect_to_disconnecttime:
 139  0010 00            	dc.b	0
 140  0011               _link_to_dislinktime:
 141  0011 00            	dc.b	0
 142  0012               _temper_check_time:
 143  0012 01            	dc.b	1
 144  0013               _temper_value:
 145  0013 0000          	dc.w	0
 146  0015               _standby_time:
 147  0015 00            	dc.b	0
 148  0016               _poweroff_time:
 149  0016 0000          	dc.w	0
 150  0018               _standby_charge_flag:
 151  0018 00            	dc.b	0
 152  0019               _charge_report_time:
 153  0019 0000          	dc.w	0
 154  001b               _full_charge_time:
 155  001b 00            	dc.b	0
 156  001c               _full_charge_flag:
 157  001c 00            	dc.b	0
 158  001d               _temper_protect_time:
 159  001d 00            	dc.b	0
 160  001e               _new_old_board:
 161  001e 00            	dc.b	0
 162  001f               _powe_on_mute_flag:
 163  001f 00            	dc.b	0
 164  0020               _OFF_USB_CHARGE_FLG:
 165  0020 00            	dc.b	0
 166  0021               _charge_changeto_disconent_flag:
 167  0021 00            	dc.b	0
 168  0022               _standby_flag_SOD:
 169  0022 00            	dc.b	0
 170                     	switch	.bss
 171  0000               L72_HSEStatus:
 172  0000 00            	ds.b	1
 262                     ; 64 ErrorStatus  WaitForHSEStartUp(void)
 262                     ; 65 {
 264                     	switch	.text
 265  0000               _WaitForHSEStartUp:
 267  0000 89            	pushw	x
 268       00000002      OFST:	set	2
 271                     ; 67 	u16 StartUpCounter =HSEStartUp_TimeOut;
 273  0001 ae1000        	ldw	x,#4096
 274  0004 1f01          	ldw	(OFST-1,sp),x
 275  0006               L77:
 276                     ; 71 		HSEStatus = CLK_GetFlagStatus(CLK_FLAG_HSERDY);
 278  0006 ae0202        	ldw	x,#514
 279  0009 cd0000        	call	_CLK_GetFlagStatus
 281  000c c70000        	ld	L72_HSEStatus,a
 282                     ; 72 		StartUpCounter++;  
 284  000f 1e01          	ldw	x,(OFST-1,sp)
 285  0011 5c            	incw	x
 286  0012 1f01          	ldw	(OFST-1,sp),x
 287                     ; 74 	while((HSEStatus == RESET) && (StartUpCounter != HSEStartUp_TimeOut));
 289  0014 725d0000      	tnz	L72_HSEStatus
 290  0018 2605          	jrne	L501
 292  001a a31000        	cpw	x,#4096
 293  001d 26e7          	jrne	L77
 294  001f               L501:
 295                     ; 75 	if(CLK_GetFlagStatus(CLK_FLAG_HSERDY) != RESET)
 297  001f ae0202        	ldw	x,#514
 298  0022 cd0000        	call	_CLK_GetFlagStatus
 300  0025 4d            	tnz	a
 301  0026 2702          	jreq	L701
 302                     ; 76 	return SUCCESS;
 304  0028 a601          	ld	a,#1
 306  002a               L701:
 307                     ; 77 	return ERROR;
 311  002a 85            	popw	x
 312  002b 81            	ret	
 343                     ; 79 void CLOCK_Init(void)	
 343                     ; 80 	
 343                     ; 81 {
 344                     	switch	.text
 345  002c               _CLOCK_Init:
 349                     ; 82         CLK_DeInit();  //lxk add
 351  002c cd0000        	call	_CLK_DeInit
 353                     ; 87 	CLK_HSECmd(ENABLE);
 355  002f a601          	ld	a,#1
 356  0031 cd0000        	call	_CLK_HSECmd
 358                     ; 88 	if(WaitForHSEStartUp()==SUCCESS)//use  HSE as  master CLK
 360  0034 adca          	call	_WaitForHSEStartUp
 362  0036 4a            	dec	a
 363  0037 2619          	jrne	L121
 364                     ; 90 		CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO,CLK_SOURCE_HSE ,DISABLE,  CLK_CURRENTCLOCKSTATE_DISABLE);
 366  0039 4b00          	push	#0
 367  003b 4b00          	push	#0
 368  003d ae00b4        	ldw	x,#180
 369  0040 4c            	inc	a
 370  0041 95            	ld	xh,a
 371  0042 cd0000        	call	_CLK_ClockSwitchConfig
 373  0045 85            	popw	x
 375  0046               L521:
 376                     ; 91 		while(CLK_GetSYSCLKSource()!=CLK_SOURCE_HSE);
 378  0046 cd0000        	call	_CLK_GetSYSCLKSource
 380  0049 a1b4          	cp	a,#180
 381  004b 26f9          	jrne	L521
 382                     ; 92 			CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 384  004d a680          	ld	a,#128
 385  004f cd0000        	call	_CLK_SYSCLKConfig
 387  0052               L121:
 388                     ; 95 	 CLK_CCOConfig(CLK_OUTPUT_CPU);
 390  0052 a608          	ld	a,#8
 391  0054 cd0000        	call	_CLK_CCOConfig
 393                     ; 96         CLK_CCOCmd(ENABLE);//
 395  0057 a601          	ld	a,#1
 397                     ; 98 }
 400  0059 cc0000        	jp	_CLK_CCOCmd
 425                     ; 99 void Init_ADC9(void)
 425                     ; 100 {
 426                     	switch	.text
 427  005c               _Init_ADC9:
 431                     ; 102 	ADC1_Init(ADC1_CONVERSIONMODE_SINGLE,ADC1_CHANNEL_9,
 431                     ; 103 	ADC1_PRESSEL_FCPU_D18,
 431                     ; 104 	ADC1_EXTTRIG_TIM,DISABLE,ADC1_ALIGN_RIGHT,ADC1_SCHMITTTRIG_CHANNEL9,DISABLE);
 433  005c 4b00          	push	#0
 434  005e 4b09          	push	#9
 435  0060 4b08          	push	#8
 436  0062 4b00          	push	#0
 437  0064 4b00          	push	#0
 438  0066 4b70          	push	#112
 439  0068 ae0009        	ldw	x,#9
 440  006b 4f            	clr	a
 441  006c 95            	ld	xh,a
 442  006d cd0000        	call	_ADC1_Init
 444  0070 5b06          	addw	sp,#6
 445                     ; 105 	ADC1_StartConversion();
 448                     ; 107 }
 451  0072 cc0000        	jp	_ADC1_StartConversion
 476                     ; 109 void Init_ADC1(void)
 476                     ; 110 {
 477                     	switch	.text
 478  0075               _Init_ADC1:
 482                     ; 111 	ADC1_Init(ADC1_CONVERSIONMODE_SINGLE,ADC1_CHANNEL_1,
 482                     ; 112 	ADC1_PRESSEL_FCPU_D18,
 482                     ; 113 	ADC1_EXTTRIG_TIM,DISABLE,ADC1_ALIGN_RIGHT,ADC1_SCHMITTTRIG_CHANNEL1,DISABLE);
 484  0075 4b00          	push	#0
 485  0077 4b01          	push	#1
 486  0079 4b08          	push	#8
 487  007b 4b00          	push	#0
 488  007d 4b00          	push	#0
 489  007f 4b70          	push	#112
 490  0081 ae0001        	ldw	x,#1
 491  0084 4f            	clr	a
 492  0085 95            	ld	xh,a
 493  0086 cd0000        	call	_ADC1_Init
 495  0089 5b06          	addw	sp,#6
 496                     ; 114 	ADC1_StartConversion();
 499                     ; 116 }
 502  008b cc0000        	jp	_ADC1_StartConversion
 529                     ; 118 void  TIM4_Config_1MS(void)    /*for 1ms systick timer*/
 529                     ; 119  {
 530                     	switch	.text
 531  008e               _TIM4_Config_1MS:
 535                     ; 120        TIM4_DeInit(); // lxk add 	 
 537  008e cd0000        	call	_TIM4_DeInit
 539                     ; 121 	TIM4_TimeBaseInit(TIM4_PRESCALER_128,0x60 );   //0xBA
 541  0091 ae0060        	ldw	x,#96
 542  0094 a607          	ld	a,#7
 543  0096 95            	ld	xh,a
 544  0097 cd0000        	call	_TIM4_TimeBaseInit
 546                     ; 122 	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
 548  009a ae0001        	ldw	x,#1
 549  009d a601          	ld	a,#1
 550  009f 95            	ld	xh,a
 551  00a0 cd0000        	call	_TIM4_ITConfig
 553                     ; 123 	TIM4_Cmd(ENABLE); 
 555  00a3 a601          	ld	a,#1
 557                     ; 125 }
 560  00a5 cc0000        	jp	_TIM4_Cmd
 584                     ; 126 void Init_Config_IO(void)
 584                     ; 127 {
 585                     	switch	.text
 586  00a8               _Init_Config_IO:
 590                     ; 132 	GPIO_Init(GPIOA, GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT); //
 592  00a8 4b00          	push	#0
 593  00aa 4b02          	push	#2
 594  00ac ae5000        	ldw	x,#20480
 595  00af cd0000        	call	_GPIO_Init
 597  00b2 85            	popw	x
 598                     ; 134 	GPIO_Init(GPIOA, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_SLOW);
 600  00b3 4bc0          	push	#192
 601  00b5 4b04          	push	#4
 602  00b7 ae5000        	ldw	x,#20480
 603  00ba cd0000        	call	_GPIO_Init
 605  00bd 85            	popw	x
 606                     ; 136        GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);   //HW_OFF
 608  00be 4b00          	push	#0
 609  00c0 4b04          	push	#4
 610  00c2 ae5005        	ldw	x,#20485
 611  00c5 cd0000        	call	_GPIO_Init
 613  00c8 85            	popw	x
 614                     ; 138 	GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_OUT_PP_HIGH_FAST);  // TX_RX
 616  00c9 4bf0          	push	#240
 617  00cb 4b10          	push	#16
 618  00cd ae500f        	ldw	x,#20495
 619  00d0 cd0000        	call	_GPIO_Init
 621  00d3 85            	popw	x
 622                     ; 140 	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_PP_HIGH_FAST);  //  AMP MUTE
 624  00d4 4bf0          	push	#240
 625  00d6 4b10          	push	#16
 626  00d8 ae5005        	ldw	x,#20485
 627  00db cd0000        	call	_GPIO_Init
 629  00de 85            	popw	x
 630                     ; 142 	GPIO_Init(GPIOB, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);  //sod key
 632  00df 4b40          	push	#64
 633  00e1 4b40          	push	#64
 634  00e3 ae5005        	ldw	x,#20485
 635  00e6 cd0000        	call	_GPIO_Init
 637  00e9 85            	popw	x
 638                     ; 157        GPIO_Init(GPIOB, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_FAST); //AK7755 PDN (REST) 
 640  00ea 4bf0          	push	#240
 641  00ec 4b08          	push	#8
 642  00ee ae5005        	ldw	x,#20485
 643  00f1 cd0000        	call	_GPIO_Init
 645  00f4 85            	popw	x
 646                     ; 158        GPIO_Init(GPIOC, GPIO_PIN_5, GPIO_MODE_OUT_OD_HIZ_FAST);//DSP CLK
 648  00f5 4bb0          	push	#176
 649  00f7 4b20          	push	#32
 650  00f9 ae500a        	ldw	x,#20490
 651  00fc cd0000        	call	_GPIO_Init
 653  00ff 85            	popw	x
 654                     ; 159 	GPIO_Init(GPIOC, GPIO_PIN_6, GPIO_MODE_OUT_OD_HIZ_FAST);//DSP MOSI
 656  0100 4bb0          	push	#176
 657  0102 4b40          	push	#64
 658  0104 ae500a        	ldw	x,#20490
 659  0107 cd0000        	call	_GPIO_Init
 661  010a 85            	popw	x
 662                     ; 160 	GPIO_Init(GPIOC, GPIO_PIN_7, GPIO_MODE_IN_FL_NO_IT);//DSP MISO
 664  010b 4b00          	push	#0
 665  010d 4b80          	push	#128
 666  010f ae500a        	ldw	x,#20490
 667  0112 cd0000        	call	_GPIO_Init
 669  0115 85            	popw	x
 670                     ; 161 	GPIO_Init(GPIOG, GPIO_PIN_0, GPIO_MODE_OUT_PP_HIGH_FAST);//DSP CS
 672  0116 4bf0          	push	#240
 673  0118 4b01          	push	#1
 674  011a ae501e        	ldw	x,#20510
 675  011d cd0000        	call	_GPIO_Init
 677  0120 85            	popw	x
 678                     ; 165 	GPIO_Init(GPIOA, GPIO_PIN_4, GPIO_MODE_OUT_PP_HIGH_FAST); // SOD LED
 680  0121 4bf0          	push	#240
 681  0123 4b10          	push	#16
 682  0125 ae5000        	ldw	x,#20480
 683  0128 cd0000        	call	_GPIO_Init
 685  012b 85            	popw	x
 686                     ; 167 	GPIO_Init(GPIOA, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST); //SOD LED
 688  012c 4bf0          	push	#240
 689  012e 4b20          	push	#32
 690  0130 ae5000        	ldw	x,#20480
 691  0133 cd0000        	call	_GPIO_Init
 693  0136 85            	popw	x
 694                     ; 169 	GPIO_Init(Clock_Coco_Port, Clock_Coco_Pin, GPIO_MODE_OUT_PP_LOW_FAST);//CCO  
 696  0137 4be0          	push	#224
 697  0139 4b01          	push	#1
 698  013b ae5014        	ldw	x,#20500
 699  013e cd0000        	call	_GPIO_Init
 701  0141 85            	popw	x
 702                     ; 170 	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_FAST); //standby
 704  0142 4bf0          	push	#240
 705  0144 4b08          	push	#8
 706  0146 ae500a        	ldw	x,#20490
 707  0149 cd0000        	call	_GPIO_Init
 709  014c 85            	popw	x
 710                     ; 172 	GPIO_Init(GPIOE, GPIO_PIN_2, GPIO_MODE_OUT_PP_HIGH_FAST); //WIRELESS REST
 712  014d 4bf0          	push	#240
 713  014f 4b04          	push	#4
 714  0151 ae5014        	ldw	x,#20500
 715  0154 cd0000        	call	_GPIO_Init
 717  0157 85            	popw	x
 718                     ; 173 	GPIO_Init(GPIOE, GPIO_PIN_1, GPIO_MODE_OUT_OD_HIZ_FAST);   // WIRELESS I2C
 720  0158 4bb0          	push	#176
 721  015a 4b02          	push	#2
 722  015c ae5014        	ldw	x,#20500
 723  015f cd0000        	call	_GPIO_Init
 725  0162 85            	popw	x
 726                     ; 175 	GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_OD_HIZ_FAST);   // WIRELESS I2C
 728  0163 4bb0          	push	#176
 729  0165 4b01          	push	#1
 730  0167 ae500f        	ldw	x,#20495
 731  016a cd0000        	call	_GPIO_Init
 733  016d 85            	popw	x
 734                     ; 179 	GPIO_Init(GPIOE, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);  //Wireless Request INT/
 736  016e 4b40          	push	#64
 737  0170 4b08          	push	#8
 738  0172 ae5014        	ldw	x,#20500
 739  0175 cd0000        	call	_GPIO_Init
 741  0178 85            	popw	x
 742                     ; 183 	GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_OUT_PP_HIGH_FAST); //AMP SDZ
 744  0179 4bf0          	push	#240
 745  017b 4b01          	push	#1
 746  017d ae5005        	ldw	x,#20485
 747  0180 cd0000        	call	_GPIO_Init
 749  0183 85            	popw	x
 750                     ; 184 	GPIO_Init(GPIOE, GPIO_PIN_7, GPIO_MODE_OUT_PP_HIGH_FAST); //AMP MUTE
 752  0184 4bf0          	push	#240
 753  0186 4b80          	push	#128
 754  0188 ae5014        	ldw	x,#20500
 755  018b cd0000        	call	_GPIO_Init
 757  018e 85            	popw	x
 758                     ; 188 	GPIO_Init(GPIOE, GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);// ADC
 760  018f 4b00          	push	#0
 761  0191 4b40          	push	#64
 762  0193 ae5014        	ldw	x,#20500
 763  0196 cd0000        	call	_GPIO_Init
 765  0199 85            	popw	x
 766                     ; 189 	GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT);// ADC
 768  019a 4b00          	push	#0
 769  019c 4b02          	push	#2
 770  019e ae5005        	ldw	x,#20485
 771  01a1 cd0000        	call	_GPIO_Init
 773  01a4 85            	popw	x
 774                     ; 192 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);// charge detect
 776  01a5 4b00          	push	#0
 777  01a7 4b08          	push	#8
 778  01a9 ae5000        	ldw	x,#20480
 779  01ac cd0000        	call	_GPIO_Init
 781  01af 85            	popw	x
 782                     ; 194 	GPIO_Init(GPIOC, GPIO_PIN_1, GPIO_MODE_OUT_PP_HIGH_SLOW);  // MCU PWER ON/OFF
 784  01b0 4bd0          	push	#208
 785  01b2 4b02          	push	#2
 786  01b4 ae500a        	ldw	x,#20490
 787  01b7 cd0000        	call	_GPIO_Init
 789  01ba 85            	popw	x
 790                     ; 196 	GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_PU_NO_IT);  //  power_on_off   BYpass THE power key  ACTIVE HIGH
 792  01bb 4b40          	push	#64
 793  01bd 4b04          	push	#4
 794  01bf ae500f        	ldw	x,#20495
 795  01c2 cd0000        	call	_GPIO_Init
 797  01c5 85            	popw	x
 798                     ; 198 	GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_IN_PU_NO_IT);  //  KEY DETECT   ACTIVE LOW
 800  01c6 4b40          	push	#64
 801  01c8 4b04          	push	#4
 802  01ca ae500a        	ldw	x,#20490
 803  01cd cd0000        	call	_GPIO_Init
 805  01d0 85            	popw	x
 806                     ; 200 	GPIO_Init(GPIOA, GPIO_PIN_6, GPIO_MODE_OUT_PP_HIGH_FAST); //charge en
 808  01d1 4bf0          	push	#240
 809  01d3 4b40          	push	#64
 810  01d5 ae5000        	ldw	x,#20480
 811  01d8 cd0000        	call	_GPIO_Init
 813  01db 85            	popw	x
 814                     ; 202        GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_FAST); //power off ready
 816  01dc 4bf0          	push	#240
 817  01de 4b08          	push	#8
 818  01e0 ae500f        	ldw	x,#20495
 819  01e3 cd0000        	call	_GPIO_Init
 821  01e6 85            	popw	x
 822                     ; 210 	GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_HIGH_FAST); //power off ready
 824  01e7 4bf0          	push	#240
 825  01e9 4b10          	push	#16
 826  01eb ae500a        	ldw	x,#20490
 827  01ee cd0000        	call	_GPIO_Init
 829  01f1 85            	popw	x
 830                     ; 213        GPIO_Init(GPIOE, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);  //SPI FLASH CS
 832  01f2 4bf0          	push	#240
 833  01f4 4b20          	push	#32
 834  01f6 ae5014        	ldw	x,#20500
 835  01f9 cd0000        	call	_GPIO_Init
 837  01fc 85            	popw	x
 838                     ; 219 	GPIO_Init(GPIOD, GPIO_PIN_7, GPIO_MODE_OUT_PP_HIGH_FAST);   //batt on    16v on 
 840  01fd 4bf0          	push	#240
 841  01ff 4b80          	push	#128
 842  0201 ae500f        	ldw	x,#20495
 843  0204 cd0000        	call	_GPIO_Init
 845  0207 85            	popw	x
 846                     ; 223 	GPIO_Init(GPIOG, GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT);  //sod key
 848  0208 4b00          	push	#0
 849  020a 4b02          	push	#2
 850  020c ae501e        	ldw	x,#20510
 851  020f cd0000        	call	_GPIO_Init
 853  0212 85            	popw	x
 854                     ; 226 	GPIO_Init(GPIOB, GPIO_PIN_7, GPIO_MODE_IN_FL_NO_IT);   //batt on    16v on 
 856  0213 4b00          	push	#0
 857  0215 4b80          	push	#128
 858  0217 ae5005        	ldw	x,#20485
 859  021a cd0000        	call	_GPIO_Init
 861  021d 85            	popw	x
 862                     ; 228 }
 865  021e 81            	ret	
 905                     ; 238 void System_Init(void)
 905                     ; 239 {
 906                     	switch	.text
 907  021f               _System_Init:
 909  021f 88            	push	a
 910       00000001      OFST:	set	1
 913                     ; 240 	Battery_Status_Detect();
 915  0220 cd0000        	call	_Battery_Status_Detect
 917                     ; 241 	if(Link_State==Link_None)
 919  0223 c60000        	ld	a,_Link_State
 920  0226 4a            	dec	a
 921  0227 2625          	jrne	L502
 922                     ; 244 		battery_quantity=Electric_Full;
 924  0229 35050000      	mov	_battery_quantity,#5
 925                     ; 245 		Get_Battery_temper_Status();
 927  022d cd0000        	call	_Get_Battery_temper_Status
 929                     ; 246 		for(i=0;i<30;i++)
 931  0230 0f01          	clr	(OFST+0,sp)
 932  0232               L702:
 933                     ; 248 			Get_Battery_Status();
 935  0232 cd0000        	call	_Get_Battery_Status
 937                     ; 249 			Wait_For_mSec(20);
 939  0235 ae0014        	ldw	x,#20
 940  0238 cd0000        	call	_Wait_For_mSec
 942                     ; 246 		for(i=0;i<30;i++)
 944  023b 0c01          	inc	(OFST+0,sp)
 947  023d 7b01          	ld	a,(OFST+0,sp)
 948  023f a11e          	cp	a,#30
 949  0241 25ef          	jrult	L702
 950                     ; 252 		if(battery_quantity<=Electric_Empty)
 952  0243 c60000        	ld	a,_battery_quantity
 953  0246 a103          	cp	a,#3
 954  0248 2404          	jruge	L502
 955                     ; 253 		    disp_index=Disp_Battery_Empty;
 957  024a 350b0000      	mov	_disp_index,#11
 958  024e               L502:
 959                     ; 256 	system_20ms_tick=0;
 961  024e 725f0003      	clr	_system_20ms_tick
 962                     ; 257 }
 965  0252 84            	pop	a
 966  0253 81            	ret	
1007                     ; 279  void MCU_init(void)
1007                     ; 280  { 
1008                     	switch	.text
1009  0254               _MCU_init:
1013                     ; 282 	CLOCK_Init();
1015  0254 cd002c        	call	_CLOCK_Init
1017                     ; 283 	Init_Config_IO();
1019  0257 cd00a8        	call	_Init_Config_IO
1021                     ; 284        Batt_16v_SW(OFF);
1023  025a 4b80          	push	#128
1024  025c ae500f        	ldw	x,#20495
1025  025f cd0000        	call	_GPIO_WriteLow
1027  0262 84            	pop	a
1028                     ; 287 	AMP_MUTE(ON);
1030  0263 4b80          	push	#128
1031  0265 ae5014        	ldw	x,#20500
1032  0268 cd0000        	call	_GPIO_WriteLow
1034  026b 84            	pop	a
1035                     ; 288 	Wireless_rest(LOW);
1038  026c 4b04          	push	#4
1039  026e ae5014        	ldw	x,#20500
1040  0271 cd0000        	call	_GPIO_WriteLow
1042  0274 ae0064        	ldw	x,#100
1043  0277 84            	pop	a
1044                     ; 290 	Wait_For_mSec(100);
1047  0278 cd0000        	call	_Wait_For_mSec
1049                     ; 292        Power_off_ready(OFF);
1051  027b 4b08          	push	#8
1052  027d ae500f        	ldw	x,#20495
1053  0280 cd0000        	call	_GPIO_WriteHigh
1055  0283 84            	pop	a
1056                     ; 296 	Wireless_rest(HIGH);
1058  0284 4b04          	push	#4
1059  0286 ae5014        	ldw	x,#20500
1060  0289 cd0000        	call	_GPIO_WriteHigh
1062  028c 84            	pop	a
1063                     ; 298 	System_Standby(ON);
1066  028d 4b08          	push	#8
1067  028f ae500a        	ldw	x,#20490
1068  0292 cd0000        	call	_GPIO_WriteHigh
1070  0295 84            	pop	a
1071                     ; 300 	AMP_SDZ(ON);
1074  0296 4b01          	push	#1
1075  0298 ae5005        	ldw	x,#20485
1076  029b cd0000        	call	_GPIO_WriteHigh
1078  029e 84            	pop	a
1079                     ; 302 	  new_old_board=new_Board_Pin_Status() ;
1081  029f 4b02          	push	#2
1082  02a1 ae501e        	ldw	x,#20510
1083  02a4 cd0000        	call	_GPIO_ReadInputPin
1085  02a7 5b01          	addw	sp,#1
1086  02a9 c7001e        	ld	_new_old_board,a
1087                     ; 303 	if(new_old_board)
1089  02ac 270a          	jreq	L722
1090                     ; 305 	MCU_POWER_SW(OFF);
1092  02ae 4b02          	push	#2
1093  02b0 ae500a        	ldw	x,#20490
1094  02b3 cd0000        	call	_GPIO_WriteLow
1097  02b6 2008          	jra	L132
1098  02b8               L722:
1099                     ; 309 	MCU_POWER_SW(ON);
1101  02b8 4b02          	push	#2
1102  02ba ae500a        	ldw	x,#20490
1103  02bd cd0000        	call	_GPIO_WriteHigh
1105  02c0               L132:
1106  02c0 84            	pop	a
1107                     ; 313           SPI_DSP_Init();
1109  02c1 cd0000        	call	_SPI_DSP_Init
1111                     ; 317 	 RED_LED(OFF);
1113  02c4 4b10          	push	#16
1114  02c6 ae5000        	ldw	x,#20480
1115  02c9 cd0000        	call	_GPIO_WriteHigh
1117  02cc 84            	pop	a
1118                     ; 318 	 WHITE_LED(OFF);
1120  02cd 4b20          	push	#32
1121  02cf ae5000        	ldw	x,#20480
1122  02d2 cd0000        	call	_GPIO_WriteHigh
1124  02d5 ae001e        	ldw	x,#30
1125  02d8 84            	pop	a
1126                     ; 320         Wait_For_mSec(30);
1128  02d9 cd0000        	call	_Wait_For_mSec
1130                     ; 322 	 UART2_DeInit();
1132  02dc cd0000        	call	_UART2_DeInit
1134                     ; 324         initUart(UART2_MODE_RX_ENABLE);
1136  02df a608          	ld	a,#8
1137  02e1 cd0000        	call	_initUart
1139                     ; 328 	Init_ADC9();
1141  02e4 cd005c        	call	_Init_ADC9
1143                     ; 330 	TIM4_Config_1MS();   //  1Millisecond
1145  02e7 cd008e        	call	_TIM4_Config_1MS
1147                     ; 332 	enableInterrupts(); 
1150  02ea 9a            	rim	
1152                     ; 334 	Battery_Charge(ENABLE);
1155  02eb 4b04          	push	#4
1156  02ed ae5000        	ldw	x,#20480
1157  02f0 cd0000        	call	_GPIO_WriteHigh
1159  02f3 84            	pop	a
1160                     ; 337        vAPP_Akm7719_Dsp_Init();
1162  02f4 cd0000        	call	_vAPP_Akm7719_Dsp_Init
1164                     ; 340 	System_Init();  
1166  02f7 cd021f        	call	_System_Init
1168                     ; 342        CHARGE_EN(ON);
1170  02fa 4b40          	push	#64
1171  02fc ae5000        	ldw	x,#20480
1172  02ff cd0000        	call	_GPIO_WriteLow
1174  0302 ae0064        	ldw	x,#100
1175  0305 84            	pop	a
1176                     ; 343 	Wait_For_mSec(100);
1178  0306 cd0000        	call	_Wait_For_mSec
1180                     ; 345 	if(battery_quantity!=Electric_Need_Cut)
1182  0309 c60000        	ld	a,_battery_quantity
1183  030c 4a            	dec	a
1184  030d 270b          	jreq	L332
1185                     ; 347 	       Batt_16v_SW(ON);
1187  030f 4b80          	push	#128
1188  0311 ae500f        	ldw	x,#20495
1189  0314 cd0000        	call	_GPIO_WriteHigh
1191  0317 84            	pop	a
1193  0318 2004          	jra	L532
1194  031a               L332:
1195                     ; 351 	 	powe_on_mute_flag=1; 
1197  031a 3501001f      	mov	_powe_on_mute_flag,#1
1198  031e               L532:
1199                     ; 359        AMP_MUTE(OFF);
1201  031e 4b80          	push	#128
1202  0320 ae5014        	ldw	x,#20500
1203  0323 cd0000        	call	_GPIO_WriteHigh
1205  0326 84            	pop	a
1206                     ; 366   if((Battery_Charge_Pin_Status()==0)&&(Main_Link_Status()==0))
1209  0327 4b08          	push	#8
1210  0329 ae5000        	ldw	x,#20480
1211  032c cd0000        	call	_GPIO_ReadInputPin
1213  032f 5b01          	addw	sp,#1
1214  0331 4d            	tnz	a
1215  0332 2611          	jrne	L732
1217  0334 4b20          	push	#32
1218  0336 ae5005        	ldw	x,#20485
1219  0339 cd0000        	call	_GPIO_ReadInputPin
1221  033c 5b01          	addw	sp,#1
1222  033e 4d            	tnz	a
1223  033f 2604          	jrne	L732
1224                     ; 368         OFF_USB_CHARGE_FLG=1;
1226  0341 35010020      	mov	_OFF_USB_CHARGE_FLG,#1
1227  0345               L732:
1228                     ; 370 }
1231  0345 81            	ret	
1264                     ; 374   void System_Main_Loop(void)
1264                     ; 375 {
1265                     	switch	.text
1266  0346               _System_Main_Loop:
1270                     ; 376 	if(system_20ms_tick>40)
1272  0346 c60003        	ld	a,_system_20ms_tick
1273  0349 a129          	cp	a,#41
1274  034b 2520          	jrult	L152
1275                     ; 379 		system_20ms_tick=0x00;
1277  034d 725f0003      	clr	_system_20ms_tick
1278                     ; 380 		Wireless_RxInfoProcess();
1280  0351 cd0000        	call	_Wireless_RxInfoProcess
1282                     ; 381 		Wireless_State_Process();
1284  0354 cd0000        	call	_Wireless_State_Process
1286                     ; 384               Key_Service();
1288  0357 cd0000        	call	_Key_Service
1290                     ; 386 		if(wireless_int_pin_ERROR>=1800)
1292  035a ce000a        	ldw	x,_wireless_int_pin_ERROR
1293  035d a30708        	cpw	x,#1800
1294  0360 250b          	jrult	L152
1295                     ; 388 		  Wireless_Reset();
1297  0362 cd0000        	call	_Wireless_Reset
1299                     ; 389 		  disp_timer=4;
1301  0365 35040000      	mov	_disp_timer,#4
1302                     ; 390 		  wireless_int_pin_ERROR=0;
1304  0369 5f            	clrw	x
1305  036a cf000a        	ldw	_wireless_int_pin_ERROR,x
1306  036d               L152:
1307                     ; 396        Charge_Manager_Loop();
1309  036d cd0000        	call	_Charge_Manager_Loop
1311                     ; 397 	Led_Display_Loop();
1313  0370 cd0000        	call	_Led_Display_Loop
1315                     ; 398 	system_1s_Timer();
1318                     ; 399 }
1321  0373 204d          	jp	_system_1s_Timer
1350                     ; 406 void system_1Ms_Timer(void)
1350                     ; 407 {
1351                     	switch	.text
1352  0375               _system_1Ms_Timer:
1356                     ; 409 	key_count++;
1358  0375 725c0001      	inc	_key_count
1359                     ; 410 	if(key_count>=20)
1361  0379 c60001        	ld	a,_key_count
1362  037c a114          	cp	a,#20
1363  037e 250e          	jrult	L562
1364                     ; 412 		key_count=0;
1366  0380 725f0001      	clr	_key_count
1367                     ; 413 	    if(power_on_time>2)
1369  0384 c60002        	ld	a,_power_on_time
1370  0387 a103          	cp	a,#3
1371  0389 2503          	jrult	L562
1372                     ; 414 		Key_Scan();
1374  038b cd0000        	call	_Key_Scan
1376  038e               L562:
1377                     ; 417      if(!WIRELESS_INT_PIN_STATUS)	
1379  038e 4b08          	push	#8
1380  0390 ae5014        	ldw	x,#20500
1381  0393 cd0000        	call	_GPIO_ReadInputPin
1383  0396 5b01          	addw	sp,#1
1384  0398 4d            	tnz	a
1385  0399 2606          	jrne	L172
1386                     ; 420         wireless_int_pin_ERROR++;
1388  039b ce000a        	ldw	x,_wireless_int_pin_ERROR
1389  039e 5c            	incw	x
1391  039f 2001          	jra	L372
1392  03a1               L172:
1393                     ; 425         wireless_int_pin_ERROR=0;
1395  03a1 5f            	clrw	x
1396  03a2               L372:
1397  03a2 cf000a        	ldw	_wireless_int_pin_ERROR,x
1398                     ; 430       if(!Battery_Charge_Pin_Status())
1400  03a5 4b08          	push	#8
1401  03a7 ae5000        	ldw	x,#20480
1402  03aa cd0000        	call	_GPIO_ReadInputPin
1404  03ad 5b01          	addw	sp,#1
1405  03af 4d            	tnz	a
1406  03b0 260b          	jrne	L572
1407                     ; 432           if(charge_time<300)
1409  03b2 ce0002        	ldw	x,_charge_time
1410  03b5 a3012c        	cpw	x,#300
1411  03b8 2407          	jruge	L103
1412                     ; 433 		charge_time++;
1414  03ba 5c            	incw	x
1415  03bb 2001          	jp	LC001
1416  03bd               L572:
1417                     ; 438               charge_time=0;
1419  03bd 5f            	clrw	x
1420  03be               LC001:
1421  03be cf0002        	ldw	_charge_time,x
1422  03c1               L103:
1423                     ; 454 }
1426  03c1 81            	ret	
1482                     ; 456 void system_1s_Timer(void)
1482                     ; 457 {
1483                     	switch	.text
1484  03c2               _system_1s_Timer:
1488                     ; 459 if(!system_1s_Timer_FLAG)
1490  03c2 c6000d        	ld	a,_system_1s_Timer_FLAG
1491  03c5 2601          	jrne	L313
1492                     ; 460 	return;
1495  03c7 81            	ret	
1496  03c8               L313:
1497                     ; 462 if(power_on_time<100)
1499  03c8 c60002        	ld	a,_power_on_time
1500  03cb a164          	cp	a,#100
1501  03cd 2404          	jruge	L513
1502                     ; 464   power_on_time++;
1504  03cf 725c0002      	inc	_power_on_time
1505  03d3               L513:
1506                     ; 467 if(shor_key_time)
1508  03d3 c60000        	ld	a,_shor_key_time
1509  03d6 270a          	jreq	L713
1510                     ; 469 	shor_key_time--;
1512  03d8 725a0000      	dec	_shor_key_time
1513                     ; 470 	if(!shor_key_time)
1515  03dc 2604          	jrne	L713
1516                     ; 471 		shor_key=0;
1518  03de 725f0000      	clr	_shor_key
1519  03e2               L713:
1520                     ; 475    if(STB_FLAG)
1522  03e2 c60000        	ld	a,_STB_FLAG
1523  03e5 2707          	jreq	L323
1524                     ; 477    	    System_PowerOff();
1526  03e7 cd0000        	call	_System_PowerOff
1528                     ; 478 	    Power_onoff_board(OFF);	
1530  03ea 4f            	clr	a
1531  03eb cd0000        	call	_Power_onoff_board
1533  03ee               L323:
1534                     ; 482       if(pairing_flag)
1536  03ee c6000c        	ld	a,_pairing_flag
1537  03f1 2704          	jreq	L523
1538                     ; 483 		 pairing_flag--;
1540  03f3 725a000c      	dec	_pairing_flag
1541  03f7               L523:
1542                     ; 486           if(Wireless_State==_Wireless_ConnectTx)
1544  03f7 c60000        	ld	a,_Wireless_State
1545  03fa a101          	cp	a,#1
1546  03fc 2603          	jrne	L723
1547                     ; 487                Pre_Wireless_State=Wireless_State;
1549  03fe c70008        	ld	_Pre_Wireless_State,a
1550  0401               L723:
1551                     ; 489            if( (Wireless_State==_Wireless_None_Connect)&&(Pre_Wireless_State==_Wireless_ConnectTx))
1553  0401 c60000        	ld	a,_Wireless_State
1554  0404 261c          	jrne	L133
1556  0406 c60008        	ld	a,_Pre_Wireless_State
1557  0409 4a            	dec	a
1558  040a 2616          	jrne	L133
1559                     ; 492                   RX_disconnect_time++;
1561  040c 725c0007      	inc	_RX_disconnect_time
1562                     ; 494 		  if(RX_disconnect_time>15)	
1564  0410 c60007        	ld	a,_RX_disconnect_time
1565  0413 a110          	cp	a,#16
1566  0415 250f          	jrult	L533
1567                     ; 496 		  	 RX_disconnect_time=0;
1569  0417 725f0007      	clr	_RX_disconnect_time
1570                     ; 497 			 Pre_Wireless_State=Wireless_State;
1572  041b 5500000008    	mov	_Pre_Wireless_State,_Wireless_State
1573  0420 2004          	jra	L533
1574  0422               L133:
1575                     ; 503 	   	RX_disconnect_time=0;
1577  0422 725f0007      	clr	_RX_disconnect_time
1578  0426               L533:
1579                     ; 536     if ( led_test_time)
1581  0426 c6000e        	ld	a,_led_test_time
1582  0429 270a          	jreq	L733
1583                     ; 538            led_test_time--;
1585  042b 725a000e      	dec	_led_test_time
1586                     ; 539            vLed_Display_Upg(led_test_time);	   
1588  042f c6000e        	ld	a,_led_test_time
1589  0432 cd0000        	call	_vLed_Display_Upg
1591  0435               L733:
1592                     ; 541     if ( led_test_time1)
1594  0435 c6000f        	ld	a,_led_test_time1
1595  0438 2704          	jreq	L143
1596                     ; 543            led_test_time1--;
1598  043a 725a000f      	dec	_led_test_time1
1599  043e               L143:
1600                     ; 545            timer_20s++;
1602  043e 725c0009      	inc	_timer_20s
1603                     ; 546            if(timer_20s>=20)
1605  0442 c60009        	ld	a,_timer_20s
1606  0445 a114          	cp	a,#20
1607  0447 2514          	jrult	L343
1608                     ; 548                  timer_20s=0;
1610  0449 725f0009      	clr	_timer_20s
1611                     ; 549 		 if(WIRELESS_INT_PIN_STATUS)		 
1613  044d 4b08          	push	#8
1614  044f ae5014        	ldw	x,#20500
1615  0452 cd0000        	call	_GPIO_ReadInputPin
1617  0455 5b01          	addw	sp,#1
1618  0457 4d            	tnz	a
1619  0458 2703          	jreq	L343
1620                     ; 550 		  clear_rx_buffuer();	
1622  045a cd0000        	call	_clear_rx_buffuer
1624  045d               L343:
1625                     ; 554      if((temper_value<670)&&(temper_value>0))
1627  045d ce0013        	ldw	x,_temper_value
1628  0460 a3029e        	cpw	x,#670
1629  0463 2426          	jruge	L743
1631  0465 ce0013        	ldw	x,_temper_value
1632  0468 2721          	jreq	L743
1633                     ; 556      	temper_protect_time++;
1635  046a 725c001d      	inc	_temper_protect_time
1636                     ; 557 	if( temper_protect_time==6 )
1638  046e c6001d        	ld	a,_temper_protect_time
1639  0471 a106          	cp	a,#6
1640  0473 2616          	jrne	L743
1641                     ; 559              AMP_MUTE(ON);
1643  0475 4b80          	push	#128
1644  0477 ae5014        	ldw	x,#20500
1645  047a cd0000        	call	_GPIO_WriteLow
1647  047d 84            	pop	a
1648                     ; 560              Power_off_ready(ON);
1651  047e 4b08          	push	#8
1652  0480 ae500f        	ldw	x,#20495
1653  0483 cd0000        	call	_GPIO_WriteLow
1655  0486 725f001d      	clr	_temper_protect_time
1656  048a 84            	pop	a
1657                     ; 561 			 temper_protect_time=0;
1659  048b               L743:
1660                     ; 574       if(((Wireless_State==_Wireless_None_Connect)||(Wireless_State==_Wireless_standby))&&(standby_flag==0))
1662  048b c60000        	ld	a,_Wireless_State
1663  048e 2704          	jreq	L553
1665  0490 a103          	cp	a,#3
1666  0492 263d          	jrne	L353
1667  0494               L553:
1669  0494 c60006        	ld	a,_standby_flag
1670  0497 2638          	jrne	L353
1671                     ; 576       	  standby_time++;
1673  0499 725c0015      	inc	_standby_time
1674                     ; 614 	  	  if(standby_time>=7)
1676  049d c60015        	ld	a,_standby_time
1677  04a0 a107          	cp	a,#7
1678  04a2 252d          	jrult	L353
1679                     ; 617 	  	   standby_time=0;
1681  04a4 725f0015      	clr	_standby_time
1682                     ; 618                 standby_flag=1;
1684  04a8 35010006      	mov	_standby_flag,#1
1685                     ; 619 		   AMP_MUTE(ON);	
1687  04ac 4b80          	push	#128
1688  04ae ae5014        	ldw	x,#20500
1689  04b1 cd0000        	call	_GPIO_WriteLow
1691  04b4 84            	pop	a
1692                     ; 621 		   Batt_16v_SW(OFF);
1695  04b5 4b80          	push	#128
1696  04b7 ae500f        	ldw	x,#20495
1697  04ba cd0000        	call	_GPIO_WriteLow
1699  04bd 84            	pop	a
1700                     ; 624 		   System_Standby(OFF);
1702  04be 4b08          	push	#8
1703  04c0 ae500a        	ldw	x,#20490
1704  04c3 cd0000        	call	_GPIO_WriteLow
1706  04c6 725d0022      	tnz	_standby_flag_SOD
1707  04ca 84            	pop	a
1708                     ; 626                        if(standby_flag_SOD)
1711  04cb 2704          	jreq	L353
1712                     ; 627 			 charge_changeto_disconent_flag=0;
1714  04cd 725f0021      	clr	_charge_changeto_disconent_flag
1715  04d1               L353:
1716                     ; 636 	      if(flag_charge_ing)
1718  04d1 c60000        	ld	a,_flag_charge_ing
1719  04d4 2709          	jreq	L363
1720                     ; 639 			if(!charge_changeto_disconent_flag)
1722  04d6 c60021        	ld	a,_charge_changeto_disconent_flag
1723  04d9 2604          	jrne	L363
1724                     ; 640 			disp_index=Disp_USB_charge;
1726  04db 35110000      	mov	_disp_index,#17
1727  04df               L363:
1728                     ; 645 		if( Wireless_State== _Wireless_standby)
1730  04df c60000        	ld	a,_Wireless_State
1731  04e2 a103          	cp	a,#3
1732  04e4 2631          	jrne	L763
1733                     ; 647 			 charge_changeto_disconent_flag=0;
1735  04e6 725f0021      	clr	_charge_changeto_disconent_flag
1736                     ; 648                      poweroff_time++;
1738  04ea ce0016        	ldw	x,_poweroff_time
1739  04ed 5c            	incw	x
1740  04ee cf0016        	ldw	_poweroff_time,x
1741                     ; 649 			 if(poweroff_time==1020)
1743  04f1 a303fc        	cpw	x,#1020
1744  04f4 2625          	jrne	L373
1745                     ; 651 			 	  AMP_MUTE(ON);
1747  04f6 4b80          	push	#128
1748  04f8 ae5014        	ldw	x,#20500
1749  04fb cd0000        	call	_GPIO_WriteLow
1751  04fe 84            	pop	a
1752                     ; 652 			         Power_off_ready(ON);
1755  04ff 4b08          	push	#8
1756  0501 ae500f        	ldw	x,#20495
1757  0504 cd0000        	call	_GPIO_WriteLow
1759  0507 84            	pop	a
1760                     ; 653 			         MCU_POWER_SW(OFF);
1762  0508 4b02          	push	#2
1763  050a ae500a        	ldw	x,#20490
1764  050d cd0000        	call	_GPIO_WriteLow
1766  0510 5f            	clrw	x
1767  0511 cf0016        	ldw	_poweroff_time,x
1768  0514 84            	pop	a
1769                     ; 654 				  poweroff_time=0;
1771  0515 2004          	jra	L373
1772  0517               L763:
1773                     ; 660 			  poweroff_time=0;
1775  0517 5f            	clrw	x
1776  0518 cf0016        	ldw	_poweroff_time,x
1777  051b               L373:
1778                     ; 664 	          charge_report_time++;
1780  051b ce0019        	ldw	x,_charge_report_time
1781  051e 5c            	incw	x
1782  051f cf0019        	ldw	_charge_report_time,x
1783                     ; 665 			  if(charge_report_time>=3)
1785  0522 a30003        	cpw	x,#3
1786  0525 2513          	jrult	L573
1787                     ; 668 			  	   charge_report_time=0;
1789  0527 5f            	clrw	x
1790                     ; 669 				   	if(LR_Flag==1)
1792  0528 c60005        	ld	a,_LR_Flag
1793  052b 4a            	dec	a
1794  052c 2603          	jrne	L773
1795                     ; 670 				    charge_report_time=2;
1797  052e ae0002        	ldw	x,#2
1798  0531               L773:
1799  0531 cf0019        	ldw	_charge_report_time,x
1800                     ; 671 			          Report_Charge_Status(flag_charge_ing);
1802  0534 c60000        	ld	a,_flag_charge_ing
1803  0537 cd0000        	call	_Report_Charge_Status
1805  053a               L573:
1806                     ; 674               if( powe_on_mute_flag)
1808  053a c6001f        	ld	a,_powe_on_mute_flag
1809  053d 2713          	jreq	L104
1810                     ; 676                      if(battery_quantity!=Electric_Need_Cut)
1812  053f c60000        	ld	a,_battery_quantity
1813  0542 4a            	dec	a
1814  0543 270d          	jreq	L104
1815                     ; 678                                 Batt_16v_SW(ON);
1817  0545 4b80          	push	#128
1818  0547 ae500f        	ldw	x,#20495
1819  054a cd0000        	call	_GPIO_WriteHigh
1821  054d 725f001f      	clr	_powe_on_mute_flag
1822  0551 84            	pop	a
1823                     ; 679 				     powe_on_mute_flag=0;				
1825  0552               L104:
1826                     ; 683             system_1s_Timer_FLAG=0;
1828  0552 725f000d      	clr	_system_1s_Timer_FLAG
1829                     ; 685 }
1832  0556 81            	ret	
1859                     ; 691  void main(void)
1859                     ; 692 {   
1860                     	switch	.text
1861  0557               _main:
1865                     ; 695 	MCU_init();     
1867  0557 cd0254        	call	_MCU_init
1869  055a               L514:
1870                     ; 698        Upgrade_Loop();
1872  055a cd0000        	call	_Upgrade_Loop
1874                     ; 699 	if(up_state==UP_STATE_IDLE) 
1876  055d c60000        	ld	a,_up_state
1877  0560 26f8          	jrne	L514
1878                     ; 700 	System_Main_Loop();
1880  0562 cd0346        	call	_System_Main_Loop
1882  0565 20f3          	jra	L514
2135                     	xdef	_main
2136                     	xdef	_System_Main_Loop
2137                     	xdef	_MCU_init
2138                     	xdef	_System_Init
2139                     	xdef	_Init_Config_IO
2140                     	xdef	_TIM4_Config_1MS
2141                     	xdef	_CLOCK_Init
2142                     	xdef	_WaitForHSEStartUp
2143                     	xdef	_powe_on_mute_flag
2144                     	xdef	_new_old_board
2145                     	xdef	_temper_protect_time
2146                     	xdef	_full_charge_time
2147                     	xdef	_charge_report_time
2148                     	xdef	_temper_check_time
2149                     	xdef	_wireless_int_pin_ERROR
2150                     	xdef	_timer_20s
2151                     	xdef	_Pre_Wireless_State
2152                     	switch	.bss
2153  0001               _key_count:
2154  0001 00            	ds.b	1
2155                     	xdef	_key_count
2156                     	xdef	_test_flash_ID
2157                     	xref	_Key_Scan
2158                     	xref	_Key_Service
2159                     	xref	_Power_onoff_board
2160                     	xref	_shor_key
2161                     	xref	_shor_key_time
2162                     	xref	_STB_FLAG
2163                     	xref	_SPI_DSP_Init
2164                     	xref	_vAPP_Akm7719_Dsp_Init
2165                     	xref	_clear_rx_buffuer
2166                     	xref	_Report_Charge_Status
2167                     	xref	_System_PowerOff
2168                     	xref	_Wireless_RxInfoProcess
2169                     	xref	_Link_State
2170                     	xref	_Wireless_State
2171                     	xref	_Get_Battery_temper_Status
2172                     	xref	_Get_Battery_Status
2173                     	xref	_Charge_Manager_Loop
2174                     	xref	_Battery_Status_Detect
2175                     	xref	_battery_quantity
2176                     	xref	_Wireless_Reset
2177                     	xref	_Led_Display_Loop
2178                     	xref	_vLed_Display_Upg
2179                     	xref	_Wireless_State_Process
2180                     	xref	_disp_timer
2181                     	xref	_disp_index
2182                     	xdef	_Init_ADC1
2183                     	xdef	_Init_ADC9
2184                     	xdef	_system_1s_Timer
2185                     	xdef	_system_1Ms_Timer
2186                     	xdef	_standby_flag_SOD
2187                     	xdef	_charge_changeto_disconent_flag
2188                     	xdef	_OFF_USB_CHARGE_FLG
2189  0002               _charge_time:
2190  0002 0000          	ds.b	2
2191                     	xdef	_charge_time
2192                     	xdef	_standby_time
2193                     	xdef	_full_charge_flag
2194                     	xdef	_poweroff_time
2195                     	xdef	_standby_charge_flag
2196                     	xdef	_temper_value
2197                     	xdef	_power_on_time
2198                     	xdef	_link_to_dislinktime
2199                     	xdef	_connect_to_disconnecttime
2200                     	xdef	_led_test_time1
2201                     	xdef	_led_test_time
2202                     	xdef	_pairing_flag
2203                     	xdef	_system_1s_Timer_FLAG
2204                     	xdef	_RX_disconnect_time
2205                     	xdef	_rest_wireless_time
2206                     	xdef	_standby_flag
2207                     	xdef	_LR_Flag
2208                     	xref	_flag_charge_ing
2209  0004               _system_2s_tick:
2210  0004 00            	ds.b	1
2211                     	xdef	_system_2s_tick
2212                     	xdef	_system_20ms_tick
2213                     	xref	_Wait_For_mSec
2214                     	xref	_Upgrade_Loop
2215                     	xref	_initUart
2216                     	xref	_up_state
2217                     	xref	_UART2_DeInit
2218                     	xref	_TIM4_ITConfig
2219                     	xref	_TIM4_Cmd
2220                     	xref	_TIM4_TimeBaseInit
2221                     	xref	_TIM4_DeInit
2222                     	xref	_GPIO_ReadInputPin
2223                     	xref	_GPIO_WriteLow
2224                     	xref	_GPIO_WriteHigh
2225                     	xref	_GPIO_Init
2226                     	xref	_CLK_GetFlagStatus
2227                     	xref	_CLK_GetSYSCLKSource
2228                     	xref	_CLK_SYSCLKConfig
2229                     	xref	_CLK_CCOConfig
2230                     	xref	_CLK_ClockSwitchConfig
2231                     	xref	_CLK_CCOCmd
2232                     	xref	_CLK_HSECmd
2233                     	xref	_CLK_DeInit
2234                     	xref	_ADC1_StartConversion
2235                     	xref	_ADC1_Init
2255                     	end
