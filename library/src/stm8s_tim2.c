/**
  ******************************************************************************
  * @file stm8s_tim2.c
  * @brief This file contains all the functions for the TIM2 peripheral.
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
#include "stm8s_tim2.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
static void TI1_Config(u8 TIM2_ICPolarity, u8 TIM2_ICSelection, u8 TIM2_ICFilter);
static void TI2_Config(u8 TIM2_ICPolarity, u8 TIM2_ICSelection, u8 TIM2_ICFilter);
static void TI3_Config(u8 TIM2_ICPolarity, u8 TIM2_ICSelection, u8 TIM2_ICFilter);
/**
  * @addtogroup TIM2_Public_Functions
  * @{
  */

/**
  * @brief Deinitializes the TIM2 peripheral registers to their default reset values.
  * @param[in] :
  * None
  * @retval None
  */
void TIM2_DeInit(void)
{

    TIM2->CR1 = (u8)TIM2_CR1_RESET_VALUE;
    TIM2->IER = (u8)TIM2_IER_RESET_VALUE;
    TIM2->SR2 = (u8)TIM2_SR2_RESET_VALUE;

    /* Disable channels */
    TIM2->CCER1 = (u8)TIM2_CCER1_RESET_VALUE;
    TIM2->CCER2 = (u8)TIM2_CCER2_RESET_VALUE;


    /* Then reset channel registers: it also works if lock level is equal to 2 or 3 */
    TIM2->CCER1 = (u8)TIM2_CCER1_RESET_VALUE;
    TIM2->CCER2 = (u8)TIM2_CCER2_RESET_VALUE;
    TIM2->CCMR1 = (u8)TIM2_CCMR1_RESET_VALUE;
    TIM2->CCMR2 = (u8)TIM2_CCMR2_RESET_VALUE;
    TIM2->CCMR3 = (u8)TIM2_CCMR3_RESET_VALUE;
    TIM2->CNTRH = (u8)TIM2_CNTRH_RESET_VALUE;
    TIM2->CNTRL = (u8)TIM2_CNTRL_RESET_VALUE;
    TIM2->PSCR = (u8)TIM2_PSCR_RESET_VALUE;
    TIM2->ARRH  = (u8)TIM2_ARRH_RESET_VALUE;
    TIM2->ARRL  = (u8)TIM2_ARRL_RESET_VALUE;
    TIM2->CCR1H = (u8)TIM2_CCR1H_RESET_VALUE;
    TIM2->CCR1L = (u8)TIM2_CCR1L_RESET_VALUE;
    TIM2->CCR2H = (u8)TIM2_CCR2H_RESET_VALUE;
    TIM2->CCR2L = (u8)TIM2_CCR2L_RESET_VALUE;
    TIM2->CCR3H = (u8)TIM2_CCR3H_RESET_VALUE;
    TIM2->CCR3L = (u8)TIM2_CCR3L_RESET_VALUE;
    TIM2->SR1 = (u8)TIM2_SR1_RESET_VALUE;
}


/**
  * @brief Initializes the TIM2 Time Base Unit according to the specified parameters.
  * @param[in]  TIM2_Prescaler specifies the Prescaler from TIM2_Prescaler_TypeDef.
  * @param[in]  TIM2_Period specifies the Period value.
  * @retval None
  */
void TIM2_TimeBaseInit( TIM2_Prescaler_TypeDef TIM2_Prescaler,
                        u16 TIM2_Period)
{
    /* Set the Prescaler value */
    TIM2->PSCR = (u8)(TIM2_Prescaler);
    /* Set the Autoreload value */
    TIM2->ARRH = (u8)(TIM2_Period >> 8);
    TIM2->ARRL = (u8)(TIM2_Period);
}


/**
  * @brief Initializes the TIM2 Channel1 according to the specified parameters.
  * @param[in] TIM2_OCMode specifies the Output Compare mode  from @ref TIM2_OCMode_TypeDef.
  * @param[in] TIM2_OutputState specifies the Output State  from @ref TIM2_OutputState_TypeDef.
  * @param[in] TIM2_Pulse specifies the Pulse width  value.
  * @param[in] TIM2_OCPolarity specifies the Output Compare Polarity  from @ref TIM2_OCPolarity_TypeDef.
  * @retval None
  */
