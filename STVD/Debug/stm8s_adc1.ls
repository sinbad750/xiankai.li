   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
 459                     ; 85 void ADC1_Init(ADC1_ConvMode_TypeDef ADC1_ConversionMode, ADC1_Channel_TypeDef ADC1_Channel, ADC1_PresSel_TypeDef ADC1_PrescalerSelection, ADC1_ExtTrig_TypeDef ADC1_ExtTrigger, FunctionalState ADC1_ExtTriggerState, ADC1_Align_TypeDef ADC1_Align, ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel, FunctionalState ADC1_SchmittTriggerState)
 459                     ; 86 {
 461                     	switch	.text
 462  0000               _ADC1_Init:
 464  0000 89            	pushw	x
 465       00000000      OFST:	set	0
 468                     ; 89     assert_param(IS_ADC1_CONVERSIONMODE_OK(ADC1_ConversionMode));
 470                     ; 90     assert_param(IS_ADC1_CHANNEL_OK(ADC1_Channel));
 472                     ; 91     assert_param(IS_ADC1_PRESSEL_OK(ADC1_PrescalerSelection));
 474                     ; 92     assert_param(IS_ADC1_EXTTRIG_OK(ADC1_ExtTrigger));
 476                     ; 93     assert_param(IS_FUNCTIONALSTATE_OK(((ADC1_ExtTriggerState))));
 478                     ; 94     assert_param(IS_ADC1_ALIGN_OK(ADC1_Align));
 480                     ; 95     assert_param(IS_ADC1_SCHMITTTRIG_OK(ADC1_SchmittTriggerChannel));
 482                     ; 96     assert_param(IS_FUNCTIONALSTATE_OK(ADC1_SchmittTriggerState));
 484                     ; 101     ADC1_ConversionConfig(ADC1_ConversionMode, ADC1_Channel, ADC1_Align);
 486  0001 7b08          	ld	a,(OFST+8,sp)
 487  0003 88            	push	a
 488  0004 7b02          	ld	a,(OFST+2,sp)
 489  0006 95            	ld	xh,a
 490  0007 cd00b3        	call	_ADC1_ConversionConfig
 492  000a 84            	pop	a
 493                     ; 103     ADC1_PrescalerConfig(ADC1_PrescalerSelection);
 495  000b 7b05          	ld	a,(OFST+5,sp)
 496  000d ad17          	call	_ADC1_PrescalerConfig
 498                     ; 108     ADC1_ExternalTriggerConfig(ADC1_ExtTrigger, ADC1_ExtTriggerState);
 500  000f 7b07          	ld	a,(OFST+7,sp)
 501  0011 97            	ld	xl,a
 502  0012 7b06          	ld	a,(OFST+6,sp)
 503  0014 95            	ld	xh,a
 504  0015 cd00e0        	call	_ADC1_ExternalTriggerConfig
 506                     ; 113     ADC1_SchmittTriggerConfig(ADC1_SchmittTriggerChannel, ADC1_SchmittTriggerState);
 508  0018 7b0a          	ld	a,(OFST+10,sp)
 509  001a 97            	ld	xl,a
 510  001b 7b09          	ld	a,(OFST+9,sp)
 511  001d 95            	ld	xh,a
 512  001e ad19          	call	_ADC1_SchmittTriggerConfig
 514                     ; 116     ADC1->CR1 |= ADC1_CR1_ADON;
 516  0020 72105401      	bset	21505,#0
 517                     ; 118 }
 520  0024 85            	popw	x
 521  0025 81            	ret	
 557                     ; 179 void ADC1_PrescalerConfig(ADC1_PresSel_TypeDef ADC1_Prescaler)
 557                     ; 180 {
 558                     	switch	.text
 559  0026               _ADC1_PrescalerConfig:
 561  0026 88            	push	a
 562       00000000      OFST:	set	0
 565                     ; 183     assert_param(IS_ADC1_PRESSEL_OK(ADC1_Prescaler));
 567                     ; 186     ADC1->CR1 &= (u8)(~ADC1_CR1_SPSEL);
 569  0027 c65401        	ld	a,21505
 570  002a a48f          	and	a,#143
 571  002c c75401        	ld	21505,a
 572                     ; 188     ADC1->CR1 |= (u8)(ADC1_Prescaler);
 574  002f c65401        	ld	a,21505
 575  0032 1a01          	or	a,(OFST+1,sp)
 576  0034 c75401        	ld	21505,a
 577                     ; 190 }
 580  0037 84            	pop	a
 581  0038 81            	ret	
 628                     ; 201 void ADC1_SchmittTriggerConfig(ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel, FunctionalState NewState)
 628                     ; 202 {
 629                     	switch	.text
 630  0039               _ADC1_SchmittTriggerConfig:
 632  0039 89            	pushw	x
 633       00000000      OFST:	set	0
 636                     ; 205     assert_param(IS_ADC1_SCHMITTTRIG_OK(ADC1_SchmittTriggerChannel));
 638                     ; 206     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 640                     ; 208     if (ADC1_SchmittTriggerChannel == ADC1_SCHMITTTRIG_ALL)
 642  003a 9e            	ld	a,xh
 643  003b 4c            	inc	a
 644  003c 261d          	jrne	L172
 645                     ; 210         if (NewState != DISABLE)
 647  003e 9f            	ld	a,xl
 648  003f 4d            	tnz	a
 649  0040 270a          	jreq	L372
 650                     ; 212             ADC1->TDRL &= (u8)0x0;
 652  0042 725f5407      	clr	21511
 653                     ; 213             ADC1->TDRH &= (u8)0x0;
 655  0046 725f5406      	clr	21510
 657  004a 2065          	jra	L772
 658  004c               L372:
 659                     ; 217             ADC1->TDRL |= (u8)0xFF;
 661  004c c65407        	ld	a,21511
 662  004f aaff          	or	a,#255
 663  0051 c75407        	ld	21511,a
 664                     ; 218             ADC1->TDRH |= (u8)0xFF;
 666  0054 c65406        	ld	a,21510
 667  0057 aaff          	or	a,#255
 668  0059 2053          	jp	LC001
 669  005b               L172:
 670                     ; 221     else if (ADC1_SchmittTriggerChannel < ADC1_SCHMITTTRIG_CHANNEL8)
 672  005b 7b01          	ld	a,(OFST+1,sp)
 673  005d a108          	cp	a,#8
 674  005f 0d02          	tnz	(OFST+2,sp)
 675  0061 2426          	jruge	L103
 676                     ; 223         if (NewState != DISABLE)
 678  0063 2714          	jreq	L303
 679                     ; 225             ADC1->TDRL &= (u8)(~(u8)((u8)0x01 << (u8)ADC1_SchmittTriggerChannel));
 681  0065 5f            	clrw	x
 682  0066 97            	ld	xl,a
 683  0067 a601          	ld	a,#1
 684  0069 5d            	tnzw	x
 685  006a 2704          	jreq	L22
 686  006c               L42:
 687  006c 48            	sll	a
 688  006d 5a            	decw	x
 689  006e 26fc          	jrne	L42
 690  0070               L22:
 691  0070 43            	cpl	a
 692  0071 c45407        	and	a,21511
 693  0074               LC002:
 694  0074 c75407        	ld	21511,a
 696  0077 2038          	jra	L772
 697  0079               L303:
 698                     ; 229             ADC1->TDRL |= (u8)((u8)0x01 << (u8)ADC1_SchmittTriggerChannel);
 700  0079 5f            	clrw	x
 701  007a 97            	ld	xl,a
 702  007b a601          	ld	a,#1
 703  007d 5d            	tnzw	x
 704  007e 2704          	jreq	L62
 705  0080               L03:
 706  0080 48            	sll	a
 707  0081 5a            	decw	x
 708  0082 26fc          	jrne	L03
 709  0084               L62:
 710  0084 ca5407        	or	a,21511
 711  0087 20eb          	jp	LC002
 712  0089               L103:
 713                     ; 234         if (NewState != DISABLE)
 715  0089 2713          	jreq	L113
 716                     ; 236             ADC1->TDRH &= (u8)(~(u8)((u8)0x01 << ((u8)ADC1_SchmittTriggerChannel - (u8)8)));
 718  008b a008          	sub	a,#8
 719  008d 5f            	clrw	x
 720  008e 97            	ld	xl,a
 721  008f a601          	ld	a,#1
 722  0091 5d            	tnzw	x
 723  0092 2704          	jreq	L23
 724  0094               L43:
 725  0094 48            	sll	a
 726  0095 5a            	decw	x
 727  0096 26fc          	jrne	L43
 728  0098               L23:
 729  0098 43            	cpl	a
 730  0099 c45406        	and	a,21510
 732  009c 2010          	jp	LC001
 733  009e               L113:
 734                     ; 240             ADC1->TDRH |= (u8)((u8)0x01 << ((u8)ADC1_SchmittTriggerChannel - (u8)8));
 736  009e a008          	sub	a,#8
 737  00a0 5f            	clrw	x
 738  00a1 97            	ld	xl,a
 739  00a2 a601          	ld	a,#1
 740  00a4 5d            	tnzw	x
 741  00a5 2704          	jreq	L63
 742  00a7               L04:
 743  00a7 48            	sll	a
 744  00a8 5a            	decw	x
 745  00a9 26fc          	jrne	L04
 746  00ab               L63:
 747  00ab ca5406        	or	a,21510
 748  00ae               LC001:
 749  00ae c75406        	ld	21510,a
 750  00b1               L772:
 751                     ; 244 }
 754  00b1 85            	popw	x
 755  00b2 81            	ret	
 812                     ; 256 void ADC1_ConversionConfig(ADC1_ConvMode_TypeDef ADC1_ConversionMode, ADC1_Channel_TypeDef ADC1_Channel, ADC1_Align_TypeDef ADC1_Align)
 812                     ; 257 {
 813                     	switch	.text
 814  00b3               _ADC1_ConversionConfig:
 816       00000000      OFST:	set	0
 819                     ; 260     assert_param(IS_ADC1_CONVERSIONMODE_OK(ADC1_ConversionMode));
 821                     ; 261     assert_param(IS_ADC1_CHANNEL_OK(ADC1_Channel));
 823                     ; 262     assert_param(IS_ADC1_ALIGN_OK(ADC1_Align));
 825                     ; 265     ADC1->CR2 &= (u8)(~ADC1_CR2_ALIGN);
 827  00b3 72175402      	bres	21506,#3
 828  00b7 89            	pushw	x
 829                     ; 267     ADC1->CR2 |= (u8)(ADC1_Align);
 831  00b8 c65402        	ld	a,21506
 832  00bb 1a05          	or	a,(OFST+5,sp)
 833  00bd c75402        	ld	21506,a
 834                     ; 269     if (ADC1_ConversionMode == ADC1_CONVERSIONMODE_CONTINUOUS)
 836  00c0 9e            	ld	a,xh
 837  00c1 4a            	dec	a
 838  00c2 2606          	jrne	L343
 839                     ; 272         ADC1->CR1 |= ADC1_CR1_CONT;
 841  00c4 72125401      	bset	21505,#1
 843  00c8 2004          	jra	L543
 844  00ca               L343:
 845                     ; 277         ADC1->CR1 &= (u8)(~ADC1_CR1_CONT);
 847  00ca 72135401      	bres	21505,#1
 848  00ce               L543:
 849                     ; 281     ADC1->CSR &= (u8)(~ADC1_CSR_CH);
 851  00ce c65400        	ld	a,21504
 852  00d1 a4f0          	and	a,#240
 853  00d3 c75400        	ld	21504,a
 854                     ; 283     ADC1->CSR |= (u8)(ADC1_Channel);
 856  00d6 c65400        	ld	a,21504
 857  00d9 1a02          	or	a,(OFST+2,sp)
 858  00db c75400        	ld	21504,a
 859                     ; 285 }
 862  00de 85            	popw	x
 863  00df 81            	ret	
 909                     ; 297 void ADC1_ExternalTriggerConfig(ADC1_ExtTrig_TypeDef ADC1_ExtTrigger, FunctionalState NewState)
 909                     ; 298 {
 910                     	switch	.text
 911  00e0               _ADC1_ExternalTriggerConfig:
 913  00e0 89            	pushw	x
 914       00000000      OFST:	set	0
 917                     ; 301     assert_param(IS_ADC1_EXTTRIG_OK(ADC1_ExtTrigger));
 919                     ; 302     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 921                     ; 305     ADC1->CR2 &= (u8)(~ADC1_CR2_EXTSEL);
 923  00e1 c65402        	ld	a,21506
 924  00e4 a4cf          	and	a,#207
 925  00e6 c75402        	ld	21506,a
 926                     ; 307     if (NewState != DISABLE)
 928  00e9 9f            	ld	a,xl
 929  00ea 4d            	tnz	a
 930  00eb 2706          	jreq	L173
 931                     ; 310         ADC1->CR2 |= (u8)(ADC1_CR2_EXTTRIG);
 933  00ed 721c5402      	bset	21506,#6
 935  00f1 2004          	jra	L373
 936  00f3               L173:
 937                     ; 315         ADC1->CR2 &= (u8)(~ADC1_CR2_EXTTRIG);
 939  00f3 721d5402      	bres	21506,#6
 940  00f7               L373:
 941                     ; 319     ADC1->CR2 |= (u8)(ADC1_ExtTrigger);
 943  00f7 c65402        	ld	a,21506
 944  00fa 1a01          	or	a,(OFST+1,sp)
 945  00fc c75402        	ld	21506,a
 946                     ; 321 }
 949  00ff 85            	popw	x
 950  0100 81            	ret	
 974                     ; 333 void ADC1_StartConversion(void)
 974                     ; 334 {
 975                     	switch	.text
 976  0101               _ADC1_StartConversion:
 980                     ; 335     ADC1->CR1 |= ADC1_CR1_ADON;
 982  0101 72105401      	bset	21505,#0
 983                     ; 336 }
 986  0105 81            	ret	
