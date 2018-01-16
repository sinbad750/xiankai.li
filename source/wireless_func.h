#ifndef _WIRELESS_FUNC_H
#define _WIRELESS_FUNC_H

#define WIRELESS_INVALID_DATA                  0xFF 
#define WIRELESS_INT_PIN_STATUS             GPIO_ReadInputPin(GPIOE,GPIO_PIN_3)

#define Battery_Quanity        0xfe  //Parameter Hi Parameter Low

/*MCU need recived infomation from Wireless Rx Module*/
typedef enum
{
  _Info_None=0x00,
  _Info_Wireless_Connect_Staus,
  _Info_Link_Status,
  _Info_Battery_Status,
  _Info_Tx_Ver,
 _Info_Quanity,
 _Info_Rx_Ver,
  _Info_mute,               //0X07
   _Info_vol,                //0X08
   _Info_drc,                //0X09
    _Info_init_data,     //0X0A
    _Info_eq_filter,       //0X0B
    _Info_wireless_standby, //0x0c
    _Info_wireless_poweroff, //0X0d
     _Info_wireless_poweron  //0X0e
}_Wireless_Info_Type;

//0x01 parameter
typedef enum
{
	_Wireless_None_Connect,
	_Wireless_ConnectTx,
	_Wireless_Paring,
	_Wireless_standby
}_Wireless_Status;
//0x02 parameter
typedef enum
{
	Link_On= 0x00,
	Link_None= 0x01,
	Link_Unknow
}_Link_Status;

extern _Wireless_Status Wireless_State;
extern _Link_Status  Link_State;

void Wireless_RxInfoProcess(void);
void Link_MainUnit_State_Process(void);
void Battery_State_Process(void);
void Battery_Quantity(u16 adc_value);
void System_PowerOff(void);
void Report_Charge_Status(u8 charge);
void Wireless_Write_ConectCode(void);
void Ask_Wireless_Rx_Version(void);
void Send_Surr_Info(void);
void Notification_PowerOff(void);


void Change_to_Strereo_mode(void);

void Wireless_Write_SOD_ConectCode(void);
void Wireless_Write_main_ConectCode(void);
void info_Wireless_Rx_BT_state(u8 bt_sod);
void Save_default_Code_To_Eeprom(void);
void  info_Stereo_Wireless_Rx_OFF(void);
void info_Tx_Wireless_Sod_BT_mode(u8 ON_OFF);

void info_Stereo_Wireless_Rx_mute_OFF(u8 mute);

void  Wireless_Goto_Pairing(void);


void  Rest_Pairing_Code(void);

void clear_rx_buffuer(void);



#endif

