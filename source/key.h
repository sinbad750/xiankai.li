#ifndef _key_H
#define _key_H



extern bool key_was_ready;

extern bool BT_R_nfc_disable_flag;
extern bool i2c_buzy_flag;
extern u8 key_command;
extern bool STB_FLAG;
extern bool bt_do_not_reconnect_flag;
extern u8 shor_key_time;
extern u8 shor_key;
void Power_onoff_board(u8 onoff);
void Key_Service(void);
void Key_Scan(void);
void Power_Off_direct(void);

#endif

