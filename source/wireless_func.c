#include "config.h"
#include "stm8s_type.h"
#include "stm8s_gpio.h"
#include "main.h"
#include "charge.h"
#include "uart.h"
#include "led.h"
#include "i2c.h"
#include "wireless_func.h"
#include "Tas5711.h"
#include "key.h"
#include "upg.h"

#include"string.h"
_Wireless_Status Wireless_State=_Wireless_None_Connect;
u8 coco_buffer[4];
char coco_char_buffer[8];
u8  prev_charge_status=99;

u8  factory_test_flag=0;

void System_PowerOff(void)
{
    u8 tx_buff[8];
    tx_buff[0]=0x88;
    I2C_8052_Write_Buf(tx_buff,8);
}
void Notification_PowerOff(void)
{
    u8 tx_buff[8];
    tx_buff[0]=0xAA;
    tx_buff[1]=0x01;
    tx_buff[2]=0x02;
    I2C_8052_Write_Buf(tx_buff,8);
}

void Change_to_Strereo_mode(void)
{
    u8 tx_buff[8];
    tx_buff[0]=0x08;
    I2C_8052_Write_Buf(tx_buff,8);

    Wireless_Write_SOD_ConectCode();  //0805
}
void Ask_Wireless_Rx_Version(void)
{
    u8 tx_buff[8];
    tx_buff[0]=0xcc;
    I2C_8052_Write_Buf(tx_buff,8);
}


void info_Wireless_Rx_BT_state(u8 bt_sod)
{
    u8 tx_buff[8];
    tx_buff[0]=0x0A;
    tx_buff[1]=bt_sod;
    I2C_8052_Write_Buf(tx_buff,8);
}


void info_Stereo_Wireless_Rx_OFF(void)
{
    u8 tx_buff[8];
    tx_buff[0]=0x04;
    tx_buff[1]=0x00;
    tx_buff[2]=0x03;
    I2C_8052_Write_Buf(tx_buff,8);
    Wait_For_mSec(200);
}

void info_Stereo_Wireless_Rx_mute_OFF(u8 mute)
{
    u8 tx_buff[8];
    tx_buff[0]=0x02;
    tx_buff[1]=mute;
    tx_buff[2]=mute;
    I2C_8052_Write_Buf(tx_buff,8);
    Wait_For_mSec(100);
}


void info_Tx_Wireless_Sod_BT_mode(u8 ON_OFF)
{

    u8 tx_buff[8];
    tx_buff[0]=0xDD;
    tx_buff[1]=ON_OFF;
    I2C_8052_Write_Buf(tx_buff,8);
    //Wait_For_mSec(100);
}



void clear_rx_buffuer(void)
{
    u8 tx_buff[8];
    tx_buff[0]=0x66;

    if(I2C_8052_Write_Buf(tx_buff,8))

    {
        //Wireless_Reset();
    }

}


void info_FCC_mode(void)
{
    u8 tx_buff[8];
    tx_buff[0]=0x12;
    I2C_8052_Write_Buf(tx_buff,8);
}
void Save_Connect_Code_To_Eeprom(u8 *rx_code)
{
    FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
    /* Unlock Data memory */
    FLASH_Unlock(FLASH_MEMTYPE_PROG);
    FLASH_Unlock(FLASH_MEMTYPE_DATA);
    /* Program complement value (of previous read byte) at previous address + 1 */
    FLASH_ProgramByte((0x4000), rx_code[1]);
    /*Lock Data memory */
    FLASH_ProgramByte((0x4001), rx_code[2]);

    FLASH_ProgramByte((0x4002), rx_code[3]);

    FLASH_Lock(FLASH_MEMTYPE_PROG);
    FLASH_Lock(FLASH_MEMTYPE_DATA);

    Wait_For_mSec(200);
}

