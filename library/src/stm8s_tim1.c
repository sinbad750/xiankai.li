/**
  ******************************************************************************
  * @file stm8s_tim1.c
  * @brief This file contains all the functions for the TIM1 peripheral.
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
#include "stm8s_tim1.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
static void TI1_Config(u8 TIM1_ICPolarity, u8 TIM1_ICSelection,
                       u8 TIM1_ICFilter);
static void TI2_Config(u8 TIM1_ICPolarity, u8 TIM1_ICSelection,
                       u8 TIM1_ICFilter);
static void TI3_Config(u8 TIM1_ICPolarity, u8 TIM1_ICSelection,
                       u8 TIM1_ICFilter);
static void TI4_Config(u8 TIM1_ICPolarity, u8 TIM1_ICSelection,
                       u8 TIM1_ICFilter);

/**
  * @addtogroup TIM1_Public_Functions
  * @{
  */

/**
  * @brief Deinitializes the TIM1 peripheral registers to their default reset values.
  * @par Parameters:
  * None
  * @retval None
  */
void TIM1_DeInit(void)
{
    TIM1->CR1  = TIM1_CR1_RESET_VALUE;
    TIM1->CR2  = TIM1_CR2_RESET_VALUE;
    TIM1->SMCR = TIM1_SMCR_RESET_VALUE;
    TIM1->ETR  = TIM1_ETR_RESET_VALUE;
    TIM1->IER  = TIM1_IER_RESET_VALUE;
    TIM1->SR2  = TIM1_SR2_RESET_VALUE;
    /* Disable channels */
    TIM1->CCER1 = TIM1_CCER1_RESET_VALUE;
    TIM1->CCER2 = TIM1_CCER2_RESET_VALUE;
    /* Configure channels as inputs: it is necessary if lock level is equal to 2 or 3 */
    TIM1->CCMR1 = 0x01;
    TIM1->CCMR2 = 0x01;
    TIM1->CCMR3 = 0x01;
    TIM1->CCMR4 = 0x01;
    /* Then reset channel registers: it also works if lock level is equal to 2 or 3 */
    TIM1->CCER1 = TIM1_CCER1_RESET_VALUE;
    TIM1->CCER2 = TIM1_CCER2_RESET_VALUE;
    TIM1->CCMR1 = TIM1_CCMR1_RESET_VALUE;
    TIM1->CCMR2 = TIM1_CCMR2_RESET_VALUE;
    TIM1->CCMR3 = TIM1_CCMR3_RESET_VALUE;
    TIM1->CCMR4 = TIM1_CCMR4_RESET_VALUE;
    TIM1->CNTRH = TIM1_CNTRH_RESET_VALUE;
    TIM1->CNTRL = TIM1_CNTRL_RESET_VALUE;
    TIM1->PSCRH = TIM1_PSCRH_RESET_VALUE;
    TIM1->PSCRL = TIM1_PSCRL_RESET_VALUE;
    TIM1->ARRH  = TIM1_ARRH_RESET_VALUE;
    TIM1->ARRL  = TIM1_ARRL_RESET_VALUE;
    TIM1->CCR1H = TIM1_CCR1H_RESET_VALUE;
    TIM1->CCR1L = TIM1_CCR1L_RESET_VALUE;
    TIM1->CCR2H = TIM1_CCR2H_RESET_VALUE;
    TIM1->CCR2L = TIM1_CCR2L_RESET_VALUE;
    TIM1->CCR3H = TIM1_CCR3H_RESET_VALUE;
    TIM1->CCR3L = TIM1_CCR3L_RESET_VALUE;
    TIM1->CCR4H = TIM1_CCR4H_RESET_VALUE;
    TIM1->CCR4L = TIM1_CCR4L_RESET_VALUE;
    TIM1->OISR  = TIM1_OISR_RESET_VALUE;
    TIM1->EGR   = 0x01; /* TIM1_EGR_UG */
    TIM1->DTR   = TIM1_DTR_RESET_VALUE;
    TIM1->BKR   = TIM1_BKR_RESET_VALUE;
    TIM1->RCR   = TIM1_RCR_RESET_VALUE;
    TIM1->SR1   = TIM1_SR1_RESET_VALUE;
}

