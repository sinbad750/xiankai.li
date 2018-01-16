/**
  ******************************************************************************
  * @file stm8s_adc1.c
  * @brief This file contains all the functions/macros for the ADC1 peripheral.
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
#include "stm8s_adc1.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/* Public functions ----------------------------------------------------------*/

/**
  * @addtogroup ADC1_Public_Functions
  * @{
  */

/**
  * @brief Deinitializes the ADC1 peripheral registers to their default reset
  * values.
  * @par Parameters:
  * None
  * @retval None
  */

#if 0
void ADC1_DeInit(void)
{
    ADC1->CSR  = ADC1_CSR_RESET_VALUE;
    ADC1->CR1  = ADC1_CR1_RESET_VALUE;
    ADC1->CR2  = ADC1_CR2_RESET_VALUE;
    ADC1->CR3  = ADC1_CR3_RESET_VALUE;
    ADC1->TDRH = ADC1_TDRH_RESET_VALUE;
    ADC1->TDRL = ADC1_TDRL_RESET_VALUE;
    ADC1->HTRH = ADC1_HTRH_RESET_VALUE;
    ADC1->HTRL = ADC1_HTRL_RESET_VALUE;
    ADC1->LTRH = ADC1_LTRH_RESET_VALUE;
    ADC1->LTRL = ADC1_LTRL_RESET_VALUE;
    ADC1->AWCRH = ADC1_AWCRH_RESET_VALUE;
    ADC1->AWCRL = ADC1_AWCRL_RESET_VALUE;
}
#endif

/**
  * @brief Initializes the ADC1 peripheral according to the specified parameters
  * @param[in] ADC1_ConversionMode: specifies the conversion mode
  * can be one of the values of @ref ADC1_ConvMode_TypeDef.
  * @param[in] ADC1_Channel: specifies the channel to convert
  * can be one of the values of @ref ADC1_Channel_TypeDef.
  * @param[in] ADC1_PrescalerSelection: specifies the ADC1 prescaler
  * can be one of the values of @ref ADC1_PresSel_TypeDef.
  * @param[in] ADC1_ExtTrigger: specifies the external trigger
  * can be one of the values of @ref ADC1_ExtTrig_TypeDef.
  * @param[in] ADC1_ExtTriggerState: specifies the external trigger new state
  * can be one of the values of @ref FunctionalState.
  * @param[in] ADC1_Align: specifies the converted data alignement
  * can be one of the values of @ref ADC1_Align_TypeDef.
  * @param[in] ADC1_SchmittTriggerChannel: specifies the schmitt trigger channel
  * can be one of the values of @ref ADC1_SchmittTrigg_TypeDef.
  * @param[in] ADC1_SchmittTriggerState: specifies the schmitt trigger state
  * can be one of the values of @ref FunctionalState.
  * @retval None
  */
void ADC1_Init(ADC1_ConvMode_TypeDef ADC1_ConversionMode, ADC1_Channel_TypeDef ADC1_Channel, ADC1_PresSel_TypeDef ADC1_PrescalerSelection, ADC1_ExtTrig_TypeDef ADC1_ExtTrigger, FunctionalState ADC1_ExtTriggerState, ADC1_Align_TypeDef ADC1_Align, ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel, FunctionalState ADC1_SchmittTriggerState)
{

    /* Check the parameters */
    assert_param(IS_ADC1_CONVERSIONMODE_OK(ADC1_ConversionMode));
    assert_param(IS_ADC1_CHANNEL_OK(ADC1_Channel));
    assert_param(IS_ADC1_PRESSEL_OK(ADC1_PrescalerSelection));
    assert_param(IS_ADC1_EXTTRIG_OK(ADC1_ExtTrigger));
    assert_param(IS_FUNCTIONALSTATE_OK(((ADC1_ExtTriggerState))));
    assert_param(IS_ADC1_ALIGN_OK(ADC1_Align));
    assert_param(IS_ADC1_SCHMITTTRIG_OK(ADC1_SchmittTriggerChannel));
    assert_param(IS_FUNCTIONALSTATE_OK(ADC1_SchmittTriggerState));

    /*-----------------CR1 & CSR configuration --------------------*/
    /* Configure the conversion mode and the channel to convert
    respectively according to ADC1_ConversionMode & ADC1_Channel values  &  ADC1_Align values */
    ADC1_ConversionConfig(ADC1_ConversionMode, ADC1_Channel, ADC1_Align);
    /* Select the prescaler division factor according to ADC1_PrescalerSelection values */
    ADC1_PrescalerConfig(ADC1_PrescalerSelection);

    /*-----------------CR2 configuration --------------------*/
    /* Configure the external trigger state and event respectively
    according to NewState, ADC1_ExtTrigger */
    ADC1_ExternalTriggerConfig(ADC1_ExtTrigger, ADC1_ExtTriggerState);

    /*------------------TDR configuration ---------------------------*/
    /* Configure the schmitt trigger channel and state respectively
    according to ADC1_SchmittTriggerChannel & ADC1_SchmittTriggerNewState  values */
    ADC1_SchmittTriggerConfig(ADC1_SchmittTriggerChannel, ADC1_SchmittTriggerState);

    /* Enable the ADC1 peripheral */
    ADC1->CR1 |= ADC1_CR1_ADON;

}
#if 0

