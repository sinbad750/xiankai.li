#include "stm8s_type.h"
#include "stm8s_type.h"
#include "stm8s_exti.h"
#include "uart.h"
#include "charge.h"
#include "led.h"
#include "wireless_func.h"
#include "main.h"
#include "key.h"
#include "Tas5711.h"

_Charge_Status battery_charge=_Charge_TimeOut;
u8 flag_charge_ing=1;
u8 system_800ms_tick=0;
u8 need_cut_time=0;
u8 need_cut_time2=0;
 _Link_Status  Link_State=Link_Unknow;
_Electric_Quantity battery_quantity=Electric_Full;
extern void  Voltage_Detect(u16 adc_value);



//#define  _4P1V     932
#define  _4P1V     940
#define  _3P6V     806 // 820
#if 0
#define  _3P5V     775
#define  _3P4V     765 
#else
#define  _3P5V     800
#define  _3P4V     790
#endif



/*   放电
3.40-----757
3.50-----773
3.60 -----800
3.70----- 820
3.80----- 840
3.90----- 860
4.00----- 888
4.10----- 913
4.15----- 939

*/

/*   充电
3.00-----670
3.67 -----820
3.77----- 845
3.83----- 857
3.90----- 870
4.00----- 895
4.10----- 932
4.20----- 944

*/



/*   for harman 放电 0.5c  
4.201    100%
3.676      75%
3.555      60% 
3.451      45%
3.381      30%
3.304      15%
3.209       5%
2.997       0%
*/



/*   for harman 充电 0.5c  
4.201    100%
4.167      75%
4.012    60% 
3.902     45%
3.837      30%
3.778     15%
3.677       5%
2.998       0%
*/

u16 voltage=10;
u16 vol_buff[10];
u8 vol_cnt;
/*Detect Point Voltage;  U1= 33*adc_value/1024********/
/*Battery Voltage;U2 =U1*(390+220)/220  *****************/
void Calculate_Voltage(u16 adc_value)
{
	u16 U1,U2;
	u16 sum=0x00;
	//U1=34*adc_value/1023;
	U1=33*adc_value/1023;
	U2=U1*(604+220)/600;
	vol_buff[vol_cnt]=U2;
	vol_cnt++;
	if(vol_cnt>9)
	{
		u8 i;
		for(i=0;i<10;i++)
		sum+=vol_buff[i];
			voltage=sum/10;
		vol_cnt=0x00;
	}
}


void  Voltage_Detect(u16 adc_value)
{
	_Electric_Quantity quantity;
	static _Electric_Quantity prev_quantity;
	static u8 times=0x00;
	
	if(adc_value<_3P4V)   //6.6
		quantity=Electric_Need_Cut;

	
	else if(adc_value>=_3P4V&&adc_value<_3P5V) 
		quantity=Electric_Empty;
	
	else if(adc_value>=_3P5V&&adc_value<_3P6V) 
		quantity=Electric_Empty;
	         
	else if (adc_value>=_3P6V&&adc_value<_4P1V)     //7.8V 
		quantity=Electric_Near_Full;

	else if (adc_value>=_4P1V)     //7.8V 
		quantity=Electric_Full;
	
	if(prev_quantity!=quantity)
	{
		times=0x00;
		prev_quantity=quantity;
	}
	else
	{
		times++;
		if(times>2)
			{

			if(battery_quantity>quantity)
				battery_quantity=quantity;
			}
	}
	Calculate_Voltage(adc_value);
}