1026                     ; 346 u16 ADC1_GetConversionValue(void)
1026                     ; 347 {
1027                     	switch	.text
1028  0106               _ADC1_GetConversionValue:
1030  0106 5205          	subw	sp,#5
1031       00000005      OFST:	set	5
1034                     ; 349     u16 temph = 0;
1036                     ; 350     u8 templ = 0;
1038                     ; 352     if (ADC1->CR2 & ADC1_CR2_ALIGN) /* Right alignment */
1040  0108 720754020e    	btjf	21506,#3,L324
1041                     ; 355         templ = ADC1->DRL;
1043  010d c65405        	ld	a,21509
1044  0110 6b03          	ld	(OFST-2,sp),a
1045                     ; 357         temph = ADC1->DRH;
1047  0112 c65404        	ld	a,21508
1048  0115 97            	ld	xl,a
1049                     ; 359         temph = (u16)(templ | (u16)(temph << (u8)8));
1051  0116 7b03          	ld	a,(OFST-2,sp)
1052  0118 02            	rlwa	x,a
1054  0119 201a          	jra	L524
1055  011b               L324:
1056                     ; 364         temph = ADC1->DRH;
1058  011b c65404        	ld	a,21508
1059  011e 97            	ld	xl,a
1060                     ; 366         templ = ADC1->DRL;
1062  011f c65405        	ld	a,21509
1063  0122 6b03          	ld	(OFST-2,sp),a
1064                     ; 368         temph = (u16)((u16)(templ << (u8)6) | (u16)(temph << (u8)8));
1066  0124 4f            	clr	a
1067  0125 02            	rlwa	x,a
1068  0126 1f01          	ldw	(OFST-4,sp),x
1069  0128 7b03          	ld	a,(OFST-2,sp)
1070  012a 97            	ld	xl,a
1071  012b a640          	ld	a,#64
1072  012d 42            	mul	x,a
1073  012e 01            	rrwa	x,a
1074  012f 1a02          	or	a,(OFST-3,sp)
1075  0131 01            	rrwa	x,a
1076  0132 1a01          	or	a,(OFST-4,sp)
1077  0134 01            	rrwa	x,a
1078  0135               L524:
1079                     ; 371     return ((u16)temph);
1083  0135 5b05          	addw	sp,#5
1084  0137 81            	ret	
1128                     ; 383 FlagStatus ADC1_GetFlagStatus(void)
1128                     ; 384 {
1129                     	switch	.text
1130  0138               _ADC1_GetFlagStatus:
1134                     ; 387     return ((u8)(ADC1->CSR & ADC1_CSR_EOC));
1136  0138 c65400        	ld	a,21504
1137  013b a480          	and	a,#128
1140  013d 81            	ret	
1163                     ; 399 void ADC1_ClearFlag(void)
1163                     ; 400 {
1164                     	switch	.text
1165  013e               _ADC1_ClearFlag:
1169                     ; 402     ADC1->CSR &= (u8)(~ADC1_CSR_EOC);
1171  013e 721f5400      	bres	21504,#7
1172                     ; 403 }
1175  0142 81            	ret	
1188                     	xdef	_ADC1_ClearFlag
1189                     	xdef	_ADC1_GetFlagStatus
1190                     	xdef	_ADC1_GetConversionValue
1191                     	xdef	_ADC1_StartConversion
1192                     	xdef	_ADC1_ExternalTriggerConfig
1193                     	xdef	_ADC1_ConversionConfig
1194                     	xdef	_ADC1_SchmittTriggerConfig
1195                     	xdef	_ADC1_PrescalerConfig
1196                     	xdef	_ADC1_Init
1215                     	end