/**
  * @brief Enables or Disables the ADC1 peripheral.
  * @param[in] NewState: specifies the peripheral enabled or disabled state.
  * @retval None
  */
void ADC1_Cmd(FunctionalState NewState)
{

    /* Check the parameters */
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    if (NewState != DISABLE)
    {
        ADC1->CR1 |= ADC1_CR1_ADON;
    }
    else /* NewState == DISABLE */
    {
        ADC1->CR1 &= (u8)(~ADC1_CR1_ADON);
    }

}


/**
  * @brief Enables or disables the ADC1 interrupt.
  * @param[in] ADC1_IT specifies the name of the interrupt to enable or disable.
  * This parameter can be one of the following values:
  *    - ADC1_IT_AWDITEN : Analog WDG interrupt enable
  *    - ADC1_IT_EOCITEN  : EOC iterrupt enable
  * @param[in] NewState specifies the state of the interrupt to apply.
  * @retval None
  */
void ADC1_ITConfig(ADC1_IT_TypeDef ADC1_IT, FunctionalState NewState)
{

    /* Check the parameters */
    assert_param(IS_ADC1_IT_OK(ADC1_IT));
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    if (NewState != DISABLE)
    {
        /* Enable the ADC1 interrupts */
        ADC1->CSR |= (u8)ADC1_IT;
    }
    else  /* NewState == DISABLE */
    {
        /* Disable the ADC1 interrupts */
        ADC1->CSR &= (u8)(~ADC1_IT);
    }

}
#endif
/**
  * @brief Configure the ADC1 prescaler division factor.
  * @param[in] ADC1_Prescaler: the selected precaler.
  * It can be one of the values of @ref ADC1_PresSel_TypeDef.
  * @retval None
  */
void ADC1_PrescalerConfig(ADC1_PresSel_TypeDef ADC1_Prescaler)
{

    /* Check the parameter */
    assert_param(IS_ADC1_PRESSEL_OK(ADC1_Prescaler));

    /* Clear the SPSEL bits */
    ADC1->CR1 &= (u8)(~ADC1_CR1_SPSEL);
    /* Select the prescaler division factor according to ADC1_PrescalerSelection values */
    ADC1->CR1 |= (u8)(ADC1_Prescaler);

}


/**
  * @brief Enables or disables the ADC1 Schmitt Trigger on a selected channel.
  * @param[in] ADC1_SchmittTriggerChannel specifies the desired Channel.
  * It can be set of the values of @ref ADC1_SchmittTrigg_TypeDef.
  * @param[in] NewState specifies Channel new status.
  * can have one of the values of @ref FunctionalState.
  * @retval None
  */
void ADC1_SchmittTriggerConfig(ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel, FunctionalState NewState)
{

    /* Check the parameters */
    assert_param(IS_ADC1_SCHMITTTRIG_OK(ADC1_SchmittTriggerChannel));
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    if (ADC1_SchmittTriggerChannel == ADC1_SCHMITTTRIG_ALL)
    {
        if (NewState != DISABLE)
        {
            ADC1->TDRL &= (u8)0x0;
            ADC1->TDRH &= (u8)0x0;
        }
        else /* NewState == DISABLE */
        {
            ADC1->TDRL |= (u8)0xFF;
            ADC1->TDRH |= (u8)0xFF;
        }
    }
    else if (ADC1_SchmittTriggerChannel < ADC1_SCHMITTTRIG_CHANNEL8)
    {
        if (NewState != DISABLE)
        {
            ADC1->TDRL &= (u8)(~(u8)((u8)0x01 << (u8)ADC1_SchmittTriggerChannel));
        }
        else /* NewState == DISABLE */
        {
            ADC1->TDRL |= (u8)((u8)0x01 << (u8)ADC1_SchmittTriggerChannel);
        }
    }
    else /* ADC1_SchmittTriggerChannel >= ADC1_SCHMITTTRIG_CHANNEL8 */
    {
        if (NewState != DISABLE)
        {
            ADC1->TDRH &= (u8)(~(u8)((u8)0x01 << ((u8)ADC1_SchmittTriggerChannel - (u8)8)));
        }
        else /* NewState == DISABLE */
        {
            ADC1->TDRH |= (u8)((u8)0x01 << ((u8)ADC1_SchmittTriggerChannel - (u8)8));
        }
    }

}

/**
  * @brief Configure the ADC1 conversion on selected channel.
  * @param[in] ADC1_ConversionMode Specifies the conversion type.
  * It can be set of the values of @ref ADC1_ConvMode_TypeDef
  * @param[in] ADC1_Channel specifies the ADC1 Channel.
  * It can be set of the values of @ref ADC1_Channel_TypeDef
  * @param[in] ADC1_Align specifies the conerted data alignement.
  * It can be set of the values of @ref ADC1_Align_TypeDef
  * @retval None
  */
