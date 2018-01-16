#ifndef _CHARGE_H
#define _CHARGE_H

   

#define Battery_STAT1_PIN_STATUS()             GPIO_ReadInputPin(GPIOB,GPIO_PIN_7)
#define Battery_STAT2_PIN_STATUS()             GPIO_ReadInputPin(GPIOB,GPIO_PIN_7)

#define Battery_Charge(able)                     if(able==ENABLE) GPIO_WriteHigh( GPIOA, GPIO_PIN_2);\
	                                                                  else GPIO_WriteLow( GPIOA, GPIO_PIN_2)


//#define Main_Link_Status()                          GPIO_ReadInputPin(GPIOA,GPIO_PIN_3)
#define Main_Link_Status()                          GPIO_ReadInputPin(GPIOB,GPIO_PIN_5)

///////////////////////////////////////////////////////////////////////////////

extern u16 adc_value;
//////////////////////////////////////////////////////////////////////////////////
typedef enum
{
	Charge_Battery_None=0x00,
	Charge_Battery_Complete,
	Charge_Battery_Ing=0x02,
	Charg_Battery_Err
}_Charge_Type;



																	  
typedef enum
{
	_Charge_None=0x00,   //无电池&   Link Off
	_Charge_Ing=0x01,
	_Charge_Full,
	_Charge_TimeOut,
	_Charge_Unknown    //中间状态
}_Charge_Status;
													  
typedef enum
{
	Electric_Need_Cut=0x01,  // 6.6v
	Electric_Empty=0x02,       //7.2V
	Electric_Low,                       //<7.8V
	Electric_Near_Full,            //>7.8V <8.4
	Electric_Full                      //8.4V
}_Electric_Quantity;


extern _Electric_Quantity battery_quantity;
extern _Charge_Status battery_charge;
extern u8 system_800ms_tick;
extern u16 voltage;

void Battery_Status_Detect(void);
void Detect_Main_Supply_Status(void);
void Charge_Manager_Loop(void);  // loop every 1 second
void Get_Battery_Status(void);
void Get_Battery_temper_Status(void);

#endif
