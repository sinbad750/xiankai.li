#ifndef _UART_H
#define _UART_H

//#define DEBUG_USE_UART  
#ifdef DEBUG_USE_UART
#define dputc(x)       myputc(x)
#define dputstr(x)    myputstr(x)
#define dprintf(x,y)   myprintf(x,y)
#else
#define dputc(x)    
#define dputstr(x)    
#define dprintf(x,y)  
#endif

typedef enum
{
	UP_STATE_IDLE,                     
	UP_STATE_START,                 
	UP_STATE_RXBYTE_CNT,         
	UP_STATE_CHECKSUM       
}_Upg_State;

#define UPG_DEVICE_NONE  0x00
#define UPG_MCU                    0x01
#define UPG_WIRELESS         0x02
#define ASK_VER                      0x03


extern @near 
u8 rx_buff[130];
extern @near
u8 rx_count;
extern _Upg_State up_state;


void initUart(UART2_Mode_TypeDef type);
void myputc(u8 c);
void Upgrade_Loop(void);
void Upgrade_RxData_Process(u8 rxdat);
void Wait_For_mSec(u16 n);
void Updata_Start(void);

void  MCU_Upgrade(void);
#ifdef DEBUG_USE_UART
void myprintf(char *str, unsigned int value);
void myputstr(unsigned char  *pFmt);
#endif

#endif