void TIM2_OC1Init(TIM2_OCMode_TypeDef TIM2_OCMode,
                  TIM2_OutputState_TypeDef TIM2_OutputState,
                  u16 TIM2_Pulse,
                  TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
{
    /* Check the parameters */
    assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
    assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
    assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));

    /* Disable the Channel 1: Reset the CCE Bit, Set the Output State , the Output Polarity */
    TIM2->CCER1 &= (u8)(~( TIM2_CCER1_CC1E | TIM2_CCER1_CC1P));
    /* Set the Output State &  Set the Output Polarity  */
    TIM2->CCER1 |= (u8)((TIM2_OutputState  & TIM2_CCER1_CC1E   ) | (TIM2_OCPolarity   & TIM2_CCER1_CC1P   ));

    /* Reset the Output Compare Bits  & Set the Ouput Compare Mode */
    TIM2->CCMR1 = (u8)((TIM2->CCMR1 & (u8)(~TIM2_CCMR_OCM)) | (u8)TIM2_OCMode);

    /* Set the Pulse value */
    TIM2->CCR1H = (u8)(TIM2_Pulse >> 8);
    TIM2->CCR1L = (u8)(TIM2_Pulse);
}



/**
  * @brief Initializes the TIM2 peripheral according to the specified parameters.
  * @param[in]  TIM2_Channel specifies the Input Capture Channel from @ref TIM2_Channel_TypeDef.
  * @param[in] TIM2_ICPolarity specifies the Input Capture Polarity from @ref TIM2_ICPolarity_TypeDef.
  * @param[in] TIM2_ICSelection specifies the Input Capture Selection from @ref TIM2_ICSelection_TypeDef.
  * @param[in] TIM2_ICPrescaler specifies the Input Capture Prescaler from @ref TIM2_ICPSC_TypeDef.
  * @param[in] TIM2_ICFilter specifies the Input Capture Filter value (value can be an integer from 0x00 to 0x0F).
  * @retval None
  */
void TIM2_ICInit(TIM2_Channel_TypeDef TIM2_Channel,
                 TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
                 TIM2_ICSelection_TypeDef TIM2_ICSelection,
                 TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
                 u8 TIM2_ICFilter)
{
    /* Check the parameters */
    assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
    assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICPolarity));
    assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICSelection));
    assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICPrescaler));
    assert_param(IS_TIM2_IC_FILTER_OK(TIM2_ICFilter));

    if (TIM2_Channel == TIM2_CHANNEL_1)
    {
        /* TI1 Configuration */
        TI1_Config((u8)TIM2_ICPolarity,
                   (u8)TIM2_ICSelection,
                   (u8)TIM2_ICFilter);

        /* Set the Input Capture Prescaler value */
        TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
    }
    else if (TIM2_Channel == TIM2_CHANNEL_2)
    {
        /* TI2 Configuration */
        TI2_Config((u8)TIM2_ICPolarity,
                   (u8)TIM2_ICSelection,
                   (u8)TIM2_ICFilter);

        /* Set the Input Capture Prescaler value */
        TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
    }
    else
    {
        /* TI3 Configuration */
        TI3_Config((u8)TIM2_ICPolarity,
                   (u8)TIM2_ICSelection,
                   (u8)TIM2_ICFilter);

        /* Set the Input Capture Prescaler value */
        TIM2_SetIC3Prescaler(TIM2_ICPrescaler);
    }
}


void TIM2_Cmd(FunctionalState NewState)
{
    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    /* set or Reset the CEN Bit */
    if (NewState != DISABLE)
    {
        TIM2->CR1 |= (u8)TIM2_CR1_CEN;
    }
    else
    {
        TIM2->CR1 &= (u8)(~TIM2_CR1_CEN);
    }
}












