#ifndef _CONFIG_H
#define _CONFIG_H

#define UPG_WIRELESS_MOUDLE

#include "stm8s.h"


/*
wireless dock/undock state :  Link_State   : link on , link off


wireless pairing state :  Wireless_State : 
typedef enum
{
	_Wireless_None_Connect,
	_Wireless_ConnectTx,
	_Wireless_Paring,
	_Wireless_standby
}_Wireless_Status;


charge status: 
typedef enum
{
	_Charge_None=0x00,   //无电池&   Link Off
	_Charge_Ing=0x01,
	_Charge_Full,
	_Charge_TimeOut,
	_Charge_Unknown    //中间状态
}_Charge_Status;

*/
#endif