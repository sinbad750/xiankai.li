 #include "config.h"
#include "stm8s_type.h"
#include "stm8s_exti.h"
#include "uart.h"
//#include "stm8s_spi.h"
#include "stm8s_flash.h"
#include "main.h"
#include "led.h"
#include "upg.h"
#include "charge.h"
#include "wireless_func.h"
#include "Tas5711.h"
#include "key.h"
#include "BT830.h"


#define new_Board_Pin_Status()        GPIO_ReadInputPin(GPIOG, GPIO_PIN_1)
u16 test_flash_ID=0;
u8 power_on_time=0;
u8 system_20ms_tick=0;
u8 system_2s_tick;
u8 key_count;

u8 rest_wireless_time=0;

u8 LR_Flag=0;  // L =2  R=1
u8 standby_flag=0;


u8   RX_disconnect_time=0;
u8    Pre_Wireless_State=0;
u8    timer_20s=0;

u16  wireless_int_pin_ERROR=0;
u8  pairing_flag=0;
u8 system_1s_Timer_FLAG=0;

u8     led_test_time=0;
 u8     led_test_time1=0;
u8   connect_to_disconnecttime=0;
u8   link_to_dislinktime=0;
u8   temper_check_time=1;

u16 temper_value=0;

u8 standby_time=0;
u16  poweroff_time=0;
u8 standby_charge_flag=0;
u16 charge_report_time=0;

u8 full_charge_time=0;
u8 full_charge_flag=0;
#define HSEStartUp_TimeOut  0x1000

u8 temper_protect_time=0;
u8 new_old_board=0;

u8 powe_on_mute_flag=0;
u8 OFF_USB_CHARGE_FLG=0;

u8 charge_changeto_disconent_flag=0;

u8 standby_flag_SOD=0;
ErrorStatus  WaitForHSEStartUp(void)
{
	static volatile FlagStatus HSEStatus;
	u16 StartUpCounter =HSEStartUp_TimeOut;
	/* Wait till HSE is ready and if Time out is reached exit */
	do
	{
		HSEStatus = CLK_GetFlagStatus(CLK_FLAG_HSERDY);
		StartUpCounter++;  
	}
	while((HSEStatus == RESET) && (StartUpCounter != HSEStartUp_TimeOut));
	if(CLK_GetFlagStatus(CLK_FLAG_HSERDY) != RESET)
	return SUCCESS;
	return ERROR;
}
void CLOCK_Init(void)	
	
{
        CLK_DeInit();  //lxk add
	//CLK_HSECmd(DISABLE);
	//CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);

  	
	CLK_HSECmd(ENABLE);
	if(WaitForHSEStartUp()==SUCCESS)//use  HSE as  master CLK
	{
		CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO,CLK_SOURCE_HSE ,DISABLE,  CLK_CURRENTCLOCKSTATE_DISABLE);
		while(CLK_GetSYSCLKSource()!=CLK_SOURCE_HSE);
			CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
	}
	
	 CLK_CCOConfig(CLK_OUTPUT_CPU);
        CLK_CCOCmd(ENABLE);//
         
}
void Init_ADC9(void)
{
      
	ADC1_Init(ADC1_CONVERSIONMODE_SINGLE,ADC1_CHANNEL_9,
	ADC1_PRESSEL_FCPU_D18,
	ADC1_EXTTRIG_TIM,DISABLE,ADC1_ALIGN_RIGHT,ADC1_SCHMITTTRIG_CHANNEL9,DISABLE);
	ADC1_StartConversion();
	
}

void Init_ADC1(void)
{
	ADC1_Init(ADC1_CONVERSIONMODE_SINGLE,ADC1_CHANNEL_1,
	ADC1_PRESSEL_FCPU_D18,
	ADC1_EXTTRIG_TIM,DISABLE,ADC1_ALIGN_RIGHT,ADC1_SCHMITTTRIG_CHANNEL1,DISABLE);
	ADC1_StartConversion();
	
}