void TIM2_ARRPreloadConfig(FunctionalState NewState)
{
    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    /* Set or Reset the ARPE Bit */
    if (NewState != DISABLE)
    {
        TIM2->CR1 |= (u8)TIM2_CR1_ARPE;
    }
    else
    {
        TIM2->CR1 &= (u8)(~TIM2_CR1_ARPE);
    }
}


/**
  * @brief Enables or disables the TIM2 peripheral Preload Register on CCR1.
  * @param[in] NewState new state of the Capture Compare Preload register.
  * This parameter can be ENABLE or DISABLE.
  * @retval None
  */
void TIM2_OC1PreloadConfig(FunctionalState NewState)
{
    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    /* Set or Reset the OC1PE Bit */
    if (NewState != DISABLE)
    {
        TIM2->CCMR1 |= (u8)TIM2_CCMR_OCxPE;
    }
    else
    {
        TIM2->CCMR1 &= (u8)(~TIM2_CCMR_OCxPE);
    }
}


/**
  * @brief Enables or disables the TIM2 peripheral Preload Register on CCR2.
  * @param[in] NewState new state of the Capture Compare Preload register.
  * This parameter can be ENABLE or DISABLE.
  * @retval None
  */
void TIM2_OC2PreloadConfig(FunctionalState NewState)
{
    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    /* Set or Reset the OC2PE Bit */
    if (NewState != DISABLE)
    {
        TIM2->CCMR2 |= (u8)TIM2_CCMR_OCxPE;
    }
    else
    {
        TIM2->CCMR2 &= (u8)(~TIM2_CCMR_OCxPE);
    }
}





void TIM2_SetIC1Prescaler(TIM2_ICPSC_TypeDef TIM2_IC1Prescaler)
{
    /* Check the parameters */
    assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC1Prescaler));

    /* Reset the IC1PSC Bits &Set the IC1PSC value */
    TIM2->CCMR1 = (u8)((TIM2->CCMR1 & (u8)(~TIM2_CCMR_ICxPSC)) | (u8)TIM2_IC1Prescaler);
}

/**
  * @brief Sets the TIM2 Input Capture 2 prescaler.
  * @param[in] TIM2_IC2Prescaler specifies the Input Capture prescaler new value
  * This parameter can be one of the following values:
  *                       - TIM2_ICPSC_DIV1: no prescaler
  *                       - TIM2_ICPSC_DIV2: capture is done once every 2 events
  *                       - TIM2_ICPSC_DIV4: capture is done once every 4 events
  *                       - TIM2_ICPSC_DIV8: capture is done once every 8 events
  * @retval None
  */
void TIM2_SetIC2Prescaler(TIM2_ICPSC_TypeDef TIM2_IC2Prescaler)
{
    /* Check the parameters */
    assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC2Prescaler));

    /* Reset the IC1PSC Bits &Set the IC1PSC value */
    TIM2->CCMR2 = (u8)((TIM2->CCMR2 & (u8)(~TIM2_CCMR_ICxPSC)) | (u8)TIM2_IC2Prescaler);
}

/**
  * @brief Sets the TIM2 Input Capture 3 prescaler.
  * @param[in] TIM2_IC3Prescaler specifies the Input Capture prescaler new value
  * This parameter can be one of the following values:
  *                       - TIM2_ICPSC_DIV1: no prescaler
  *                       - TIM2_ICPSC_DIV2: capture is done once every 2 events
  *                       - TIM2_ICPSC_DIV4: capture is done once every 4 events
  *                       - TIM2_ICPSC_DIV8: capture is done once every 8 events
  * @retval None
  */
void TIM2_SetIC3Prescaler(TIM2_ICPSC_TypeDef TIM2_IC3Prescaler)
{

    /* Check the parameters */
    assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC3Prescaler));
    /* Reset the IC1PSC Bits &Set the IC1PSC value */
    TIM2->CCMR3 = (u8)((TIM2->CCMR3 & (u8)(~TIM2_CCMR_ICxPSC)) | (u8)TIM2_IC3Prescaler);
}



