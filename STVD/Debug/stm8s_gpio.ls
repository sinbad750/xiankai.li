   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
 315                     ; 63 void GPIO_Init(GPIO_TypeDef* GPIOx,
 315                     ; 64                GPIO_Pin_TypeDef GPIO_Pin,
 315                     ; 65                GPIO_Mode_TypeDef GPIO_Mode)
 315                     ; 66 {
 317                     	switch	.text
 318  0000               _GPIO_Init:
 320  0000 89            	pushw	x
 321       00000000      OFST:	set	0
 324                     ; 71     assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
 326                     ; 72     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 328                     ; 78     if ((((u8)(GPIO_Mode)) & (u8)0x80) != (u8)0x00) /* Output mode */
 330  0001 7b06          	ld	a,(OFST+6,sp)
 331  0003 2a18          	jrpl	L751
 332                     ; 80         if ((((u8)(GPIO_Mode)) & (u8)0x10) != (u8)0x00) /* High level */
 334  0005 a510          	bcp	a,#16
 335  0007 2705          	jreq	L161
 336                     ; 82             GPIOx->ODR |= (u8)GPIO_Pin;
 338  0009 f6            	ld	a,(x)
 339  000a 1a05          	or	a,(OFST+5,sp)
 341  000c 2006          	jra	L361
 342  000e               L161:
 343                     ; 85             GPIOx->ODR &= (u8)(~(GPIO_Pin));
 345  000e 1e01          	ldw	x,(OFST+1,sp)
 346  0010 7b05          	ld	a,(OFST+5,sp)
 347  0012 43            	cpl	a
 348  0013 f4            	and	a,(x)
 349  0014               L361:
 350  0014 f7            	ld	(x),a
 351                     ; 88         GPIOx->DDR |= (u8)GPIO_Pin;
 353  0015 1e01          	ldw	x,(OFST+1,sp)
 354  0017 e602          	ld	a,(2,x)
 355  0019 1a05          	or	a,(OFST+5,sp)
 357  001b 2007          	jra	L561
 358  001d               L751:
 359                     ; 92         GPIOx->DDR &= (u8)(~(GPIO_Pin));
 361  001d 1e01          	ldw	x,(OFST+1,sp)
 362  001f 7b05          	ld	a,(OFST+5,sp)
 363  0021 43            	cpl	a
 364  0022 e402          	and	a,(2,x)
 365  0024               L561:
 366  0024 e702          	ld	(2,x),a
 367                     ; 99     if ((((u8)(GPIO_Mode)) & (u8)0x40) != (u8)0x00) /* Pull-Up or Push-Pull */
 369  0026 7b06          	ld	a,(OFST+6,sp)
 370  0028 a540          	bcp	a,#64
 371  002a 2706          	jreq	L761
 372                     ; 101         GPIOx->CR1 |= (u8)GPIO_Pin;
 374  002c e603          	ld	a,(3,x)
 375  002e 1a05          	or	a,(OFST+5,sp)
 377  0030 2005          	jra	L171
 378  0032               L761:
 379                     ; 104         GPIOx->CR1 &= (u8)(~(GPIO_Pin));
 381  0032 7b05          	ld	a,(OFST+5,sp)
 382  0034 43            	cpl	a
 383  0035 e403          	and	a,(3,x)
 384  0037               L171:
 385  0037 e703          	ld	(3,x),a
 386                     ; 111     if ((((u8)(GPIO_Mode)) & (u8)0x20) != (u8)0x00) /* Interrupt or Slow slope */
 388  0039 7b06          	ld	a,(OFST+6,sp)
 389  003b a520          	bcp	a,#32
 390  003d 2706          	jreq	L371
 391                     ; 113         GPIOx->CR2 |= (u8)GPIO_Pin;
 393  003f e604          	ld	a,(4,x)
 394  0041 1a05          	or	a,(OFST+5,sp)
 396  0043 2005          	jra	L571
 397  0045               L371:
 398                     ; 116         GPIOx->CR2 &= (u8)(~(GPIO_Pin));
 400  0045 7b05          	ld	a,(OFST+5,sp)
 401  0047 43            	cpl	a
 402  0048 e404          	and	a,(4,x)
 403  004a               L571:
 404  004a e704          	ld	(4,x),a
 405                     ; 119 }
 408  004c 85            	popw	x
 409  004d 81            	ret	
 456                     ; 132 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 456                     ; 133 {
 457                     	switch	.text
 458  004e               _GPIO_WriteHigh:
 460  004e 89            	pushw	x
 461       00000000      OFST:	set	0
 464                     ; 134     GPIOx->ODR |= (u8)PortPins;
 466  004f f6            	ld	a,(x)
 467  0050 1a05          	or	a,(OFST+5,sp)
 468  0052 f7            	ld	(x),a
 469                     ; 135 }
 472  0053 85            	popw	x
 473  0054 81            	ret	
 520                     ; 146 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 520                     ; 147 {
 521                     	switch	.text
 522  0055               _GPIO_WriteLow:
 524  0055 89            	pushw	x
 525       00000000      OFST:	set	0
 528                     ; 148     GPIOx->ODR &= (u8)(~PortPins);
 530  0056 7b05          	ld	a,(OFST+5,sp)
 531  0058 43            	cpl	a
 532  0059 f4            	and	a,(x)
 533  005a f7            	ld	(x),a
 534                     ; 149 }
 537  005b 85            	popw	x
 538  005c 81            	ret	
 585                     ; 152 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 585                     ; 153 {
 586                     	switch	.text
 587  005d               _GPIO_WriteReverse:
 589  005d 89            	pushw	x
 590       00000000      OFST:	set	0
 593                     ; 154   GPIOx->ODR ^= (u8)PortPins;
 595  005e f6            	ld	a,(x)
 596  005f 1805          	xor	a,(OFST+5,sp)
 597  0061 f7            	ld	(x),a
 598                     ; 155 }
 601  0062 85            	popw	x
 602  0063 81            	ret	
 670                     ; 158 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 670                     ; 159 {
 671                     	switch	.text
 672  0064               _GPIO_ReadInputPin:
 674  0064 89            	pushw	x
 675       00000000      OFST:	set	0
 678                     ; 160     return ((BitStatus)(GPIOx->IDR & (vu8)GPIO_Pin));
 680  0065 e601          	ld	a,(1,x)
 681  0067 1405          	and	a,(OFST+5,sp)
 684  0069 85            	popw	x
 685  006a 81            	ret	
 733                     ; 163 BitStatus GPIO_ReadOutputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 733                     ; 164 {
 734                     	switch	.text
 735  006b               _GPIO_ReadOutputPin:
 737  006b 89            	pushw	x
 738       00000000      OFST:	set	0
 741                     ; 165     return ((BitStatus)(GPIOx->ODR& (vu8)GPIO_Pin));
 743  006c f6            	ld	a,(x)
 744  006d 1405          	and	a,(OFST+5,sp)
 747  006f 85            	popw	x
 748  0070 81            	ret	
 761                     	xdef	_GPIO_ReadOutputPin
 762                     	xdef	_GPIO_ReadInputPin
 763                     	xdef	_GPIO_WriteReverse
 764                     	xdef	_GPIO_WriteLow
 765                     	xdef	_GPIO_WriteHigh
 766                     	xdef	_GPIO_Init
 785                     	end