void  TIM4_Config_1MS(void)    /*for 1ms systick timer*/
 {
       TIM4_DeInit(); // lxk add 	 
	TIM4_TimeBaseInit(TIM4_PRESCALER_128,0x60 );   //0xBA
	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
	TIM4_Cmd(ENABLE); 
	
}
void Init_Config_IO(void)
{

	
	//
	
	//GPIO_Init(GPIOA, GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT); //

	//GPIO_Init(GPIOA, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_SLOW);

     //  GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);   //HW_OFF

	//GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_OUT_PP_HIGH_FAST);  // TX_RX

	//GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_PP_HIGH_FAST);  //  AMP MUTE

	//GPIO_Init(GPIOB, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);  //sod key

	
//////////////////////////////////////////HARMAN////////////////////////////////////////////////////////////////

        /******DSP*******/
#ifdef use_ak7755_demo
      
       GPIO_Init(GPIOB, GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT); //AK7755 PDN (REST)	 
       GPIO_Init(GPIOC, GPIO_PIN_5, GPIO_MODE_IN_FL_NO_IT);//DSP CLK
	GPIO_Init(GPIOC, GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);//DSP MOSI
	GPIO_Init(GPIOC, GPIO_PIN_7, GPIO_MODE_IN_FL_NO_IT);//DSP MISO
	GPIO_Init(GPIOG, GPIO_PIN_0, GPIO_MODE_IN_FL_NO_IT);//DSP CSf
#else

       GPIO_Init(GPIOB, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_FAST); //AK7755 PDN (REST) 
       GPIO_Init(GPIOC, GPIO_PIN_5, GPIO_MODE_OUT_OD_HIZ_FAST);//DSP CLK
	GPIO_Init(GPIOC, GPIO_PIN_6, GPIO_MODE_OUT_OD_HIZ_FAST);//DSP MOSI
	GPIO_Init(GPIOC, GPIO_PIN_7, GPIO_MODE_IN_FL_NO_IT);//DSP MISO
	GPIO_Init(GPIOG, GPIO_PIN_0, GPIO_MODE_OUT_PP_HIGH_FAST);//DSP CS

#endif
	/********LED************/
	GPIO_Init(GPIOA, GPIO_PIN_4, GPIO_MODE_OUT_PP_HIGH_FAST); //  SOD  RED LED

	GPIO_Init(GPIOA, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST); //SOD LED
	/********SYSTEM CLOCK*******/
	GPIO_Init(Clock_Coco_Port, Clock_Coco_Pin, GPIO_MODE_OUT_PP_LOW_FAST);//CCO  
	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_FAST); //standby
	/****Wireless ******/
	GPIO_Init(GPIOE, GPIO_PIN_2, GPIO_MODE_OUT_PP_HIGH_FAST); //WIRELESS REST
	GPIO_Init(GPIOE, GPIO_PIN_1, GPIO_MODE_OUT_OD_HIZ_FAST);   // WIRELESS I2C
	#ifdef  use_dv1_pcb
	GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_OD_HIZ_FAST);   // WIRELESS I2C
	#else
	GPIO_Init(GPIOE, GPIO_PIN_0, GPIO_MODE_OUT_OD_HIZ_FAST);   // WIRELESS I2C
       #endif
	GPIO_Init(GPIOE, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);  //Wireless Request INT/


	/*********AMP***********/
	GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_OUT_PP_HIGH_FAST); //AMP SDZ
	GPIO_Init(GPIOE, GPIO_PIN_7, GPIO_MODE_OUT_PP_HIGH_FAST); //AMP MUTE


	/*******ADC************/
	GPIO_Init(GPIOE, GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);// ADC
	GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT);// ADC
	
	
	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);// charge detect

	GPIO_Init(GPIOC, GPIO_PIN_1, GPIO_MODE_OUT_PP_HIGH_SLOW);  // MCU PWER ON/OFF

	GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_PU_NO_IT);  //  power_on_off   BYpass THE power key  ACTIVE HIGH

	GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_IN_PU_NO_IT);  //  KEY DETECT   ACTIVE LOW

	GPIO_Init(GPIOA, GPIO_PIN_6, GPIO_MODE_OUT_PP_HIGH_FAST); //charge en

       GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_FAST); //power off ready
	
	//GPIO_Init(GPIOD, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);  /*for uart 2 tx***/
	//GPIO_Init(GPIOD, GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);  /*for uart 2 rx***/


	//test

	GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_HIGH_FAST); //power off ready


       GPIO_Init(GPIOE, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);  //SPI FLASH CS

	   
	//GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);  //24V in detect	


	GPIO_Init(GPIOD, GPIO_PIN_7, GPIO_MODE_OUT_PP_HIGH_FAST);   //batt on    16v on 



	GPIO_Init(GPIOG, GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT);  //sod key


	GPIO_Init(GPIOB, GPIO_PIN_7, GPIO_MODE_IN_FL_NO_IT);   //batt on    16v on 

}









void System_Init(void)
{
	Battery_Status_Detect();
	if(Link_State==Link_None)
	{
		u8 i;
		battery_quantity=Electric_Full;
		Get_Battery_temper_Status();
		for(i=0;i<30;i++)
		{
			Get_Battery_Status();
			Wait_For_mSec(20);
		}

		if(battery_quantity<=Electric_Empty)
		    disp_index=Disp_Battery_Empty;
		
	}
	system_20ms_tick=0;
}