void Save_default_Code_To_Eeprom(void)
{
    FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
    /* Unlock Data memory */
    FLASH_Unlock(FLASH_MEMTYPE_PROG);
    FLASH_Unlock(FLASH_MEMTYPE_DATA);

    /* Program complement value (of previous read byte) at previous address + 1 */
    FLASH_ProgramByte((0x4000), 0xE6);
    /*Lock Data memory */
    FLASH_ProgramByte((0x4001), 0x33);

    FLASH_ProgramByte((0x4002), 0xE6);
    FLASH_Lock(FLASH_MEMTYPE_PROG);
    FLASH_Lock(FLASH_MEMTYPE_DATA);

    Wait_For_mSec(100);
}


bool Connect_Code_Compare(u8 *rx_code)
{
    //FLASH_Unlock(FLASH_MEMTYPE_PROG);
    //FLASH_Unlock(FLASH_MEMTYPE_DATA);
    if((FLASH_ReadByte(0x4000)!=rx_code[1]) ||(FLASH_ReadByte(0x4001)!=rx_code[2]) ||(FLASH_ReadByte(0x4002)!=rx_code[3]))
        return TRUE;
    if((FLASH_ReadByte(0x4000)!=coco_buffer[1]) ||(FLASH_ReadByte(0x4001)!=coco_buffer[2]) ||(FLASH_ReadByte(0x4002)!=coco_buffer[3]))
        return TRUE;

    //FLASH_Lock(FLASH_MEMTYPE_PROG);
    //FLASH_Lock(FLASH_MEMTYPE_DATA);
    return FALSE;
}

void Wireless_Write_ConectCode(void)
{
    u8 checksum=0;
    u8 tx_buff[8];
    if((rx_buff[1]==0xff)&&(rx_buff[2]==0xff)&&(rx_buff[3]==0xff))
    {
        return;
    }
    if((rx_buff[1]==0x00)&&(rx_buff[2]==0x00)&&(rx_buff[3]==0x00))
    {
        return;
    }
    if((rx_buff[1]=='p')&&(rx_buff[2]=='p')&&(rx_buff[3]=='p'))
    {
        return;
    }
    if((rx_buff[1]=='w')&&(rx_buff[2]=='r')&&(rx_buff[3]=='o'))
    {
        if(rx_buff[4]=='n')
        {
            standby_charge_flag=0;
            Batt_16v_SW(ON);
            System_Standby(ON);
            AMP_MUTE(OFF);
            CHARGE_EN(OFF);
        }
        else if(rx_buff[4]=='f')
        {
            standby_charge_flag=1;

            AMP_MUTE(ON);
            Batt_16v_SW(OFF);
            System_Standby(OFF);

            CHARGE_EN(ON);
        }
        //Report_Charge_Status(flag_charge_ing);
        return;
    }
    checksum=(rx_buff[1]+rx_buff[2]+rx_buff[3]);

    if(checksum==rx_buff[4])
    {
        tx_buff[0]=0xBB;
        tx_buff[1]=rx_buff[1];
        tx_buff[2]=rx_buff[2];
        tx_buff[3]=rx_buff[3];

        //  led_test_time=4;
        // r_pwm_value=LIGHTLY_2P4;
        // w_pwm_value=LIGHTLY_2P4;

// UART2_ITConfig(UART2_IT_RXNE_OR, DISABLE); //FOR HUNGUP ISSUE
        if(Connect_Code_Compare(tx_buff))
        {
            I2C_8052_Write_Buf(tx_buff,8);
            Save_Connect_Code_To_Eeprom(tx_buff);
        }
    }
// UART2_ITConfig(UART2_IT_RXNE_OR, ENABLE);
// Report_Charge_Status(flag_charge_ing);
}


