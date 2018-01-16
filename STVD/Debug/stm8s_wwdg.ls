   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  46                     ; 95 void WWDG_SWReset(void)
  46                     ; 96 {
  48                     	switch	.text
  49  0000               _WWDG_SWReset:
  53                     ; 97     WWDG->CR = WWDG_CR_WDGA; /* Activate WWDG, with clearing T6 */
  55  0000 358050d1      	mov	20689,#128
  56                     ; 98 }
  59  0004 81            	ret	
  72                     	xdef	_WWDG_SWReset
  91                     	end