/**
  * @brief Initializes the TIM1 Time Base Unit according to the specified parameters.
  * @param[in]  TIM1_Prescaler specifies the Prescaler value.
  * @param[in]  TIM1_CounterMode specifies the counter mode  from @ref TIM1_CounterMode_TypeDef .
  * @param[in]  TIM1_Period specifies the Period value.
  * @param[in]  TIM1_RepetitionCounter specifies the Repetition counter value
  * @retval None
  */
void TIM1_TimeBaseInit(u16 TIM1_Prescaler,
                       TIM1_CounterMode_TypeDef TIM1_CounterMode,
                       u16 TIM1_Period,
                       u8 TIM1_RepetitionCounter)
{

    /* Check parameters */
    assert_param(IS_TIM1_COUNTER_MODE_OK(TIM1_CounterMode));

    /* Set the Autoreload value */
    TIM1->ARRH = (u8)(TIM1_Period >> 8);
    TIM1->ARRL = (u8)(TIM1_Period);

    /* Set the Prescaler value */
    TIM1->PSCRH = (u8)(TIM1_Prescaler >> 8);
    TIM1->PSCRL = (u8)(TIM1_Prescaler);

    /* Select the Counter Mode */
    TIM1->CR1 = (u8)(((TIM1->CR1) & (u8)(~(TIM1_CR1_CMS | TIM1_CR1_DIR))) | (u8)(TIM1_CounterMode));

    /* Set the Repetition Counter value */
    TIM1->RCR = TIM1_RepetitionCounter;

}

/**
  * @brief Initializes the TIM1 Channel1 according to the specified parameters.
  * @param[in] TIM1_OCMode specifies the Output Compare mode from @ref TIM1_OCMode_TypeDef.
  * @param[in] TIM1_OutputState specifies the Output State from @ref TIM1_OutputState_TypeDef.
  * @param[in] TIM1_OutputNState specifies the Complementary Output State from @ref TIM1_OutputNState_TypeDef.
  * @param[in] TIM1_Pulse specifies the Pulse width value.
  * @param[in] TIM1_OCPolarity specifies the Output Compare Polarity from @ref TIM1_OCPolarity_TypeDef.
  * @param[in] TIM1_OCNPolarity specifies the Complementary Output Compare Polarity from @ref TIM1_OCNPolarity_TypeDef.
  * @param[in] TIM1_OCIdleState specifies the Output Compare Idle State from @ref TIM1_OCIdleState_TypeDef.
  * @param[in] TIM1_OCNIdleState specifies the Complementary Output Compare Idle State from @ref TIM1_OCIdleState_TypeDef.
  * @retval None
  */
void TIM1_OC1Init(TIM1_OCMode_TypeDef TIM1_OCMode,
                  TIM1_OutputState_TypeDef TIM1_OutputState,
                  TIM1_OutputNState_TypeDef TIM1_OutputNState,
                  u16 TIM1_Pulse,
                  TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
                  TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity,
                  TIM1_OCIdleState_TypeDef TIM1_OCIdleState,
                  TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState)
{
    /* Check the parameters */
    assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
    assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
    assert_param(IS_TIM1_OUTPUTN_STATE_OK(TIM1_OutputNState));
    assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
    assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
    assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
    assert_param(IS_TIM1_OCNIDLE_STATE_OK(TIM1_OCNIdleState));

    /* Disable the Channel 1: Reset the CCE Bit, Set the Output State , the Output N State, the Output Polarity & the Output N Polarity*/
    TIM1->CCER1 &= (u8)(~( TIM1_CCER1_CC1E | TIM1_CCER1_CC1NE | TIM1_CCER1_CC1P | TIM1_CCER1_CC1NP));
    /* Set the Output State & Set the Output N State & Set the Output Polarity & Set the Output N Polarity */
    TIM1->CCER1 |= (u8)((TIM1_OutputState & TIM1_CCER1_CC1E  ) | (TIM1_OutputNState & TIM1_CCER1_CC1NE ) | (TIM1_OCPolarity  & TIM1_CCER1_CC1P  ) | (TIM1_OCNPolarity & TIM1_CCER1_CC1NP ));

    /* Reset the Output Compare Bits & Set the Ouput Compare Mode */
    TIM1->CCMR1 = (u8)((TIM1->CCMR1 & (u8)(~TIM1_CCMR_OCM)) | (u8)TIM1_OCMode);

    /* Reset the Output Idle state & the Output N Idle state bits */
    TIM1->OISR &= (u8)(~(TIM1_OISR_OIS1 | TIM1_OISR_OIS1N));
    /* Set the Output Idle state & the Output N Idle state configuration */
    TIM1->OISR |= (u8)(( TIM1_OCIdleState & TIM1_OISR_OIS1 ) | ( TIM1_OCNIdleState & TIM1_OISR_OIS1N ));

    /* Set the Pulse value */
    TIM1->CCR1H = (u8)(TIM1_Pulse >> 8);
    TIM1->CCR1L = (u8)(TIM1_Pulse);
}