void Wireless_Write_SOD_ConectCode(void)
{
    u8 X,Y,Z;
    u8 tx_buff[8];
    FLASH_Unlock(FLASH_MEMTYPE_PROG);
    FLASH_Unlock(FLASH_MEMTYPE_DATA);
    X=FLASH_ReadByte(0x4000);
    Y=FLASH_ReadByte(0x4001);
    Z=FLASH_ReadByte(0x4002);
    FLASH_Lock(FLASH_MEMTYPE_PROG);
    FLASH_Lock(FLASH_MEMTYPE_DATA);
    tx_buff[0]=0xBB;
    tx_buff[1]=(X+1);
    tx_buff[2]=(Y+2);
    tx_buff[3]=(Z+3);
    I2C_8052_Write_Buf(tx_buff,8);
    //Wait_For_mSec(100);
}

void Wireless_Write_main_ConectCode(void)
{
    u8 X,Y,Z;
    u8 tx_buff[8];
    //FLASH_Unlock(FLASH_MEMTYPE_PROG);
    FLASH_Unlock(FLASH_MEMTYPE_DATA);
    X=FLASH_ReadByte(0x4000);
    Y=FLASH_ReadByte(0x4001);
    Z=FLASH_ReadByte(0x4002);
    //FLASH_Lock(FLASH_MEMTYPE_PROG);
    FLASH_Lock(FLASH_MEMTYPE_DATA);
    if((X==0)&&(Y==0)&&(Z==0))
    {
        X=0xE6;
        Y=0x33;
        Z=0xE6;
        Save_default_Code_To_Eeprom();
    }
    tx_buff[0]=0xBB;
    tx_buff[1]=X;
    tx_buff[2]=Y;
    tx_buff[3]=Z;
    I2C_8052_Write_Buf(tx_buff,8);
    Wait_For_mSec(100);
}

void Tx_Info(u8 *str,u8 ver)
{
    myputstr(str);
    myputc(ver/10+0x30);
    myputc(ver%10+0x30);
    myputstr("\r\n");
}

char  HexToASCII(unsigned char  data_hex)
{
    char  ASCII_Data;
    ASCII_Data=data_hex & 0x0F;
    if(ASCII_Data<10)
        ASCII_Data=ASCII_Data+0x30; //��0--9��
    else
        ASCII_Data=ASCII_Data+0x37;       //��A--F��
    return ASCII_Data;
}

void HexGroupToString(char *OutStrBuffer, unsigned char *InHexBuffer, unsigned int HexLength)
{
    unsigned int i, k=0;
    for(i=0; i<HexLength; i++)
    {
        OutStrBuffer[k++]=HexToASCII((InHexBuffer[i]>>4)&0x0F);
        OutStrBuffer[k++]=HexToASCII(InHexBuffer[i]&0x0F);
    }
    OutStrBuffer[k]='\0';
}

