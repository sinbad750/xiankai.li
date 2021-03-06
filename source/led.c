#include "config.h"
#include "stm8s_type.h"
#include "stm8s_gpio.h"
#include "led.h"
#include "main.h"
#include "charge.h"
#include "wireless_func.h"
#include "key.h" 
//#define DEBUG

u8 r_pwm_value=0x00; 
u16 r_light_timer;

u8 y_pwm_value=0x00;
u16 y_light_timer;

u8 w_pwm_value=0x00;
u16 w_light_timer;

u8 b_pwm_value=0x00;
u16 b_light_timer;

u8 s_pwm_value=0x00;
u16 s_light_timer;

_DispType disp_index=Disp_None;

u8 disp_timer=0x00;

void vLed_Disp_DisConnect(void)
{
	static u8 pwm_backup=0;
	static u8 w_time_backup=0;
 	
		if(r_light_timer!=0) return;

		w_pwm_value=LIGHTLY_0P4;
		
		r_pwm_value=LIGHTLY_0P4;

		if(pwm_backup==LIGHTLY_2P4)
		w_pwm_value=LIGHTLY_0P4;
		else
		{
		w_pwm_value=LIGHTLY_2P4;
	
		}
		pwm_backup=w_pwm_value;
		
		r_light_timer=_200MS;

}
//Wireless
void vLed_Disp_Parring(void)
{
	static u8 r_time_backup=0;
	if(r_light_timer!=0) return;
	if(r_time_backup==LIGHTLY_2P4)
	{
		r_pwm_value=LIGHTLY_0P4;
		r_time_backup=LIGHTLY_0P4;
	}
	else
	{
		r_pwm_value=LIGHTLY_2P4;
		r_time_backup=LIGHTLY_2P4;
	}
	w_pwm_value=LIGHTLY_0P4;
	y_pwm_value=LIGHTLY_0P4;
	r_light_timer=_100MS;    
}
void vLed_Disp_BatteryEmpty(void)
{
	static u8 r_pwm_backup;
	if(r_light_timer!=0) return ;
	w_pwm_value=LIGHTLY_0P4;
	if(r_pwm_backup==LIGHTLY_2P4)
		r_pwm_value=LIGHTLY_1P20;
	else
		r_pwm_value=LIGHTLY_2P4;
	r_light_timer=_300MS;
	r_pwm_backup=r_pwm_value;
}

void vLed_Disp_Charge_Full(void)
{
	y_pwm_value=LIGHTLY_0P4;
	r_pwm_value=LIGHTLY_0P4;
	w_pwm_value=LIGHTLY_2P4;
	if(!disp_timer)
		//disp_index=Disp_Docked;
		disp_index=Disp_Separate;
}

void vLed_Disp_BatteryCharge(void)
{

	r_pwm_value=LIGHTLY_4P4;
	w_pwm_value=LIGHTLY_0P4;
	if(battery_charge==_Charge_Full)   
		{
		//disp_index=Disp_Charge_Full;
		//disp_timer=10;
		//disp_index=Disp_Docked;
		disp_index=Disp_Separate;
		}
}