/**
  * @brief Initializes the TIM1 Channel4 according to the specified parameters.
  * @param[in] TIM1_OCMode specifies the Output Compare mode  from @ref TIM1_OCMode_TypeDef.
  * @param[in] TIM1_OutputState specifies the Output State  from @ref TIM1_OutputState_TypeDef.
  * @param[in] TIM1_Pulse specifies the Pulse width  value.
  * @param[in] TIM1_OCPolarity specifies the Output Compare Polarity  from @ref TIM1_OCPolarity_TypeDef.
  * @param[in] TIM1_OCIdleState specifies the Output Compare Idle State  from @ref TIM1_OCIdleState_TypeDef.
  * @retval None
  */
void TIM1_OC4Init(TIM1_OCMode_TypeDef TIM1_OCMode,
                  TIM1_OutputState_TypeDef TIM1_OutputState,
                  u16 TIM1_Pulse,
                  TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
                  TIM1_OCIdleState_TypeDef TIM1_OCIdleState)
{

    /* Check the parameters */
    assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
    assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
    assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
    assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));



    /* Disable the Channel 4: Reset the CCE Bit */
    TIM1->CCER2 &= (u8)(~(TIM1_CCER2_CC4E | TIM1_CCER2_CC4P));
    /* Set the Output State  &  the Output Polarity */
    TIM1->CCER2 |= (u8)((TIM1_OutputState & TIM1_CCER2_CC4E ) |  (TIM1_OCPolarity  & TIM1_CCER2_CC4P ));

    /* Reset the Output Compare Bit  and Set the Ouput Compare Mode */
    TIM1->CCMR4 = (u8)((TIM1->CCMR4 & (u8)(~TIM1_CCMR_OCM)) | (TIM1_OCMode));

    /* Set the Output Idle state */
    if (TIM1_OCIdleState != TIM1_OCIDLESTATE_RESET)
    {
        TIM1->OISR |= (u8)(~TIM1_CCER2_CC4P);
    }
    else
    {
        TIM1->OISR &= (u8)(~TIM1_OISR_OIS4);
    }

    /* Set the Pulse value */
    TIM1->CCR4H = (u8)(TIM1_Pulse >> 8);
    TIM1->CCR4L = (u8)(TIM1_Pulse);

}





/**
  * @brief Configures the TIM1 peripheral in PWM Input Mode according to the specified parameters.
  * @param[in]  TIM1_Channel specifies the input capture channel from TIM1_Channel_TypeDef.
  * @param[in]  TIM1_ICPolarity specifies the Input capture polarity from  TIM1_ICPolarity_TypeDef .
  * @param[in] TIM1_ICSelection specifies the Input capture source selection  from  TIM1_ICSelection_TypeDef.
  * @param[in] TIM1_ICPrescaler specifies the Input capture Prescaler from  TIM1_ICPSC_TypeDef.
  * @param[in] TIM1_ICFilter specifies the Input capture filter value.
  * @retval None
  */
