/**
  ******************************************************************************
  * @file stm8s_clk.c
  * @brief This file contains all the functions for the CLK peripheral.
  * @author STMicroelectronics - MCD Application Team
  * @version V1.1.1
  * @date 06/05/2009
  ******************************************************************************
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2009 STMicroelectronics</center></h2>
  * @image html logo.bmp
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/

#include "stm8s_clk.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/

/* Private Constants ---------------------------------------------------------*/

/**
  * @addtogroup CLK_Private_Constants
  * @{
  */
uc8 HSIDivFactor[4] = {1, 2, 4, 8}; /*!< Holds the different HSI Dividor factors */
#if 1
uc8 CLKPrescTable[8] = {1, 2, 4, 8, 10, 16, 20, 40}; /*!< Holds the different CLK prescaler values */

/**
  * @}
  */

/* Public functions ----------------------------------------------------------*/
/**
  * @addtogroup CLK_Public_Functions
  * @{
  */

/**
  * @brief Deinitializes the CLK peripheral registers to their default reset
  * values.
  * @par Parameters:
  * None
  * @retval None
  * @par Warning:
  * Resetting the CCOR register: \n
  * When the CCOEN bit is set, the reset of the CCOR register require
  * two consecutive write instructions in order to reset first the CCOEN bit
  * and the second one is to reset the CCOSEL bits.
  */
void CLK_DeInit(void)
{

    CLK->ICKR = CLK_ICKR_RESET_VALUE;
    CLK->ECKR = CLK_ECKR_RESET_VALUE;
    CLK->SWR  = CLK_SWR_RESET_VALUE;
    CLK->SWCR = CLK_SWCR_RESET_VALUE;
    CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
    CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
    CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
    CLK->CSSR = CLK_CSSR_RESET_VALUE;
    CLK->CCOR = CLK_CCOR_RESET_VALUE;
    while (CLK->CCOR & CLK_CCOR_CCOEN)
    {}
    CLK->CCOR = CLK_CCOR_RESET_VALUE;
    CLK->CANCCR = CLK_CANCCR_RESET_VALUE;
    CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
    CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;

}
#endif
/**
  * @brief Enable or Disable the External High Speed oscillator (HSE).
  * @param[in] NewState new state of HSEEN, value accepted ENABLE, DISABLE.
  * @retval None
  */
void CLK_HSECmd(FunctionalState NewState)
{

    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    if (NewState != DISABLE)
    {
        /* Set HSEEN bit */
        CLK->ECKR |= CLK_ECKR_HSEEN;
    }
    else
    {
        /* Reset HSEEN bit */
        CLK->ECKR &= (u8)(~CLK_ECKR_HSEEN);
    }

}
#if 0
/**
  * @brief Enables or disables the Internal High Speed oscillator (HSI).
  * @param[in] NewState new state of HSIEN, value accepted ENABLE, DISABLE.
  * @retval None
  */
void CLK_HSICmd(FunctionalState NewState)
{

    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    if (NewState != DISABLE)
    {
        /* Set HSIEN bit */
        CLK->ICKR |= CLK_ICKR_HSIEN;
    }
    else
    {
        /* Reset HSIEN bit */
        CLK->ICKR &= (u8)(~CLK_ICKR_HSIEN);
    }

}


/**
  * @brief Enables or disablle the Configurable Clock Output (CCO).
  * @param[in] NewState : New state of CCEN bit (CCO register).
  * This parameter can be any of the @ref FunctionalState enumeration.
  * @retval None
  */

/**
  * @brief Starts or Stops manually the clock switch execution.
  * @par Full description:
  * NewState parameter set the SWEN.
  * @param[in] NewState new state of SWEN, value accepted ENABLE, DISABLE.
  * @retval None
  */


#endif
/**
  * @brief This function returns the frequencies of different on chip clocks.
  * @par Parameters:
  * None
  * @retval the master clock frequency
  * @par Required preconditions:
  * None
  */
