   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  46                     ; 42 void TIM4_DeInit(void)
  46                     ; 43 {
  48                     	switch	.text
  49  0000               _TIM4_DeInit:
  53                     ; 44     TIM4->CR1 = TIM4_CR1_RESET_VALUE;
  55  0000 725f5340      	clr	21312
  56                     ; 45     TIM4->IER = TIM4_IER_RESET_VALUE;
  58  0004 725f5341      	clr	21313
  59                     ; 46     TIM4->CNTR = TIM4_CNTR_RESET_VALUE;
  61  0008 725f5344      	clr	21316
  62                     ; 47     TIM4->PSCR = TIM4_PSCR_RESET_VALUE;
  64  000c 725f5345      	clr	21317
  65                     ; 48     TIM4->ARR = TIM4_ARR_RESET_VALUE;
  67  0010 35ff5346      	mov	21318,#255
  68                     ; 49     TIM4->SR1 = TIM4_SR1_RESET_VALUE;
  70  0014 725f5342      	clr	21314
  71                     ; 50 }
  74  0018 81            	ret	
 178                     ; 58 void TIM4_TimeBaseInit(TIM4_Prescaler_TypeDef TIM4_Prescaler, u8 TIM4_Period)
 178                     ; 59 {
 179                     	switch	.text
 180  0019               _TIM4_TimeBaseInit:
 184                     ; 61     assert_param(IS_TIM4_PRESCALER_OK(TIM4_Prescaler));
 186                     ; 63     TIM4->PSCR = (u8)(TIM4_Prescaler);
 188  0019 9e            	ld	a,xh
 189  001a c75345        	ld	21317,a
 190                     ; 65     TIM4->ARR = (u8)(TIM4_Period);
 192  001d 9f            	ld	a,xl
 193  001e c75346        	ld	21318,a
 194                     ; 66 }
 197  0021 81            	ret	
 252                     ; 76 void TIM4_Cmd(FunctionalState NewState)
 252                     ; 77 {
 253                     	switch	.text
 254  0022               _TIM4_Cmd:
 258                     ; 79     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 260                     ; 82     if (NewState != DISABLE)
 262  0022 4d            	tnz	a
 263  0023 2705          	jreq	L311
 264                     ; 84         TIM4->CR1 |= TIM4_CR1_CEN;
 266  0025 72105340      	bset	21312,#0
 269  0029 81            	ret	
 270  002a               L311:
 271                     ; 88         TIM4->CR1 &= (u8)(~TIM4_CR1_CEN);
 273  002a 72115340      	bres	21312,#0
 274                     ; 90 }
 277  002e 81            	ret	
 335                     ; 102 void TIM4_ITConfig(TIM4_IT_TypeDef TIM4_IT, FunctionalState NewState)
 335                     ; 103 {
 336                     	switch	.text
 337  002f               _TIM4_ITConfig:
 339  002f 89            	pushw	x
 340       00000000      OFST:	set	0
 343                     ; 105     assert_param(IS_TIM4_IT_OK(TIM4_IT));
 345                     ; 106     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 347                     ; 108     if (NewState != DISABLE)
 349  0030 9f            	ld	a,xl
 350  0031 4d            	tnz	a
 351  0032 2706          	jreq	L741
 352                     ; 111         TIM4->IER |= (u8)TIM4_IT;
 354  0034 9e            	ld	a,xh
 355  0035 ca5341        	or	a,21313
 357  0038 2006          	jra	L151
 358  003a               L741:
 359                     ; 116         TIM4->IER &= (u8)(~TIM4_IT);
 361  003a 7b01          	ld	a,(OFST+1,sp)
 362  003c 43            	cpl	a
 363  003d c45341        	and	a,21313
 364  0040               L151:
 365  0040 c75341        	ld	21313,a
 366                     ; 118 }
 369  0043 85            	popw	x
 370  0044 81            	ret	
 426                     ; 192 ITStatus TIM4_GetITStatus(TIM4_IT_TypeDef TIM4_IT)
 426                     ; 193 {
 427                     	switch	.text
 428  0045               _TIM4_GetITStatus:
 430  0045 88            	push	a
 431       00000000      OFST:	set	0
 434                     ; 195     assert_param(IS_TIM4_IT_OK(TIM4_IT));
 436                     ; 197     if (((TIM4->SR1 & TIM4_IT) != RESET ) && ((TIM4->IER & TIM4_IT) != RESET ))
 438  0046 c45342        	and	a,21314
 439  0049 270c          	jreq	L102
 441  004b c65341        	ld	a,21313
 442  004e 1501          	bcp	a,(OFST+1,sp)
 443  0050 2705          	jreq	L102
 444                     ; 199         return (ITStatus)(SET);
 446  0052 a601          	ld	a,#1
 449  0054 5b01          	addw	sp,#1
 450  0056 81            	ret	
 451  0057               L102:
 452                     ; 203         return (ITStatus)(RESET);
 454  0057 4f            	clr	a
 457  0058 5b01          	addw	sp,#1
 458  005a 81            	ret	
 494                     ; 214 void TIM4_ClearITPendingBit(TIM4_IT_TypeDef TIM4_IT)
 494                     ; 215 {
 495                     	switch	.text
 496  005b               _TIM4_ClearITPendingBit:
 500                     ; 217     assert_param(IS_TIM4_IT_OK(TIM4_IT));
 502                     ; 220     TIM4->SR1 = (u8)(~TIM4_IT);
 504  005b 43            	cpl	a
 505  005c c75342        	ld	21314,a
 506                     ; 221 }
 509  005f 81            	ret	
 522                     	xdef	_TIM4_ClearITPendingBit
 523                     	xdef	_TIM4_GetITStatus
 524                     	xdef	_TIM4_ITConfig
 525                     	xdef	_TIM4_Cmd
 526                     	xdef	_TIM4_TimeBaseInit
 527                     	xdef	_TIM4_DeInit
 546                     	end