void TIM1_PWMIConfig(TIM1_Channel_TypeDef TIM1_Channel,
                     TIM1_ICPolarity_TypeDef TIM1_ICPolarity,
                     TIM1_ICSelection_TypeDef TIM1_ICSelection,
                     TIM1_ICPSC_TypeDef TIM1_ICPrescaler,
                     u8 TIM1_ICFilter)
{
    u8 icpolarity = TIM1_ICPOLARITY_RISING;
    u8 icselection = TIM1_ICSELECTION_DIRECTTI;

    /* Check the parameters */
    assert_param(IS_TIM1_PWMI_CHANNEL_OK(TIM1_Channel));
    assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_ICPolarity));
    assert_param(IS_TIM1_IC_SELECTION_OK(TIM1_ICSelection));
    assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_ICPrescaler));

    /* Select the Opposite Input Polarity */
    if (TIM1_ICPolarity != TIM1_ICPOLARITY_FALLING)
    {
        icpolarity = TIM1_ICPOLARITY_FALLING;
    }
    else
    {
        icpolarity = TIM1_ICPOLARITY_RISING;
    }

    /* Select the Opposite Input */
    if (TIM1_ICSelection == TIM1_ICSELECTION_DIRECTTI)
    {
        icselection = TIM1_ICSELECTION_INDIRECTTI;
    }
    else
    {
        icselection = TIM1_ICSELECTION_DIRECTTI;
    }

    if (TIM1_Channel == TIM1_CHANNEL_1)
    {
        /* TI1 Configuration */
        TI1_Config((u8)TIM1_ICPolarity, (u8)TIM1_ICSelection,
                   (u8)TIM1_ICFilter);

        /* Set the Input Capture Prescaler value */
        TIM1_SetIC1Prescaler(TIM1_ICPrescaler);

        /* TI2 Configuration */
        TI2_Config(icpolarity, icselection, TIM1_ICFilter);

        /* Set the Input Capture Prescaler value */
        TIM1_SetIC2Prescaler(TIM1_ICPrescaler);
    }
    else
    {
        /* TI2 Configuration */
        TI2_Config((u8)TIM1_ICPolarity, (u8)TIM1_ICSelection,
                   (u8)TIM1_ICFilter);

        /* Set the Input Capture Prescaler value */
        TIM1_SetIC2Prescaler(TIM1_ICPrescaler);

        /* TI1 Configuration */
        TI1_Config(icpolarity, icselection, TIM1_ICFilter);

        /* Set the Input Capture Prescaler value */
        TIM1_SetIC1Prescaler(TIM1_ICPrescaler);
    }
}


/**
  * @brief Enables or disables the TIM1 peripheral.
  * @param[in] NewState new state of the TIM1 peripheral.
	* This parameter can be ENABLE or DISABLE.
  * @retval None
  */
void TIM1_Cmd(FunctionalState NewState)
{
    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    /* set or Reset the CEN Bit */
    if (NewState != DISABLE)
    {
        TIM1->CR1 |= TIM1_CR1_CEN;
    }
    else
    {
        TIM1->CR1 &= (u8)(~TIM1_CR1_CEN);
    }
}


/**
  * @brief Enables or disables the TIM1 peripheral Main Outputs.
  * @param[in] NewState new state of the TIM1 peripheral.
	* This parameter can be ENABLE or DISABLE.
  * @retval None
  */
void TIM1_CtrlPWMOutputs(FunctionalState NewState)
{
    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    /* Set or Reset the MOE Bit */

    if (NewState != DISABLE)
    {
        TIM1->BKR |= TIM1_BKR_MOE;
    }
    else
    {
        TIM1->BKR &= (u8)(~TIM1_BKR_MOE);
    }
}





void TIM1_PrescalerConfig(u16 Prescaler,
                          TIM1_PSCReloadMode_TypeDef TIM1_PSCReloadMode)
{
    /* Check the parameters */
    assert_param(IS_TIM1_PRESCALER_RELOAD_OK(TIM1_PSCReloadMode));

    /* Set the Prescaler value */
    TIM1->PSCRH = (u8)(Prescaler >> 8);
    TIM1->PSCRL = (u8)(Prescaler);

    /* Set or reset the UG Bit */
    TIM1->EGR = (u8)TIM1_PSCReloadMode;

}





void TIM1_SetIC1Prescaler(TIM1_ICPSC_TypeDef TIM1_IC1Prescaler)
{
    /* Check the parameters */
    assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC1Prescaler));

    /* Reset the IC1PSC Bits */ /* Set the IC1PSC value */
    TIM1->CCMR1 = (u8)((TIM1->CCMR1 & (u8)(~TIM1_CCMR_ICxPSC)) | (u8)TIM1_IC1Prescaler);

}

/**
  * @brief Sets the TIM1 Input Capture 2 prescaler.
  * @param[in] TIM1_IC2Prescaler specifies the Input Capture prescaler new value
  * This parameter can be one of the following values:
  *                       - TIM1_ICPSC_DIV1: no prescaler
  *                       - TIM1_ICPSC_DIV2: capture is done once every 2 events
  *                       - TIM1_ICPSC_DIV4: capture is done once every 4 events
  *                       - TIM1_ICPSC_DIV8: capture is done once every 8 events
  * @retval None
  */