/* for optionBYTE change
u8 ELL=0;
void Option_Operation(void)
	{
          ELL=*((unsigned char*)0x4803);
	   FLASH_Unlock(FLASH_MEMTYPE_DATA);
         if(0x04!=*((unsigned char*)0x4803))
         	{
                FLASH_ProgramOptionByte(0X4803, 0X04);
		   Wait_For_mSec(20);
		   FLASH_ProgramOptionByte(0X4804, ~0x04);
		   Wait_For_mSec(20);
		 }
		FLASH_Lock(FLASH_MEMTYPE_DATA);
	
	
	}
	
*/

 void MCU_init(void)
 { 
      
	CLOCK_Init();
	Init_Config_IO();
       Batt_16v_SW(OFF);

   
	AMP_MUTE(ON);
	Wireless_rest(LOW);
		    
	Wait_For_mSec(100);
    
       Power_off_ready(OFF);

	//GPIO_WriteHigh(GPIOC,GPIO_PIN_4);
	
	Wireless_rest(HIGH);
	//Batt_16v_SW(ON);
	System_Standby(ON);
	
	AMP_SDZ(ON);
         
	  new_old_board=new_Board_Pin_Status() ;
	if(new_old_board)
		{
	MCU_POWER_SW(OFF);
		}
	else
		{
	MCU_POWER_SW(ON);
		
		}
   #ifndef use_ak7755_demo
          SPI_DSP_Init();
   #endif

   
	 RED_LED(OFF);
	 WHITE_LED(OFF);
	 
        Wait_For_mSec(30);
	
	 UART2_DeInit();

        initUart(UART2_MODE_RX_ENABLE);
		
       // initUart(UART2_MODE_TXRX_ENABLE); S_DEBUG

	Init_ADC9();

	TIM4_Config_1MS();   //  1Millisecond

	enableInterrupts(); 

	Battery_Charge(ENABLE);

	#ifndef use_ak7755_demo
       vAPP_Akm7719_Dsp_Init();
      #endif
    
	System_Init();  
      
       CHARGE_EN(ON);
	Wait_For_mSec(100);

	if(battery_quantity!=Electric_Need_Cut)
		{
	       Batt_16v_SW(ON);
		}
	 else
	 	{
	 	powe_on_mute_flag=1; 
	 	}
	// if(adc_value>765)
	 //	Batt_16v_SW(ON);
	 
      //  if(!Battery_Charge_Pin_Status())
	//	Batt_16v_SW(ON); 	
		
       AMP_MUTE(OFF);
	

    // test_flash_ID=ReadDeviceID(); 


    //	 SPI1_Test();
  if((Battery_Charge_Pin_Status()==0)&&(Main_Link_Status()==0))
  	{
        OFF_USB_CHARGE_FLG=1;
  	}
}



  void System_Main_Loop(void)
{
	if(system_20ms_tick>40)
	       {
	       
		system_20ms_tick=0x00;
		Wireless_RxInfoProcess();
		Wireless_State_Process();

		
              Key_Service();
		  
		if(wireless_int_pin_ERROR>=1800)
		{
		  Wireless_Reset();
		  disp_timer=4;
		  wireless_int_pin_ERROR=0;
		}
 
		
        	}   
 
       Charge_Manager_Loop();
	Led_Display_Loop();
	system_1s_Timer();
}




u16  charge_time;

void system_1Ms_Timer(void)
{

	key_count++;
	if(key_count>=20)
	{
		key_count=0;
	    if(power_on_time>2)
		Key_Scan();

	}
     if(!WIRELESS_INT_PIN_STATUS)	
     	{
     
        wireless_int_pin_ERROR++;
	
     	}
	 else
	{
        wireless_int_pin_ERROR=0;
	}



      if(!Battery_Charge_Pin_Status())
      	{
          if(charge_time<300)
		charge_time++;
		
      	}
	 else
	 {
              charge_time=0;
	 }
	 #if 0
	 	          charge_report_time++;
			  if(charge_report_time==3500)
			  	{
			  
			          charge_report_time=1051;
				 if(LR_Flag==1)
				   		{
				   		
				    charge_report_time=1876;
				   		} 
			          Report_Charge_Status(flag_charge_ing);
			  	}
#endif
}