u32 CLK_GetClockFreq(void)
{

  u32 clockfrequency = 0;
  CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
  u8 tmp = 0, presc = 0;

  /* Get CLK source. */
  clocksource = (CLK_Source_TypeDef)CLK->CMSR;

  if (clocksource == CLK_SOURCE_HSI)
  {
    tmp = (u8)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
    tmp = (u8)(tmp >> 3);
    presc = HSIDivFactor[tmp];
    clockfrequency = HSI_VALUE / presc;
  }
  else if ( clocksource == CLK_SOURCE_LSI)
  {
    clockfrequency = LSI_VALUE;
  }
  else
  {
    clockfrequency = HSE_VALUE;
  }

  return((u32)clockfrequency);

}

#if 0

void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
{

    /* check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));
    assert_param(IS_CLK_IT_OK(CLK_IT));

    if (NewState != DISABLE)
    {
        switch (CLK_IT)
        {
        case CLK_IT_SWIF: /* Enable the clock switch interrupt */
            CLK->SWCR |= CLK_SWCR_SWIEN;
            break;
        case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
            CLK->CSSR |= CLK_CSSR_CSSDIE;
            break;
        default:
            break;
        }
    }
    else  /*(NewState == DISABLE)*/
    {
        switch (CLK_IT)
        {
        case CLK_IT_SWIF: /* Disable the clock switch interrupt */
            CLK->SWCR  &= (u8)(~CLK_SWCR_SWIEN);
            break;
        case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
            CLK->CSSR &= (u8)(~CLK_CSSR_CSSDIE);
            break;
        default:
            break;
        }
    }

}
#endif

/**
  * @brief Configures the HSI and CPU clock dividers.
  * @param[in] ClockPrescaler Specifies the HSI or CPU clock divider to apply.
  * @retval None
  */
void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef ClockPrescaler)
{

    /* check the parameters */
    assert_param(IS_CLK_PRESCALER_OK(ClockPrescaler));

    if (((u8)ClockPrescaler & (u8)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
    {
        CLK->CKDIVR &= (u8)(~CLK_CKDIVR_HSIDIV);
        CLK->CKDIVR |= (u8)((u8)ClockPrescaler & (u8)CLK_CKDIVR_HSIDIV);
    }
    else /* Bit7 = 1 means CPU divider */
    {
        CLK->CKDIVR &= (u8)(~CLK_CKDIVR_CPUDIV);
        CLK->CKDIVR |= (u8)((u8)ClockPrescaler & (u8)CLK_CKDIVR_CPUDIV);
    }
}
FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
{

    u16 statusreg = 0;
    u8 tmpreg = 0;
    FlagStatus bitstatus = RESET;

    /* check the parameters */
    assert_param(IS_CLK_FLAG_OK(CLK_FLAG));

    /* Get the CLK register index */
    statusreg = (u16)((u16)CLK_FLAG & (u16)0xFF00);


    if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
    {
        tmpreg = CLK->ICKR;
    }
    else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
    {
        tmpreg = CLK->ECKR;
    }
    else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
    {
        tmpreg = CLK->SWCR;
    }
    else if (statusreg == 0x0400) /* The flag to check is in CSS register */
    {
        tmpreg = CLK->CSSR;
    }
    else /* The flag to check is in CCO register */
    {
        tmpreg = CLK->CCOR;
    }

    if ((tmpreg & (u8)CLK_FLAG) != (u8)RESET)
    {
        bitstatus = SET;
    }
    else
    {
        bitstatus = RESET;
    }

    /* Return the flag status */
    return((FlagStatus)bitstatus);

}
#if 0
/**
  * @brief Checks whether the specified CLK interrupt has is enabled or not.
  * @param[in] CLK_IT specifies the CLK interrupt.
  * can be one of the values of @ref CLK_IT_TypeDef
  * @retval ITStatus, new state of CLK_IT (SET or RESET).
  */

/**
  * @brief Clears the CLK’s interrupt pending bits.
  * @param[in] CLK_IT specifies the interrupt pending bits.
  * can be one of the values of @ref CLK_IT_TypeDef
  * @retval None
  */
void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
{

    /* check the parameters */
    assert_param(IS_CLK_IT_OK(CLK_IT));

    if (CLK_IT == (u8)CLK_IT_CSSD)
    {
        /* Clear the status of the security system detection interrupt */
        CLK->CSSR &= (u8)(~CLK_CSSR_CSSD);
    }
    else /* CLK_PendingBit == (u8)CLK_IT_SWIF */
    {
        /* Clear the status of the clock switch interrupt */
        CLK->SWCR &= (u8)(~CLK_SWCR_SWIF);
    }

}

#endif
void CLK_CCOCmd(FunctionalState NewState)
{

    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    if (NewState != DISABLE)
    {
        /* Set CCOEN bit */
        CLK->CCOR |= CLK_CCOR_CCOEN;
    }
    else
    {
        /* Reset CCOEN bit */
        CLK->CCOR &= (u8)(~CLK_CCOR_CCOEN);
    }

}


void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
{

    /* check the parameters */
    assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));

    /* Clears of the CCO type bits part */
    CLK->CCOR &= (u8)(~CLK_CCOR_CCOSEL);

    /* Selects the source provided on cco_ck output */
    CLK->CCOR |= (u8)CLK_CCO;

    /* Enable the clock output */
    CLK->CCOR |= CLK_CCOR_CCOEN;

}

CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
{
    return((CLK_Source_TypeDef)CLK->CMSR);
}


ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
{

    CLK_Source_TypeDef clock_master;
    u16 DownCounter = CLK_TIMEOUT;
    ErrorStatus Swif = ERROR;

    /* Check the parameters */
    assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
    assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
    assert_param(IS_FUNCTIONALSTATE_OK(ITState));
    assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));

    /* Current clock master saving */
    clock_master = (CLK_Source_TypeDef)CLK->CMSR;

    /* Automatic switch mode management */
    if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
    {

        /* Enables Clock switch */
        CLK->SWCR |= CLK_SWCR_SWEN;

        /* Enables or Disables Switch interrupt */
        if (ITState != DISABLE)
        {
            CLK->SWCR |= CLK_SWCR_SWIEN;
        }
        else
        {
            CLK->SWCR &= (u8)(~CLK_SWCR_SWIEN);
        }

        /* Selection of the target clock source */
        CLK->SWR = (u8)CLK_NewClock;

        while (((CLK->SWCR & CLK_SWCR_SWBSY) && (DownCounter != 0)))
        {
            DownCounter--;
        }

        if (DownCounter != 0)
        {
            Swif = SUCCESS;
        }
        else
        {
            Swif = ERROR;
        }

    }
    else /* CLK_SwitchMode == CLK_SWITCHMODE_MANUAL */
    {

        /* Enables or Disables Switch interrupt  if required  */
        if (ITState != DISABLE)
        {
            CLK->SWCR |= CLK_SWCR_SWIEN;
        }
        else
        {
            CLK->SWCR &= (u8)(~CLK_SWCR_SWIEN);
        }

        /* Selection of the target clock source */
        CLK->SWR = (u8)CLK_NewClock;

        /* In manual mode, there is no risk to be stucked in a loop, value returned
          is then always SUCCESS */
        Swif = SUCCESS;

    }

    /* Switch OFF current clock if required */
    if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
    {
        CLK->ICKR &= (u8)(~CLK_ICKR_HSIEN);
    }
    else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
    {
        CLK->ICKR &= (u8)(~CLK_ICKR_LSIEN);
    }
    else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
    {
        CLK->ECKR &= (u8)(~CLK_ECKR_HSEEN);
    }

    return(Swif);

}
/**
  * @}
  */

/******************* (C) COPYRIGHT 2009 STMicroelectronics *****END OF FILE****/