void TIM1_SetIC2Prescaler(TIM1_ICPSC_TypeDef TIM1_IC2Prescaler)
{

    /* Check the parameters */
    assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC2Prescaler));

    /* Reset the IC1PSC Bits */ /* Set the IC1PSC value */
    TIM1->CCMR2 = (u8)((TIM1->CCMR2 & (u8)(~TIM1_CCMR_ICxPSC)) | (u8)TIM1_IC2Prescaler);
}


/**
  * @brief Sets the TIM1 Input Capture 3 prescaler.
  * @param[in] TIM1_IC3Prescaler specifies the Input Capture prescaler new value
  * This parameter can be one of the following values:
  *                       - TIM1_ICPSC_DIV1: no prescaler
  *                       - TIM1_ICPSC_DIV2: capture is done once every 2 events
  *                       - TIM1_ICPSC_DIV4: capture is done once every 4 events
  *                       - TIM1_ICPSC_DIV8: capture is done once every 8 events
  * @retval None
  */
void TIM1_SetIC3Prescaler(TIM1_ICPSC_TypeDef TIM1_IC3Prescaler)
{

    /* Check the parameters */
    assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC3Prescaler));

    /* Reset the IC1PSC Bits & Set the IC1PSC value */
    TIM1->CCMR3 = (u8)((TIM1->CCMR3 & (u8)(~TIM1_CCMR_ICxPSC)) | (u8)TIM1_IC3Prescaler);
}


/**
  * @brief Sets the TIM1 Input Capture 4 prescaler.
  * @param[in] TIM1_IC4Prescaler specifies the Input Capture prescaler new value
  * This parameter can be one of the following values:
  *                       - TIM1_ICPSC_DIV1: no prescaler
  *                       - TIM1_ICPSC_DIV2: capture is done once every 2 events
  *                       - TIM1_ICPSC_DIV4: capture is done once every 4 events
  *                       - TIM1_ICPSC_DIV8: capture is done once every 8 events
  * @retval None
  */
void TIM1_SetIC4Prescaler(TIM1_ICPSC_TypeDef TIM1_IC4Prescaler)
{

    /* Check the parameters */
    assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC4Prescaler));

    /* Reset the IC1PSC Bits &  Set the IC1PSC value */
    TIM1->CCMR4 = (u8)((TIM1->CCMR4 & (u8)(~TIM1_CCMR_ICxPSC)) | (u8)TIM1_IC4Prescaler);
}


/**
  * @brief Gets the TIM1 Input Capture 1 value.
  * @param[in] :
  * None
  * @retval Capture Compare 1 Register value.
  */
u16 TIM1_GetCapture1(void)
{
    /* Get the Capture 1 Register value */

    u16 tmpccr1 = 0;
    u8 tmpccr1l=0, tmpccr1h=0;

    tmpccr1h = TIM1->CCR1H;
    tmpccr1l = TIM1->CCR1L;

    tmpccr1 = (u16)(tmpccr1l);
    tmpccr1 |= (u16)((u16)tmpccr1h << 8);
    /* Get the Capture 1 Register value */
    return (u16)tmpccr1;
}




/**
  * @brief Gets the TIM1 Counter value.
  * @param[in] :
  * None
  * @retval Counter Register value.
  */
u16 TIM1_GetCounter(void)
{
    /* Get the Counter Register value */
    return (u16)(((u16)TIM1->CNTRH << 8) | (u16)(TIM1->CNTRL));
}







ITStatus TIM1_GetITStatus(TIM1_IT_TypeDef TIM1_IT)
{
    volatile ITStatus bitstatus = RESET;
    vu8 TIM1_itStatus = 0, TIM1_itEnable = 0;

    /* Check the parameters */
    assert_param(IS_TIM1_GET_IT_OK(TIM1_IT));

    TIM1_itStatus = (u8)(TIM1->SR1 & (u8)TIM1_IT);

    TIM1_itEnable = (u8)(TIM1->IER & (u8)TIM1_IT);

    if ((TIM1_itStatus != (u8)RESET ) && (TIM1_itEnable != (u8)RESET ))
    {
        bitstatus = SET;
    }
    else
    {
        bitstatus = RESET;
    }
    return (ITStatus)(bitstatus);
}


