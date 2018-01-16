#include "config.h"
#include "main.h"
#include "wireless_func.h"
#include "Tas5711.h"
#include "led.h"
#include "upg.h"
#include "BT830.h"
#include "key.h"


#include "uart.h"
#include "i2c.h"
bool STB_FLAG=0;
u8 shor_key=0;
u8 shor_key_time=0;
bool key_was_ready=0;
bool key_was_press;
bool bt_do_not_reconnect_flag=0;
u8 key_command;
bool BT_R_nfc_disable_flag=0;
bool i2c_buzy_flag=0;
void Power_onoff_board(u8 onoff)

{
   if(onoff)
   	{
   	GPIO_WriteLow(GPIOB, GPIO_PIN_2);
   	}
   else
   	{
   	GPIO_WriteHigh(GPIOB, GPIO_PIN_2);
   	}

}

void Power_Off_direct(void)
{

	STB_FLAG=1;
	info_Tx_Wireless_Sod_BT_mode(1);
	Wait_For_mSec(300);	
       System_PowerOff();	
	GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_OUT_PP_HIGH_FAST);	
	Power_onoff_board(OFF);

}




unsigned char Key_Value(void)
{
	u8 temp;
	temp=0;



	
       temp = GPIO_ReadInputPin(GPIOC,GPIO_PIN_2); // POWER KEY DETECT
	
	if(temp == 0x00)
		return 0x02;
	



	 
    //   temp = GPIO_ReadInputPin(GPIOB,GPIO_PIN_7); //BT KEY
	
	//if(temp == 0x00)
	//	return 0x03;
	
	temp = GPIO_ReadInputPin(GPIOB,GPIO_PIN_6);// SOD KEY 
	
	if(temp == 0x00)
		return 0x04;

	
	return KEY_DUMMY;
}



void Key_Scan(void)
{
  static unsigned short repeat_count;
  static unsigned char prev_key=KEY_DUMMY;
  unsigned char curr_key;
  
  if(key_was_ready)
  	return;
  else
  	{
		key_was_press=FALSE;
		if(KEY_DUMMY!=Key_Value())
		{
			curr_key=Key_Value();
			if(curr_key==prev_key)
			{
				if(repeat_count<500)
					repeat_count++;
					key_command=curr_key;
			}
			key_was_press=TRUE;
			prev_key=curr_key;
		}
  	}
  
  switch(key_command)
  	{
  	case 0x01:
	case 0x02:
	case 0x03:
	case 0x04:
		if((repeat_count>3)&&(repeat_count<100)&&(!key_was_press))
			{
				key_command |= SHORT_PRESS;
				key_was_ready=TRUE;
				return;
			}
		else if(repeat_count>200)
			{
			        key_command |= LONG_PRESS;
				 key_was_ready=TRUE;
				 repeat_count=0;
				 return;
			}
		break;
		
#ifdef  muti_key

	case 0x05:
	case 0x06:
		
	        if(repeat_count>180)
			{
			        key_command |= LONG_PRESS;
				key_was_ready=TRUE;
				repeat_count=0;
				return;
			}
		break;	

		
 #endif  	
 
	default:
		break;
  	}
  if(!key_was_press)
  	{
	  	prev_key=KEY_DUMMY;
		key_command=KEY_DUMMY;
		repeat_count=0;
  	}
}


void Key_Service(void)
{
  unsigned char KeyCode;
  KeyCode=KEY_DUMMY;
  if(key_was_ready)
  	{
			KeyCode=key_command;
			key_was_ready=FALSE;
  	}
  
  switch(KeyCode)
  	{

		case KEY_LONG_POWER: 

			  if(!Battery_Charge_Pin_Status())	
			  	{
			  	//   Rest_Pairing_Code();   //close 20170627
	                    //   led_test_time=10;
			      
			       }


		break; 


		case KEY_SHORT_POWER:   

			
              if(Battery_Charge_Pin_Status())
              	{

                       if(standby_flag)
                       	{
                                    	 standby_flag=0;
						// MCU_POWER_SW(ON);

					         System_Standby(ON);	
								   
                                         if(Link_State==Link_None)
					        Batt_16v_SW(ON);
									   
		                            AMP_MUTE(OFF);
                
		               		 // need add wireless rest  ???here  20170614	 
                       	}
			   else
			   	{
              	      AMP_MUTE(ON);
			      MCU_POWER_SW(OFF);
		             Power_off_ready(ON);					 
			   	}	 
              	}
		 else 
		 	{	 	
		       shor_key++;	
			 shor_key_time=2;
		 	}


		 if(shor_key==5)
		 	{
		 	
		 	shor_key=0;
			
                    key_command=KEY_GO_PAIRNG;
                    key_was_ready=TRUE;
				
		 	}	
		  break;  


		 case KEY_GO_PAIRNG:   
		 		{
			Wireless_Goto_Pairing();
			pairing_flag=80;
                       //	uHAL_Akm7719_SPI_Write_VOL(0x00 ,0x600000); //test
				}
		 	  break;  


#ifdef  muti_key

      case REST_PAIRING_KEY:  
	  	{
	  //   Rest_Pairing_Code();
	   //   	led_test_time=7;
			}
         	       break; 

      case  PAIRING_KEY1:  
	           {
		//	Wireless_Goto_Pairing();
		//	pairing_flag=60;
		
				}
         	       break; 
#endif	
	
		default:
		break;
  	}
}



