static void TI1_Config(u8 TIM2_ICPolarity,
                       u8 TIM2_ICSelection,
                       u8 TIM2_ICFilter)
{
    /* Disable the Channel 1: Reset the CCE Bit */
    TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC1E);

    /* Select the Input and set the filter */
    TIM2->CCMR1  = (u8)((TIM2->CCMR1 & (u8)(~( TIM2_CCMR_CCxS     |        TIM2_CCMR_ICxF    ))) | (u8)(( (TIM2_ICSelection)) | ((u8)( TIM2_ICFilter << 4))));

    /* Select the Polarity */
    if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
    {
        TIM2->CCER1 |= TIM2_CCER1_CC1P;
    }
    else
    {
        TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC1P);
    }
    /* Set the CCE Bit */
    TIM2->CCER1 |= TIM2_CCER1_CC1E;
}


/**
  * @brief Configure the TI2 as Input.
  * @param[in] TIM2_ICPolarity  The Input Polarity.
  * This parameter can be one of the following values:
  *                       - TIM2_ICPOLARITY_FALLING
  *                       - TIM2_ICPOLARITY_RISING
  * @param[in] TIM2_ICSelection specifies the input to be used.
  * This parameter can be one of the following values:
  *                       - TIM2_ICSELECTION_DIRECTTI: TIM2 Input 2 is selected to
  *                         be connected to IC2.
  *                       - TIM2_ICSELECTION_INDIRECTTI: TIM2 Input 2 is selected to
  *                         be connected to IC1.
  * @param[in] TIM2_ICFilter Specifies the Input Capture Filter.
  * This parameter must be a value between 0x00 and 0x0F.
  * @retval None
  */
static void TI2_Config(u8 TIM2_ICPolarity,
                       u8 TIM2_ICSelection,
                       u8 TIM2_ICFilter)
{
    /* Disable the Channel 2: Reset the CCE Bit */
    TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC2E);

    /* Select the Input and set the filter */
    TIM2->CCMR2 = (u8)((TIM2->CCMR2 & (u8)(~( TIM2_CCMR_CCxS     |        TIM2_CCMR_ICxF    ))) | (u8)(( (TIM2_ICSelection)) | ((u8)( TIM2_ICFilter << 4))));


    /* Select the Polarity */
    if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
    {
        TIM2->CCER1 |= TIM2_CCER1_CC2P;
    }
    else
    {
        TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC2P);
    }

    /* Set the CCE Bit */
    TIM2->CCER1 |= TIM2_CCER1_CC2E;

}

/**
  * @brief Configure the TI3 as Input.
  * @param[in] TIM2_ICPolarity  The Input Polarity.
  * This parameter can be one of the following values:
  *                       - TIM2_ICPOLARITY_FALLING
  *                       - TIM2_ICPOLARITY_RISING
  * @param[in] TIM2_ICSelection specifies the input to be used.
  * This parameter can be one of the following values:
  *                       - TIM2_ICSELECTION_DIRECTTI: TIM2 Input 3 is selected to
  *                         be connected to IC3.
  * @param[in] TIM2_ICFilter Specifies the Input Capture Filter.
  * This parameter must be a value between 0x00 and 0x0F.
  * @retval None
  */
static void TI3_Config(u8 TIM2_ICPolarity, u8 TIM2_ICSelection,
                       u8 TIM2_ICFilter)
{
    /* Disable the Channel 3: Reset the CCE Bit */
    TIM2->CCER2 &=  (u8)(~TIM2_CCER2_CC3E);

    /* Select the Input and set the filter */
    TIM2->CCMR3 = (u8)((TIM2->CCMR3 & (u8)(~( TIM2_CCMR_CCxS     |        TIM2_CCMR_ICxF    ))) | (u8)(( (TIM2_ICSelection)) | ((u8)( TIM2_ICFilter << 4))));


    /* Select the Polarity */
    if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
    {
        TIM2->CCER2 |= TIM2_CCER2_CC3P;
    }
    else
    {
        TIM2->CCER2 &= (u8)(~TIM2_CCER2_CC3P);
    }
    /* Set the CCE Bit */
    TIM2->CCER2 |= TIM2_CCER2_CC3E;
}
/**
  * @}
  */
/******************* (C) COPYRIGHT 2009 STMicroelectronics *****END OF FILE****/