/**
  * @brief Clears the TIM1's interrupt pending bits.
  * @param[in] TIM1_IT specifies the pending bit to clear.
  * This parameter can be one of the following values:
  *                       - TIM1_IT_UPDATE: TIM1 update Interrupt source
  *                       - TIM1_IT_CC1: TIM1 Capture Compare 1 Interrupt source
  *                       - TIM1_IT_CC2: TIM1 Capture Compare 2 Interrupt source
  *                       - TIM1_IT_CC3: TIM1 Capture Compare 3 Interrupt source
  *                       - TIM1_IT_CC4: TIM1 Capture Compare 4 Interrupt source
  *                       - TIM1_IT_COM: TIM1 Commutation Interrupt source
  *                       - TIM1_IT_TRIGGER: TIM1 Trigger Interrupt source
  *                       - TIM1_IT_BREAK: TIM1 Break Interrupt source
  * @retval None.
  */
void TIM1_ClearITPendingBit(TIM1_IT_TypeDef TIM1_IT)
{
    /* Check the parameters */
    assert_param(IS_TIM1_IT_OK(TIM1_IT));

    /* Clear the IT pending Bit */
   TIM1->SR1 = (u8)(~(u8)TIM1_IT);
   //TIM1->SR1 &= (u8)(~(u8)TIM1_IT);//modify zxq
}


/**
  * @brief Configure the TI1 as Input.
  * @param[in] TIM1_ICPolarity  The Input Polarity.
  * This parameter can be one of the following values:
  *                       - TIM1_ICPOLARITY_FALLING
  *                       - TIM1_ICPOLARITY_RISING
  * @param[in] TIM1_ICSelection specifies the input to be used.
  * This parameter can be one of the following values:
  *                       - TIM1_ICSELECTION_DIRECTTI: TIM1 Input 1 is selected to
  *                         be connected to IC1.
  *                       - TIM1_ICSELECTION_INDIRECTTI: TIM1 Input 1 is selected to
  *                         be connected to IC2.
  * @param[in] TIM1_ICFilter Specifies the Input Capture Filter.
  * This parameter must be a value between 0x00 and 0x0F.
  * @retval None
  */
static void TI1_Config(u8 TIM1_ICPolarity,
                       u8 TIM1_ICSelection,
                       u8 TIM1_ICFilter)
{

    /* Disable the Channel 1: Reset the CCE Bit */
    TIM1->CCER1 &= (u8)(~TIM1_CCER1_CC1E);

    /* Select the Input and set the filter */
    TIM1->CCMR1 = (u8)((TIM1->CCMR1 & (u8)(~( TIM1_CCMR_CCxS     |        TIM1_CCMR_ICxF    ))) | (u8)(( (TIM1_ICSelection)) | ((u8)( TIM1_ICFilter << 4))));



    /* Select the Polarity */
    if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
    {
        TIM1->CCER1 |= TIM1_CCER1_CC1P;
    }
    else
    {
        TIM1->CCER1 &= (u8)(~TIM1_CCER1_CC1P);
    }

    /* Set the CCE Bit */
    TIM1->CCER1 |=  TIM1_CCER1_CC1E;
}


/**
  * @brief Configure the TI2 as Input.
  * @param[in] TIM1_ICPolarity  The Input Polarity.
  * This parameter can be one of the following values:
  *                       - TIM1_ICPOLARITY_FALLING
  *                       - TIM1_ICPOLARITY_RISING
  * @param[in] TIM1_ICSelection specifies the input to be used.
  * This parameter can be one of the following values:
  *                       - TIM1_ICSELECTION_DIRECTTI: TIM1 Input 2 is selected to
  *                         be connected to IC2.
  *                       - TIM1_ICSELECTION_INDIRECTTI: TIM1 Input 2 is selected to
  *                         be connected to IC1.
  * @param[in] TIM1_ICFilter Specifies the Input Capture Filter.
  * This parameter must be a value between 0x00 and 0x0F.
  * @retval None
  */
