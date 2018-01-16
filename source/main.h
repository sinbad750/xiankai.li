
/******************** (C) COPYRIGHT 2007 STMicroelectronics ********************
* File Name          : main.h
* Author             : MCD Application Team
* Version            : V1.0
* Date               : 10/08/2007
* Description        : Header for main.c module
********************************************************************************
* THE PRESENT SOFTWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
* AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
* INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
* CONTENT OF SUCH SOFTWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
* INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*******************************************************************************/

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

//extern u8 system_100ms_tick;
extern u8 system_20ms_tick;
extern u8 system_2s_tick;
extern u8 flag_charge_ing;
extern u8 LR_Flag;
extern u8 standby_flag;
extern u8 rest_wireless_time;
extern u8   RX_disconnect_time;
extern  u8 system_1s_Timer_FLAG;
extern u8  pairing_flag;
extern u8     led_test_time;
extern u8     led_test_time1;
extern u8   connect_to_disconnecttime;
extern u8   link_to_dislinktime;
extern u8 power_on_time;
extern u16 temper_value;
extern u8 standby_charge_flag;
extern u16  poweroff_time;
extern u8 full_charge_flag;
extern u8 standby_time;
extern  u16  charge_time;
extern  u8 OFF_USB_CHARGE_FLG;
extern u8 charge_changeto_disconent_flag;
extern u8 standby_flag_SOD;

void Wait_For_mSec(u16 b1ms);

								
void vLed_Light_Process(u8 pwm_value);
void myputc(u8 c);
void myprintf(char *str, unsigned int value);
void myputstr(unsigned char  *pFmt);
void system_1Ms_Timer(void);
void system_1s_Timer(void);

void Init_ADC9(void);
void Init_ADC1(void);
#define muti_key
#define MCU_VER   23

//#define use_ak7755_demo
#define use_dv1_pcb

#define OFF  0
#define ON     1

#define OK 	1
#define NOK     0


#define ERR         1
#define NO_ERR  0

#define HIGH    1
#define LOW     0



#define Battery_Charge_Pin_Status()        GPIO_ReadInputPin(GPIOA, GPIO_PIN_3)


#define USB5V_Pin_Status()        GPIO_ReadInputPin(GPIOB, GPIO_PIN_7)

#ifdef  use_dv1_pcb
#define Clock_Coco_Port           GPIOE
#else
#define Clock_Coco_Port           GPIOD
#endif
#define Clock_Coco_Pin       GPIO_PIN_0


#define UART_Port           GPIOD

#define UART_Port_TX_Pin       GPIO_PIN_5

#define ONOFF_PIN_STATUS             GPIO_ReadInputPin(GPIOA,GPIO_PIN_4)
								
						

#define AMP_MUTE(state)          if(state)  GPIO_WriteLow(GPIOE, GPIO_PIN_7);\
								else         GPIO_WriteHigh(GPIOE, GPIO_PIN_7); 								

#define DSP_RESET_PORT 	GPIOB
#define DSP_RESET_PIN	      GPIO_PIN_3


#define  DSP_RESET(statu)        if(statu) GPIO_WriteHigh(DSP_RESET_PORT, DSP_RESET_PIN);\
                                                      else  	GPIO_WriteLow(DSP_RESET_PORT, DSP_RESET_PIN)


#define SPI_DSP_CS(sel)                 if(sel) GPIO_WriteHigh(GPIOG,GPIO_PIN_0);\
								    else GPIO_WriteLow(GPIOG,GPIO_PIN_0);


#define Wireless_rest(state)              if(state)  GPIO_WriteHigh(GPIOE,GPIO_PIN_2);\
								    else GPIO_WriteLow(GPIOE,GPIO_PIN_2); 	

#define System_Standby(state)        if(state)  GPIO_WriteHigh(GPIOC,GPIO_PIN_3);\
								    else GPIO_WriteLow(GPIOC,GPIO_PIN_3);    

#define AMP_SDZ(state)	              if(state)  GPIO_WriteHigh(GPIOB,GPIO_PIN_0);\
								   else GPIO_WriteLow(GPIOB,GPIO_PIN_0)  	


#define MCU_POWER_SW(state)      if(state)  GPIO_WriteHigh(GPIOC,GPIO_PIN_1);\
								   else GPIO_WriteLow(GPIOC,GPIO_PIN_1) 		


#define  RED_LED(state) 		       if(state)  GPIO_WriteLow(GPIOA,GPIO_PIN_4);\
								   else GPIO_WriteHigh(GPIOA,GPIO_PIN_4) 	
								   	
#define WHITE_LED(state) 		if(state)  GPIO_WriteLow(GPIOA,GPIO_PIN_5);\
								   else GPIO_WriteHigh(GPIOA,GPIO_PIN_5) 	

								   
#define CHARGE_EN(state)     	       if(state)  GPIO_WriteLow(GPIOA,GPIO_PIN_6);\
								   else GPIO_WriteHigh(GPIOA,GPIO_PIN_6) 	


#define Power_off_ready(state)     	if(state)  GPIO_WriteLow(GPIOD,GPIO_PIN_3);\
								   else GPIO_WriteHigh(GPIOD,GPIO_PIN_3 ) 	
								   	

#define Batt_16v_SW(state)      if(state)  GPIO_WriteHigh(GPIOD,GPIO_PIN_7);\
								   else GPIO_WriteLow(GPIOD,GPIO_PIN_7) 	
								   

////////////////////////////////////////////////////////////////////////////////////////////D3

								
		


							
												
#define KEY_DUMMY                     0x00
#define SHORT_PRESS                  0x80
#define LONG_PRESS                    0x40

#define KEY_LONG_POWER           0x42
#define KEY_SHORT_POWER          0x82

#define KEY_GO_PAIRNG            0x88

#define PAIRING_KEY1                  0x45
#define REST_PAIRING_KEY           0x46


#define HIBYTE(INTEGER)       (*((unsigned char  *)&INTEGER+1))
#define LOBYTE(INTEGER)      (*((unsigned char  *)&INTEGER))

#endif /* __MAIN_H */

/******************* (C) COPYRIGHT 2007 STMicroelectronics *****END OF FILE****/
