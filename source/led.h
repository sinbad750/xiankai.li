#ifndef _LED_H
#define _LED_H



#define LIGHTLY_0P4     0
#define LIGHTLY_1P20   1
#define LIGHTLY_2P20   2
#define LIGHTLY_3P20   3
#define LIGHTLY_4P20   4

#define LIGHTLY_1P4     5
#define LIGHTLY_2P4     10
#define LIGHTLY_3P4     15
#define LIGHTLY_4P4     20


#define _100MS     20
#define _200MS    50
#define _300MS      60
#define _400MS       80
#define _500MS        100
#define _600MS        120
#define _700MS        140
#define _800MS       160
#define _900MS        180
#define _1SEC          400
#define _2SEC          400
#define _30SEC        6000

typedef enum
{
	Disp_None=0x00,
	//Dis Connect
	Disp_Dis_Connect,
	Disp_Connecting,      //Paring
	//Connected & Charged 
	Disp_Docking,
	Disp_Docked,
	Disp_UnDocking,
	Disp_Separate,
	
	//Charging
	Disp_Charging,
	
	//Battery Status Disp  Wait Charge
	Disp_Battery_Low_UnDocking,
	Disp_Battery_Low_Docking,
	Disp_Battery_Low,
	Disp_Battery_Empty,
	
	Disp_Battery_Err,
	//Disp Upgrade
	Disp_Charge_Full,
	Disp_Test_MODE,
        Disp_BT_connect,
        Disp_SOD_Stereo,
        Disp_USB_charge,
        Disp_standby,
        Disp_pre_Separate,
	Disp_Upg
}_DispType;

extern _DispType disp_index;
extern u8 disp_timer;


void vLed_Disp_BatteryEmpty(void);
void vLed_Light_Process(u8 pwm_value);
void vLedTick_10Ms(void);
void Wireless_State_Process(void);

//Wireless
void vLed_Disp_DisConnect(void);
void vLed_Disp_Connect(void);
void vLed_Disp_Parring(void);
//Battery Status
void vLed_Disp_BatteryLow(void);
void vLed_Disp_BatteryFull(void);
void vLed_Disp_BatteryCharge(void);
void vLed_Disp_BatteryCharge_TimeOut(void);

void vLed_Display_Upg(u8 flash_type);

void Led_Display_Loop(void);

void vLed_Disp_USB_BatteryCharge(void);

void vLed_Disp_Standby(void);

void vLed_Disp_pre_Separate(void);
extern u8 r_pwm_value; 


extern u8 y_pwm_value;


extern u8 w_pwm_value;


extern u8 b_pwm_value;


extern u8 s_pwm_value;


#endif