static void TI2_Config(u8 TIM1_ICPolarity,
                       u8 TIM1_ICSelection,
                       u8 TIM1_ICFilter)
{
    /* Disable the Channel 2: Reset the CCE Bit */
    TIM1->CCER1 &=  (u8)(~TIM1_CCER1_CC2E);

    /* Select the Input and set the filter */
    TIM1->CCMR2  = (u8)((TIM1->CCMR2 & (u8)(~( TIM1_CCMR_CCxS     |        TIM1_CCMR_ICxF    ))) | (u8)(( (TIM1_ICSelection)) | ((u8)( TIM1_ICFilter << 4))));
    /* Select the Polarity */
    if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
    {
        TIM1->CCER1 |= TIM1_CCER1_CC2P;
    }
    else
    {
        TIM1->CCER1 &= (u8)(~TIM1_CCER1_CC2P);
    }
    /* Set the CCE Bit */
    TIM1->CCER1 |=  TIM1_CCER1_CC2E;
}

/**
  * @brief Configure the TI3 as Input.
  * @param[in] TIM1_ICPolarity  The Input Polarity.
  * This parameter can be one of the following values:
  *                       - TIM1_ICPOLARITY_FALLING
  *                       - TIM1_ICPOLARITY_RISING
  * @param[in] TIM1_ICSelection specifies the input to be used.
  * This parameter can be one of the following values:
  *                       - TIM1_ICSELECTION_DIRECTTI: TIM1 Input 3 is selected to
  *                         be connected to IC3.
  *                       - TIM1_ICSELECTION_INDIRECTTI: TIM1 Input 3 is selected to
  *                         be connected to IC4.
  * @param[in] TIM1_ICFilter Specifies the Input Capture Filter.
  * This parameter must be a value between 0x00 and 0x0F.
  * @retval None
  */
static void TI3_Config(u8 TIM1_ICPolarity,
                       u8 TIM1_ICSelection,
                       u8 TIM1_ICFilter)
{
    /* Disable the Channel 3: Reset the CCE Bit */
    TIM1->CCER2 &=  (u8)(~TIM1_CCER2_CC3E);

    /* Select the Input and set the filter */
    TIM1->CCMR3 = (u8)((TIM1->CCMR3 & (u8)(~( TIM1_CCMR_CCxS     |        TIM1_CCMR_ICxF    ))) | (u8)(( (TIM1_ICSelection)) | ((u8)( TIM1_ICFilter << 4))));

    /* Select the Polarity */
    if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
    {
        TIM1->CCER2 |= TIM1_CCER2_CC3P;
    }
    else
    {
        TIM1->CCER2 &= (u8)(~TIM1_CCER2_CC3P);
    }
    /* Set the CCE Bit */
    TIM1->CCER2 |=  TIM1_CCER2_CC3E;
}


/**
  * @brief Configure the TI4 as Input.
  * @param[in] TIM1_ICPolarity  The Input Polarity.
  * This parameter can be one of the following values:
  *                       - TIM1_ICPOLARITY_FALLING
  *                       - TIM1_ICPOLARITY_RISING
  * @param[in] TIM1_ICSelection specifies the input to be used.
  * This parameter can be one of the following values:
  *                       - TIM1_ICSELECTION_DIRECTTI: TIM1 Input 4 is selected to
  *                         be connected to IC4.
  *                       - TIM1_ICSELECTION_INDIRECTTI: TIM1 Input 4 is selected to
  *                         be connected to IC3.
  * @param[in] TIM1_ICFilter Specifies the Input Capture Filter.
  * This parameter must be a value between 0x00 and 0x0F.
  * @retval None
  */
static void TI4_Config(u8 TIM1_ICPolarity,
                       u8 TIM1_ICSelection,
                       u8 TIM1_ICFilter)
{

    /* Disable the Channel 4: Reset the CCE Bit */
    TIM1->CCER2 &=  (u8)(~TIM1_CCER2_CC4E);

    /* Select the Input and set the filter */
    TIM1->CCMR4 = (u8)((TIM1->CCMR4 & (u8)(~( TIM1_CCMR_CCxS     |        TIM1_CCMR_ICxF    )))  | (u8)(( (TIM1_ICSelection)) | ((u8)( TIM1_ICFilter << 4))));



    /* Select the Polarity */
    if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
    {
        TIM1->CCER2 |= TIM1_CCER2_CC4P;
    }
    else
    {
        TIM1->CCER2 &= (u8)(~TIM1_CCER2_CC4P);
    }

    /* Set the CCE Bit */
    TIM1->CCER2 |=  TIM1_CCER2_CC4E;
}


/**
  * @}
  */

/******************* (C) COPYRIGHT 2009 STMicroelectronics *****END OF FILE****/