void vLed_Disp_USB_BatteryCharge(void)
{

	r_pwm_value=LIGHTLY_4P4;
	w_pwm_value=LIGHTLY_0P4;
	if(battery_charge==_Charge_Full)   
		{
		//disp_index=Disp_Charge_Full;
		//disp_timer=10;
		//disp_index=Disp_Docked;
		disp_index=Disp_Separate;
		}
}
void vLed_Disp_BatteryLow(void)  //Red 50%->100% replace each other
{
	 r_pwm_value=LIGHTLY_2P4;
	w_pwm_value=LIGHTLY_0P4;
}
void vLed_Disp_BatteryCharge_TimeOut(void)
{
	static u8 y_pwm_backup;
	/*
	if(y_light_timer!=0) return ;
	
	if(y_pwm_backup==LIGHTLY_2P4)
		y_pwm_value=LIGHTLY_1P20;
	else
		y_pwm_value=LIGHTLY_2P4;
	y_light_timer=_1SEC;
	y_pwm_backup=y_pwm_value;
	*/
	
	r_pwm_value=LIGHTLY_0P4;
	w_pwm_value=LIGHTLY_0P4;

	if(battery_charge==_Charge_Ing)    //Yellow On always
		disp_index=Disp_Charging;
	else if(battery_charge==_Charge_Full)
		//disp_index=Disp_Docked;
		disp_index=Disp_Separate;
}
//Charged & Connected
void vLed_Disp_Docked(void)
{

	r_pwm_value=LIGHTLY_0P4;

      w_pwm_value=LIGHTLY_1P4;

	if(battery_charge==_Charge_Ing)
		disp_index=Disp_Charging;
	else if(battery_charge==_Charge_None)
		disp_index=Disp_Separate;

}
void vLed_Disp_Docking(void)   //  2Second White On--->OFF
{
	
	r_pwm_value=LIGHTLY_0P4;
	w_pwm_value=LIGHTLY_4P4;
	if(!disp_timer)
		{
		if(battery_charge==_Charge_Full)
			{
			//disp_index=Disp_Charge_Full; 
		      //  disp_timer=10;
		        disp_index=Disp_Docked; 
			}
		else
			{
		           disp_index=Disp_Docked;    //White from OFF to  ON
			}
		}
		


	
}



void vLed_Disp_UnDocking(void)
{
	if(w_light_timer!=0) return ;
	y_pwm_value=LIGHTLY_0P4;
	r_pwm_value=LIGHTLY_0P4;
	if(w_pwm_value<10)
		w_pwm_value++;
	else
		disp_index=Disp_Separate;    //White from OFF to  ON
	w_light_timer=_200MS;
}
void vLed_Disp_Docking_BatteryLow(void)   //  2Second White On--->OFF
{
	if(r_light_timer!=0) return ;
	y_pwm_value=LIGHTLY_0P4;
	w_pwm_value=LIGHTLY_0P4;
	if(r_pwm_value)
		r_pwm_value--;
	else
		disp_index=Disp_Charging;    //White from OFF to  ON
	r_light_timer=_100MS;
}
void vLed_Disp_UnDocking_BatteryLow(void)
{
	if(r_light_timer!=0) return ;
	y_pwm_value=LIGHTLY_0P4;
	w_pwm_value=LIGHTLY_0P4;
	if(r_pwm_value<10)
		r_pwm_value++;
	else
	{
		if (battery_quantity==Electric_Low)
			disp_index=Disp_Battery_Low;    //White from OFF to  ON
		else
			disp_index=Disp_Battery_Empty;    //White from OFF to  ON
	}
	r_light_timer=_200MS;
}
void vLed_Disp_Separate(void)  //30 second
{   
	  
	r_pwm_value=LIGHTLY_0P4;
	//w_pwm_value=LIGHTLY_1P4;
      w_pwm_value=LIGHTLY_1P4  ;
}

void vLed_Disp_pre_Separate(void)
{
/*
	if(w_light_timer!=0) return ;
       r_pwm_value=LIGHTLY_0P4;
	 if(	w_pwm_value==0)
	 	w_pwm_value=LIGHTLY_2P4;

	if(w_pwm_value>2)
		w_pwm_value--;
	else
	disp_index=Disp_Separate;    //White from OFF to  ON
	w_light_timer=_100MS;
	*/
	r_pwm_value=LIGHTLY_0P4;
	w_pwm_value=LIGHTLY_4P4;
	if(!disp_timer)
		{
		if(battery_charge==_Charge_Full)
			{
			//disp_index=Disp_Charge_Full; 
		      //  disp_timer=10;
		        disp_index=Disp_Docked; 
			}
		else
			{
		           disp_index=Disp_Docked;    //White from OFF to  ON
			}
		}
}
void Wireless_Display_Test_Mode(void)
{
       static u8 test_cnt=0;
  	if(r_light_timer!=0) 
		return ;
	test_cnt++;
	y_pwm_value=LIGHTLY_2P4;
	r_pwm_value=LIGHTLY_2P4;
	w_pwm_value=LIGHTLY_2P4;
	r_light_timer=_100MS;
	if(test_cnt>10)
	    System_PowerOff();
}
	