/*
BOOL StringToHexGroup(unsigned char *OutHexBuffer, char *InStrBuffer, unsigned int strLength)
 {
  unsigned int i, k=0;
  unsigned char HByte,LByte;
  if(strLength%2 !=0)
   return FALSE;

  for(i=0; i<strLength; i=i+2)
  {
   if(InStrBuffer[i]>='0' && InStrBuffer[i]<='9')
   {
    HByte=InStrBuffer[i]-'0';
   }
   else if(InStrBuffer[i]>='A' && InStrBuffer[i]<='F')
   {
    HByte=InStrBuffer[i]-'A' +10;
   }
   else
   {
    HByte=InStrBuffer[i];
    return FALSE;
   }
   HByte=HByte <<4;
   HByte = HByte & 0xF0;
   if(InStrBuffer[i+1]>='0' && InStrBuffer[i+1]<='9')
   {
    LByte=InStrBuffer[i+1]-'0';
   }
   else if(InStrBuffer[i+1]>='A' && InStrBuffer[i+1]<='F')
   {
    LByte=InStrBuffer[i+1]-'A' +10;
   }
   else
   {
    LByte=InStrBuffer[i];
    return FALSE;
   }
   OutHexBuffer[k++]=HByte |LByte;
  }
  return TRUE;
 }
*/
void Send_Surr_Info(void)
{
    factory_test_flag=1;
    UART2_DeInit();
    initUart(UART2_MODE_TXRX_ENABLE);
    Wait_For_mSec(10);
    Ask_Wireless_Rx_Version();
    myputstr("***************************?\r\n");
    myputstr("Harman JBL 5.1:\r\n");
    Tx_Info("MCU:",MCU_VER);
    Tx_Info("BAT:", voltage);
    myputstr("pair code: ");

    HexGroupToString(coco_char_buffer,coco_buffer,4);

    myputc(coco_char_buffer[2]);
    myputc(coco_char_buffer[3]);
    myputc(coco_char_buffer[4]);
    myputc(coco_char_buffer[5]);
    myputc(coco_char_buffer[6]);
    myputc(coco_char_buffer[7]);
    memset(coco_char_buffer,0xff,sizeof(coco_char_buffer));
    myputstr("\r\n");
    led_test_time=7;


}
void Wireless_RxInfoProcess(void)
{

    u8  data=0x30;

    if(i2c_buzy_flag==1)
    {
        return;
    }

    if(WIRELESS_INT_PIN_STATUS)
        return ;
    if(I2C_8052_Read_Buf(8))
    {
        //dputstr("\r\n Read Err");
        return;
    }
    if(RX_Data_recv_array[0]==0xAE)
    {
        //clear_rx_buffuer();
        return ;
    }
    switch(RX_Data_recv_array[0])
    {
    case _Info_None:
    {
        u8 tx_buff[8];
        tx_buff[0]=0x66;
        I2C_8052_Write_Buf(tx_buff,8);
    }
    break;
    case _Info_Wireless_Connect_Staus:





        if(!disp_timer)
        {
            if(RX_Data_recv_array[1])
            {
                if(RX_Data_recv_array[1]==1)
                {
                    Wireless_State=_Wireless_ConnectTx;

                    charge_changeto_disconent_flag=0;
                    connect_to_disconnecttime=0;
                    if(standby_flag==1)
                    {
                        standby_flag=0;
                        standby_flag_SOD=0;
                        System_Standby(ON);

                        if(Link_State==Link_None)
                            Batt_16v_SW(ON);

                        AMP_MUTE(OFF);

                    }
                }
                if(RX_Data_recv_array[1]==2)
                {
                    Wireless_State=_Wireless_Paring;
                    //connect_to_disconnecttime=0;
                }
                if(RX_Data_recv_array[1]==3)
                {
                    Wireless_State=_Wireless_standby;
                }
            }
            else
            {
                connect_to_disconnecttime++;
                if( connect_to_disconnecttime>3)
                {
                    if((Wireless_State==_Wireless_ConnectTx)&&(disp_index==Disp_USB_charge))

                    {
                        disp_index=Disp_Dis_Connect;
                        charge_changeto_disconent_flag=1;
                    }
                    Wireless_State=_Wireless_None_Connect;
                    connect_to_disconnecttime=0;
                }

            }

        }



        if(LR_Flag==0)
        {
            LR_Flag=RX_Data_recv_array[3];
        }

        if( Wireless_State!=_Wireless_Paring)
        {
            if(RX_Data_recv_array[4]||RX_Data_recv_array[5]||RX_Data_recv_array[6])
            {
                coco_buffer[1]=RX_Data_recv_array[6];
                coco_buffer[2]=RX_Data_recv_array[5];
                coco_buffer[3]=RX_Data_recv_array[4];

                if((FLASH_ReadByte(0x4000)!=coco_buffer[1]) ||(FLASH_ReadByte(0x4001)!=coco_buffer[2]) ||(FLASH_ReadByte(0x4002)!=coco_buffer[3]))
                {
                    if(!pairing_flag)
                        Wireless_Write_main_ConectCode();
                    else
                    {
                        Save_Connect_Code_To_Eeprom(coco_buffer);
                        pairing_flag=0;
                    }
                }

            }
        }

        break;
    case _Info_Tx_Ver:
        //dputstr("\r\n Tx Version");
        break;
    case _Info_Quanity:
        standby_flag_SOD=0;
        Report_Charge_Status(flag_charge_ing);
        break;
    case _Info_Rx_Ver:
    {
        if(factory_test_flag)
        {
            u8 rx_ver_h;
            //initUart(UART2_MODE_TXRX_ENABLE);
            rx_ver_h=RX_Data_recv_array[1];
            Tx_Info("RX:",rx_ver_h);
            disp_index=Disp_Test_MODE;
            UART2_DeInit();
            initUart(UART2_MODE_RX_ENABLE);
            factory_test_flag=0;
        }
    }
    break;


    case _Info_vol:
    {
        u8 vol;
        vol=RX_Data_recv_array[1];
        //TAS5711_vol(vol);

    }
    break;

    case _Info_mute:
    {
        u8 mute;
        mute=RX_Data_recv_array[1];
        //TAS5711_mute(mute);

    }
    break;


    case _Info_drc:
    {
        u8 drc;

        drc=RX_Data_recv_array[1];
//			Adjust5711_DRC_Value(drc);


    }
    break;


    case _Info_init_data:
    {
        u8 drc,mute,vol;


        vol=RX_Data_recv_array[1];
        mute=RX_Data_recv_array[2];
        drc=RX_Data_recv_array[3];




        Report_Charge_Status(flag_charge_ing);


    }

    break;

    case _Info_eq_filter:
    {
        u8 filter;

        filter=RX_Data_recv_array[1];

    }
    break;

    case 0xFB:

        break;

    case _Info_wireless_standby:
        //   AMP_MUTE(ON);
        //   Power_off_ready(ON);
        Wireless_State= _Wireless_standby;
        break;

    case _Info_wireless_poweroff:
        if(RX_Data_recv_array[1]==0xAB)
        {
            AMP_MUTE(ON);
            Power_off_ready(ON);
        }

        if(RX_Data_recv_array[1]==0x0B)
        {
            if(Link_State==Link_None)
            {

#if 1
                //   standby_flag=1;
                //  AMP_MUTE(ON);
                //  Batt_16v_SW(OFF);
                // System_Standby(OFF);
                standby_flag_SOD=1;
#endif
                //     standby_time=7;
                // 	r_pwm_value=LIGHTLY_0P4;
                //    w_pwm_value=LIGHTLY_0P4;
                //led_test_time1=8;
            }

        }
        break;

    case _Info_wireless_poweron:
        if(RX_Data_recv_array[1]==0xAA)
        {
            if(Link_State==Link_On)
            {
                standby_charge_flag=0;
                CHARGE_EN(OFF);
            }

        }
    default:
        break;
    }
}
void Report_Charge_Status(u8 charge)
{

    u8 data_buff[8];
    data_buff[0]=Battery_Quanity;
    data_buff[1]=battery_quantity;
    data_buff[2]=charge;
    data_buff[3]=MCU_VER;
    data_buff[4]=voltage;
    data_buff[5]=voltage;
    data_buff[6]=0x88;
    I2C_8052_Write_Buf(data_buff,8);

}