void Battery_Charge_Status(void)    //Every 800MS loop a time.
{
		static u8 prev_pin2;
		u8 cur_pin2;
			u8 i;
	
	
					  if(!Battery_Charge_Pin_Status())
					{

					  if( charge_time>200)
					  	{
						battery_charge=_Charge_Ing;       //Charging
						//if(!full_charge_flag)
						if(!flag_charge_ing)
							{
						flag_charge_ing=1;
						charge_changeto_disconent_flag=0;
							}
					  	}
				
					}

			  

			          else
			          {

                      
			
						battery_charge=_Charge_None;
						if(flag_charge_ing)
							{
						flag_charge_ing=0;
						charge_changeto_disconent_flag=0;

						if(Wireless_State==_Wireless_None_Connect)
							{
                                                   if(OFF_USB_CHARGE_FLG)
                                                   	{
                                                   	 AMP_MUTE(ON);
                                                      Power_off_ready(ON);
							       Wait_For_mSec(1000);
							        standby_flag=1;
								 OFF_USB_CHARGE_FLG=0;
                                                   	}
						       }

						
							if(Link_State==Link_None)
						     {

						battery_quantity=Electric_Full;
						Get_Battery_temper_Status();
						for(i=0;i<8;i++)
						{
							Get_Battery_Status();
							Wait_For_mSec(5);
						}

						//if(battery_quantity<=Electric_Empty)
						//    disp_index=Disp_Battery_Empty;

						}
												
							}


				#if 0
		                          if(Link_State==Link_None)
		                          	{
                                           if( USB5V_Pin_Status() )
                                           	{
                                                   	if(battery_charge!=_Charge_Full)
					                         {
						                      battery_charge=_Charge_Full;
					                            flag_charge_ing=0;
			
					                         }
											
                                           	 }
                                      
						}
								  #endif
										
					/*		   
					if(battery_charge!=_Charge_Full)
					{
						battery_charge=_Charge_Full;
						flag_charge_ing=0;
						Report_Charge_Status(flag_charge_ing);
					}*/
					
	
			          }
}
void Battery_Status_Detect(void)
{
	if(Link_State==Link_On)
	{

	    	if(!standby_charge_flag)
	              CHARGE_EN(OFF);
			
		if(!Main_Link_Status())
		  {
		      link_to_dislinktime++;
			 if(link_to_dislinktime>20)
			  	{
			       Link_State=Link_None;
                           Batt_16v_SW(ON);
				CHARGE_EN(ON);
				link_to_dislinktime=0;
			       disp_timer=1;
		  	      }
			 else
			 	{
			 	 disp_timer=3;
			 	  return;
			 	}
			flag_charge_ing=0;
			//Report_Charge_Status(flag_charge_ing);
		
			//Wait_For_mSec(50);
		
	         }
	}		
	else
	{
		if(Main_Link_Status())
			{
			Link_State=Link_On;
			   Batt_16v_SW(OFF);
			link_to_dislinktime=0;
			if(standby_charge_flag)
			 CHARGE_EN(ON);
			else
			 CHARGE_EN(OFF);	
			//Wait_For_mSec(10);
			// if standby fg is 1 , then 0,????
			if(standby_flag)
				{
		           standby_flag=0;
		   AMP_MUTE(OFF);	
		   Batt_16v_SW(ON);
		   System_Standby(ON);
				}
			
			}
		else
		{
			Link_State=Link_None;
		}
		
	}
}

u16 adc_value;


void Get_Battery_Status(void)
{
	//u16 adc_value;
	ADC1_ClearFlag();
       Init_ADC9();
      while(ADC1_GetFlagStatus()==RESET) ;
         ADC1_ClearFlag();

	adc_value=ADC1_GetConversionValue();
	Voltage_Detect(adc_value);
}

void Get_Battery_temper_Status(void)
{
	ADC1_ClearFlag();
       Init_ADC1();
       while(ADC1_GetFlagStatus()==RESET) ;
       ADC1_ClearFlag();
   
     temper_value=ADC1_GetConversionValue();

}


void Charge_Manager_Loop(void)  // loop every 
{
        Battery_Status_Detect();
		
	if(system_800ms_tick>40)   //800ms  //35
	{    
		       system_800ms_tick=0x00;
		        Get_Battery_Status(); 
			  Get_Battery_temper_Status();
		if(Link_State==Link_On)
		{    
		              
	        
			 	
	         Battery_Charge_Status();
	         need_cut_time=0;
			  	
		}
		else
		{		 
			 Battery_Charge_Status(); //5v usb charge happen		
		      if(	flag_charge_ing==0)
		   	{
		   	
			if(battery_quantity==Electric_Need_Cut)
			 {
                          if(Wireless_State==_Wireless_None_Connect)                            
                          	{
                          	 need_cut_time++;
			          if(need_cut_time>=5)
				    {				
			                AMP_MUTE(ON);
                                   Power_off_ready(ON);
				         need_cut_time=0;
				     }
                          	}
                          else
                          	     {
                          	       need_cut_time++;
                          	      if(need_cut_time>=3)
                          	      	{
                          	        need_cut_time=0;
			              AMP_MUTE(ON);
                                  Power_off_ready(ON);
                          	      	}				  
                          	      }
				}
		         }
		}
	}
}

