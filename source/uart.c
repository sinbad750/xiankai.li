 #include "stm8s_type.h"
#include "stm8s_uart1.h"
#include "stm8s_wwdg.h"
#include "upg.h"
#include "wireless_func.h"
#include "led.h"
#include "uart.h"
#include "config.h"
#include "main.h"

void initUart(UART1_Mode_TypeDef type)
{	
	UART2_Init((u32)9600, UART2_WORDLENGTH_8D, UART2_STOPBITS_1, UART2_PARITY_NO,     UART2_SYNCMODE_CLOCK_DISABLE, type);
      // UART2_Init((u32)57600, UART2_WORDLENGTH_8D, UART2_STOPBITS_1, UART2_PARITY_NO,     UART2_SYNCMODE_CLOCK_DISABLE, type);

	//UART2_Init(9600,UART2_WORDLENGTH_8D, UART2_STOPBITS_1, UART2_PARITY_NO, UART2_SYNCMODE_CLOCK_DISABLE, UART2_MODE_TXRX_ENABLE);
    
	UART2_ITConfig(UART2_IT_RXNE_OR, ENABLE);


	UART2_Cmd(ENABLE);
}


     

void myputc(u8 c)
{
 u16 j;
 	j = 30000;
	/* Write a character to the UART1 */
	UART2_SendData8(c);
	/* Loop until the end of transmission */
	//while (UART2_GetFlagStatus(UART2_FLAG_TXE) == RESET);
	while ((UART2_GetFlagStatus(UART2_FLAG_TC) == RESET)&&j)
		{
                	//Wait_For_mSec(5); // speed up 
		       j--;
	       }
		
	//UART2_FLAG_TC
}


void Wait_For_mSec(u16 n)
{
	u16 m;
	while(n--)
	{

		for(m=0;m<2500;m++)
				;
	}
}

void myputstr(unsigned char  *pFmt)
{

    unsigned char  ucBff; // character buffer
    while (1)
    {
	ucBff = *pFmt; // get a character
	if (ucBff == '\0') // check end of string
	break;
	myputc(ucBff);  // put a character
	pFmt++;           // next
    }                          // while
}
#ifdef DEBUG_USE_UART
void myprintf(char *str, unsigned int value)
{
    char sendData;//=Send_MsgValue;
  while (sendData=*(str++))
    {
    	if (sendData==(char)'%') // %
        {
        	sendData=*(str++);
          	if (sendData==(char)'d' || sendData==(char)'x') // d
            {
            	if (value)
                {
                	u8 noneZero=0;
                  	unsigned int divider=10000;
                  	char dispValue;

                  	if (sendData==(char)'x')
		    			divider=0x1000;
                  	while (divider)
				    {
				    	dispValue=value/divider;
				      	value-=dispValue*divider;
		            	if (dispValue)
		          			noneZero=1;
		            	if (noneZero)
		                {
		                	if (dispValue>9)
		     					dispValue+=55;
		   					else
		        				dispValue+=0x30;
		 					myputc(dispValue);
		  				}
						if (sendData==(char)'d')
		      				divider/=10;
		      			else
		     				divider/=0x10;
		    		}
                }
              	else
  	        		myputc('0');
  	    	}
  		}
      	else
        	myputc(sendData);
    }
}
#endif
u8 check_sum;
u16 block_num;
u8 rx_buff[130];
u8 rx_count;
_Upg_State up_state=UP_STATE_IDLE;