void Link_MainUnit_State_Process(void)
{
    static _Link_Status prev_link_status=Link_Unknow;
    if(prev_link_status!=Link_State)
    {
        if((Link_State==Link_None)&&(prev_link_status==Link_On))  //Undocking
        {
            u8 i;
            battery_quantity=Electric_Full;
            //for(i=0;i<25;i++)
            //	Get_Battery_Status();

            Batt_16v_SW(ON);
            System_Standby(ON);
            AMP_MUTE(OFF);


            if((battery_quantity==Electric_Empty)||(battery_quantity==Electric_Low))
            {
                disp_index=Disp_Battery_Low_UnDocking;
            }
            else
            {
                //disp_index=Disp_UnDocking;
                disp_index=Disp_pre_Separate;
            }

            disp_timer=2;
        }
        if((Link_State==Link_On)&&(prev_link_status==Link_None))  //Docking
        {
            disp_index=Disp_Docking;
            disp_timer=2;
        }
        prev_link_status=Link_State;
    }

    if(disp_timer)        return;

    switch(Link_State)
    {
    case Link_None:
        if(battery_charge==_Charge_Ing)
        {


            disp_index=Disp_USB_charge;

        }

        else  if((battery_quantity==Electric_Empty)||(battery_quantity==Electric_Need_Cut))
        {
            if(disp_index!=Disp_Battery_Empty)
                disp_index=Disp_Battery_Empty;
        }
        else  if(battery_quantity==Electric_Low)
        {
            //     if(disp_index!=Disp_Battery_Low)
            //        disp_index=Disp_Battery_Low;
            if(disp_index!=Disp_Battery_Empty)
                disp_index=Disp_Battery_Empty;
        }


        else
        {


            if(disp_index!=Disp_Separate)
                disp_index=Disp_pre_Separate;
        }
        break;
    case Link_On:


        if(prev_charge_status!=battery_charge)
        {
            //if((prev_charge_status==_Charge_Ing)&&(battery_charge==_Charge_Full))
            if(battery_charge==_Charge_Full)
            {
                disp_index=Disp_Charge_Full;
                disp_timer=10;      //10Second
            }
            prev_charge_status=battery_charge;
            break;
        }

        if(battery_charge==_Charge_Ing)
        {
            if(disp_index!=Disp_Charging);
            disp_index=Disp_Charging;
        }
        else
            //disp_index=Disp_Docked;
            disp_index=Disp_Separate;
        break;
    default:
        break;
    }
}