void ADC1_ConversionConfig(ADC1_ConvMode_TypeDef ADC1_ConversionMode, ADC1_Channel_TypeDef ADC1_Channel, ADC1_Align_TypeDef ADC1_Align)
{

    /* Check the parameters */
    assert_param(IS_ADC1_CONVERSIONMODE_OK(ADC1_ConversionMode));
    assert_param(IS_ADC1_CHANNEL_OK(ADC1_Channel));
    assert_param(IS_ADC1_ALIGN_OK(ADC1_Align));

    /* Clear the align bit */
    ADC1->CR2 &= (u8)(~ADC1_CR2_ALIGN);
    /* Configure the data alignment */
    ADC1->CR2 |= (u8)(ADC1_Align);

    if (ADC1_ConversionMode == ADC1_CONVERSIONMODE_CONTINUOUS)
    {
        /* Set the continuous coversion mode */
        ADC1->CR1 |= ADC1_CR1_CONT;
    }
    else /* ADC1_ConversionMode == ADC1_CONVERSIONMODE_SINGLE */
    {
        /* Set the single conversion mode */
        ADC1->CR1 &= (u8)(~ADC1_CR1_CONT);
    }

    /* Clear the ADC1 channels */
    ADC1->CSR &= (u8)(~ADC1_CSR_CH);
    /* Select the ADC1 channel */
    ADC1->CSR |= (u8)(ADC1_Channel);

}

/**
  * @brief Configure the ADC1 conversion on external trigger event.
  * @par Full description:
  * The selected external trigger evant can be enabled or disabled.
  * @param[in] ADC1_ExtTrigger to select the External trigger event.
  * can have one of the values of @ref ADC1_ExtTrig_TypeDef.
  * @param[in] NewState to enable/disable the selected external trigger
  * can have one of the values of @ref FunctionalState.
  * @retval None
  */
void ADC1_ExternalTriggerConfig(ADC1_ExtTrig_TypeDef ADC1_ExtTrigger, FunctionalState NewState)
{

    /* Check the parameters */
    assert_param(IS_ADC1_EXTTRIG_OK(ADC1_ExtTrigger));
    assert_param(IS_FUNCTIONALSTATE_OK(NewState));

    /* Clear the external trigger selection bits */
    ADC1->CR2 &= (u8)(~ADC1_CR2_EXTSEL);

    if (NewState != DISABLE)
    {
        /* Enable the selected external Trigger */
        ADC1->CR2 |= (u8)(ADC1_CR2_EXTTRIG);
    }
    else /* NewState == DISABLE */
    {
        /* Disable the selected external trigger */
        ADC1->CR2 &= (u8)(~ADC1_CR2_EXTTRIG);
    }

    /* Set the slected external trigger */
    ADC1->CR2 |= (u8)(ADC1_ExtTrigger);

}

/**
  * @brief Start ADC1 conversion
  * @par Full description:
  * This function  triggers the start of conversion, after ADC1 configuration.
  * @par Parameters:
  * None
  * @retval None
  * @par Required preconditions:
  * Enable the ADC1 peripheral before calling this fuction
  */
void ADC1_StartConversion(void)
{
    ADC1->CR1 |= ADC1_CR1_ADON;
}

/**
  * @brief Get one sample of measured signal.
  * @par Parameters:
  * None
  * @retval ConversionValue:  value of the measured signal.
  * @par Required preconditions:
  * ADC1 conversion finished.
  */
u16 ADC1_GetConversionValue(void)
{

    u16 temph = 0;
    u8 templ = 0;

    if (ADC1->CR2 & ADC1_CR2_ALIGN) /* Right alignment */
    {
        /* Read LSB first */
        templ = ADC1->DRL;
        /* Then read MSB */
        temph = ADC1->DRH;

        temph = (u16)(templ | (u16)(temph << (u8)8));
    }
    else /* Left alignment */
    {
        /* Read MSB firts*/
        temph = ADC1->DRH;
        /* Then read LSB */
        templ = ADC1->DRL;

        temph = (u16)((u16)(templ << (u8)6) | (u16)(temph << (u8)8));
    }

    return ((u16)temph);

}


/**
  * @brief Checks the ADC1 EOC flag status.
  * @par Parameters:
  * None
  * @retval FlagStatus Status of the ADC1 EOC flag.
  */

FlagStatus ADC1_GetFlagStatus(void)
{

    /* Get EOC  flag status */
    return ((u8)(ADC1->CSR & ADC1_CSR_EOC));


}

/**
  * @brief Clear the ADC1 EOC Flag.
  * @par Parameters:
  * None
  * @retval None
  */

void ADC1_ClearFlag(void)
{
  
    ADC1->CSR &= (u8)(~ADC1_CSR_EOC);
}




/**
  * @}
  */

/******************* (C) COPYRIGHT 2009 STMicroelectronics *****END OF FILE****/