void Updata_Start(void)
{
	block_num=0x00;
	rx_count=0x00;
	up_state=UP_STATE_START;


	myputc('U');
}
u8  Upg_Device(void)
{
	if(rx_buff[0]!='U') return UPG_DEVICE_NONE;
	if(rx_buff[1]!='P') return UPG_DEVICE_NONE;
	if(rx_buff[2]!='G') return UPG_DEVICE_NONE;
	if(rx_buff[3]!='R') return UPG_DEVICE_NONE;
	
	if(rx_buff[4]=='M') 
		return UPG_MCU;
	else if(rx_buff[4]=='W') 
		return UPG_WIRELESS;
	
	else if(rx_buff[4]=='A') 
		return ASK_VER;
	
	else
		return UPG_DEVICE_NONE;
}
bool Is_Connect_Code(void)
{
        if(rx_buff[0]=='p')
			return TRUE;
		return FALSE;

}
void vClear_RxBuff(void)
{
	u8 i;
	for(i=0;i<130;i++)
		rx_buff[i]=0xff;
}
void vRxData_Start(void)
{
	rx_count=0x00;
	check_sum=0x00;
	up_state=UP_STATE_RXBYTE_CNT;
}
bool vUpg_Over(void)
{
	if(block_num<1024)  //768   96k
	return FALSE;
	return TRUE;
}


#ifdef UPG_WIRELESS_MOUDLE
void Upgrade_RxData_Process(u8 rxdat)
{
          switch(up_state)
		{
		case UP_STATE_START:
		if(rxdat==':')
			vRxData_Start();
		break;
		case UP_STATE_RXBYTE_CNT:
		   if(rx_count<0x80)   /*128  Byte Input*****/
		   {
			rx_buff[rx_count]=rxdat;
			check_sum+=rxdat;
			rx_count++;
		   }
		   if(rx_count==0x80)  /*128 Byte Ok****/
			   up_state=UP_STATE_CHECKSUM;
		   break;
		   	
		   case UP_STATE_CHECKSUM:
			rx_buff[rx_count]=rxdat;
			if(check_sum==rxdat)   /*Check OK*/
			{
				Wireless_Tx_Upgrade(rx_buff);
				block_num++;
				vLed_Display_Upg(block_num);
				if(vUpg_Over())
				{
					myputc('#');
					up_state=UP_STATE_IDLE;
					GPIO_Init(UART_Port, UART_Port_TX_Pin, GPIO_MODE_IN_FL_NO_IT);  /*for uart 2 tx***/
						
	                           UART2_DeInit();

                                  initUart(UART2_MODE_RX_ENABLE);
					Wireless_Reset();
					//WWDG_SWReset();
					break;
				}
				else
					myputc('.');
			}
			else                                         /*Check Err Request Resend*/
				myputc('k');
			up_state=UP_STATE_START;
			break;
			
			case UP_STATE_IDLE:
			break;
		}
}

void Wireless_Enter_Upgrade(void)
{  

        UART2_DeInit();
        initUart(UART2_MODE_TXRX_ENABLE);
	 vClear_RxBuff();
	 Wireless_Upg_Init();
	
}
#endif



void  MCU_Upgrade(void)
{
        UART2_Cmd(DISABLE);

	FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
	/* Unlock Data memory */
	FLASH_Unlock(FLASH_MEMTYPE_DATA);
	/* Program complement value (of previous read byte) at previous address + 1 */
	FLASH_ProgramByte((0x4050), 'U');
	/*Lock Data memory */
	FLASH_Lock(FLASH_MEMTYPE_DATA);
	
	//Wait_For_mSec(100);
	Wireless_Reset();
	
	WWDG_SWReset();
}

void Upgrade_Loop(void)
{
	if(rx_count==0x05)
	{
     
#ifdef UPG_WIRELESS_MOUDLE
		if(Upg_Device()==UPG_WIRELESS)
			Wireless_Enter_Upgrade();
#endif
	
		if(Upg_Device()==UPG_MCU)
			MCU_Upgrade();
		if(Upg_Device()==ASK_VER)
			{
			Send_Surr_Info();
			rx_count=0;
			}
	if((Is_Connect_Code())&&(up_state==UP_STATE_IDLE))
		{
			Wireless_Write_ConectCode();
			rx_count=0;
		}	
	
	}
}