void Wireless_State_Process(void)
{

    switch(Wireless_State)
    {
    case _Wireless_standby:
    case _Wireless_None_Connect:  //Red Led On

#if 0
        //    if((!standby_flag)||(flag_charge_ing)||(Main_Link_Status() ))
        if(flag_charge_ing)
        {
            //disp_index=Disp_Dis_Connect;
            disp_index=Disp_USB_charge;
        }
        else
        {
            if(!standby_flag)
                disp_index=Disp_Dis_Connect;
            else
                disp_index=Disp_standby;
        }
#endif
        //    if(disp_index==Disp_USB_charge)
        //    	{
        //	 disp_index=Disp_Dis_Connect;
        //	 charge_changeto_disconent_flag=1;
        //   	}


        if(!flag_charge_ing)
        {
            if(!standby_flag)

            {
                if((battery_quantity==Electric_Empty)||(battery_quantity==Electric_Need_Cut))
                {
                    //  if(disp_index!=Disp_Battery_Empty)
                    //  disp_index=Disp_Battery_Empty;
                    disp_index=Disp_Dis_Connect;
                }
                else
                {
                    disp_index=Disp_Dis_Connect;
                }
            }
            else
                disp_index=Disp_standby;
        }
        break;
    case _Wireless_ConnectTx:
        Link_MainUnit_State_Process();
        break;
    case _Wireless_Paring:      //Red Led fast blink
        disp_index=Disp_Connecting;
        break;

    default:
        break;
    }
}





void  Wireless_Goto_Pairing(void)
{
    u8 tx_buff[8];
    tx_buff[0]=0xA1;
    I2C_8052_Write_Buf(tx_buff,8);

    b_pwm_value=LIGHTLY_4P4;
    Wait_For_mSec(1000);
    b_pwm_value=LIGHTLY_0P4;
}

void  Rest_Pairing_Code(void)
{
    Save_default_Code_To_Eeprom();
    Wireless_Write_main_ConectCode();
    r_pwm_value=LIGHTLY_4P4;
    Wait_For_mSec(1000);
    r_pwm_value=LIGHTLY_0P4;

}