void vLed_Light_Process(u8 pwm_value)
{
       if(STB_FLAG)
	return;

	if(r_pwm_value>pwm_value)
		GPIO_WriteLow(GPIOA,GPIO_PIN_4);
	else
		GPIO_WriteHigh(GPIOA,GPIO_PIN_4);


	if(w_pwm_value>pwm_value)
		GPIO_WriteLow(GPIOA,GPIO_PIN_5);
	else
		GPIO_WriteHigh(GPIOA,GPIO_PIN_5);


}
void vLed_Display_Upg(u8 flash_type)
{
	
	w_pwm_value=LIGHTLY_0P4;
	r_pwm_value=LIGHTLY_0P4;
	if(flash_type%2==0)
		r_pwm_value=LIGHTLY_2P4;
	else if(flash_type%2==1)
		w_pwm_value=LIGHTLY_2P4;

}
void vLedTick_10Ms(void)
{
	if(r_light_timer) 
	r_light_timer--;
	if(y_light_timer) 
	y_light_timer--;
	if(w_light_timer) 
	w_light_timer--;
	
	if(b_light_timer) 
	b_light_timer--;
	if(s_light_timer) 
	s_light_timer--;
}




void vLed_Disp_Sod_Stereo(void)
{
    s_pwm_value=LIGHTLY_4P4;
    b_pwm_value=LIGHTLY_4P4;
}


void vLed_Disp_Standby(void)
{
    w_pwm_value=LIGHTLY_0P4;
    r_pwm_value=LIGHTLY_0P4;
}


void Led_Display_Loop(void)
{

   //if(standby_flag)
   //	{
   	//vLed_Disp_Standby();
  	//return;
   //	}
   if(led_test_time)
   	return;
   if(led_test_time1)
   	return;
	switch(disp_index)
	{


	case Disp_None:
	break;
	//Dis Connect
	case Disp_Dis_Connect:
		vLed_Disp_DisConnect();
	break;
	//Parring
	case Disp_Connecting:
		vLed_Disp_Parring();
	break;
	case Disp_Docked:
		vLed_Disp_Docked();
	break;
	case Disp_UnDocking:
		vLed_Disp_UnDocking();
	break;
	case Disp_Separate:
	       vLed_Disp_Separate();
	break;
	//Charging
	case Disp_Charging:
		vLed_Disp_BatteryCharge();
	break;
	//Battery Status Disp
	case Disp_Battery_Low:
		vLed_Disp_BatteryLow();
	break;
	
	case Disp_Battery_Low_UnDocking:
		vLed_Disp_UnDocking_BatteryLow();
	break;

	case Disp_Battery_Low_Docking:
	case Disp_Docking:
		vLed_Disp_Docking();

	break;
	case Disp_Battery_Empty:
		vLed_Disp_BatteryEmpty();
	break;
	case Disp_Battery_Err:
	        vLed_Disp_BatteryCharge_TimeOut();
	break;

	case Disp_Charge_Full:
		vLed_Disp_Charge_Full();
	break;
	
	case Disp_Test_MODE:
	   Wireless_Display_Test_Mode();
	break;

	case Disp_USB_charge:
	      vLed_Disp_USB_BatteryCharge();
	break;

   	case Disp_pre_Separate:
	      vLed_Disp_pre_Separate();
	break;
	case Disp_standby:

	       vLed_Disp_Standby();  
	break;
 	 	
	case Disp_Upg:
	break;
	default:
	break;

	}

	



}
	