void system_1s_Timer(void)
{

if(!system_1s_Timer_FLAG)
	return;

if(power_on_time<100)
{
  power_on_time++;
}

if(shor_key_time)
{
	shor_key_time--;
	if(!shor_key_time)
		shor_key=0;
	
}	

   if(STB_FLAG)
   	{ 
   	    System_PowerOff();
	    Power_onoff_board(OFF);	
   	}


      if(pairing_flag)
		 pairing_flag--;

		 
          if(Wireless_State==_Wireless_ConnectTx)
               Pre_Wireless_State=Wireless_State;

           if( (Wireless_State==_Wireless_None_Connect)&&(Pre_Wireless_State==_Wireless_ConnectTx))
           	{

                  RX_disconnect_time++;
                  
		  if(RX_disconnect_time>15)	
		  	{
		  	 RX_disconnect_time=0;
			 Pre_Wireless_State=Wireless_State;
		  	}
		
		}
	   else
	   	{ 
	   	RX_disconnect_time=0;

		}
//////////////////////////////////


//new_old_board=new_Board_Pin_Status();

#if 0
if ( adc_value>940)
{
     full_charge_time++;
	if(full_charge_time>20)
		{
		full_charge_time=0;
		if(Link_State==Link_On)
			{
                  flag_charge_ing=0;
		     full_charge_flag=1;
			}		  
	       }
}	 
else 
{
	full_charge_time=0;
	full_charge_flag=0;
}
#endif


///////////////////////////////////


    if ( led_test_time)
    	{
           led_test_time--;
           vLed_Display_Upg(led_test_time);	   
	}
    if ( led_test_time1)
    	{
           led_test_time1--;
    	}	
           timer_20s++;
           if(timer_20s>=20)
           	{
                 timer_20s=0;
		 if(WIRELESS_INT_PIN_STATUS)		 
		  clear_rx_buffuer();	
           	}

		 
     if((temper_value<670)&&(temper_value>0))
     	{
     	temper_protect_time++;
	if( temper_protect_time==6 )
		{
             AMP_MUTE(ON);
             Power_off_ready(ON);
			 temper_protect_time=0;
		}
	   
/*
     50 -----4.1K--------1.83V      2.27v
     55 -----3.48K--------1.65V     2.2v
     60 -----2.97K--------1.5V      2.13v
     65 -----2.54K--------1.36V    2.06v
     65------2.22K--------???       1.98v   615
     
 */
     	}	

      if(((Wireless_State==_Wireless_None_Connect)||(Wireless_State==_Wireless_standby))&&(standby_flag==0))
      	{
      	  standby_time++;
	//	  	  if(standby_time>=6)
	  //	{
	  
	//	   AMP_MUTE(ON);	
		   
	
	 //      }
#if 0
		   if(standby_flag_SOD)
		   	{
		   	  if(standby_time>=7)
		   	  	{
		        charge_changeto_disconent_flag=0;
			 standby_time=0;
                     standby_flag=1;
		        AMP_MUTE(ON);		   
		        Batt_16v_SW(OFF);		   
		        System_Standby(OFF);
				
		   	  	}
		   	}

	  if(standby_time>=180)
	  	{
	  	   standby_time=0;
                standby_flag=1;
		   AMP_MUTE(ON);	
		   
		   Batt_16v_SW(OFF);

		   
		   System_Standby(OFF);
	
		   //disp_index=Disp_standby; 
	       }
	  #endif

	  	  if(standby_time>=7)
	  	{
	  	  
	  	   standby_time=0;
                standby_flag=1;
		   AMP_MUTE(ON);	
		   
		   Batt_16v_SW(OFF);

		   
		   System_Standby(OFF);
		   
                       if(standby_flag_SOD)
			 charge_changeto_disconent_flag=0;
		   //disp_index=Disp_standby; 
	       }

       }




	      if(flag_charge_ing)
		    	{
			//disp_index=Disp_Dis_Connect;
			if(!charge_changeto_disconent_flag)
			disp_index=Disp_USB_charge;
		    	}



		if( Wireless_State== _Wireless_standby)
			{
			 charge_changeto_disconent_flag=0;
                     poweroff_time++;
			 if(poweroff_time==1020)
			 	{
			 	  AMP_MUTE(ON);
			         Power_off_ready(ON);
			         MCU_POWER_SW(OFF);
				  poweroff_time=0;
			 	}
			 	
		       }
		else
			{
			  poweroff_time=0;
			}
		

	          charge_report_time++;
			  if(charge_report_time>=3)
			  	{
			  
			  	   charge_report_time=0;
				   	if(LR_Flag==1)
				    charge_report_time=2;
			          Report_Charge_Status(flag_charge_ing);
			  	}
	   
              if( powe_on_mute_flag)
              	{
                     if(battery_quantity!=Electric_Need_Cut)
                     	{
                                Batt_16v_SW(ON);
				     powe_on_mute_flag=0;				
				}
			 }
			 
            system_1s_Timer_FLAG=0;
			
}





 void main(void)
{   

     // Option_Operation();
	MCU_init();     
	while (1)
	{   
       Upgrade_Loop();
	if(up_state==UP_STATE_IDLE) 
	System_Main_Loop();
	}	
}


 
