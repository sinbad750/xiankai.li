#include "config.h"
#include "main.h"
#include "BT830.h"
#include "key.h"
#include "Tas5711.h"
#include "stm8s_spi.h"

#include"string.h"
#include "uart.h"

u16 DEVICE_ID; 

u8 f_spistatus=0; 

u32 tSpiWriteAddr=0x00000000; 

//-------------------------------------------------------------------- 

u8 WREN=0X06;





u16 Flash_status_buf;



/* M25P64 SPI Flash supported commands */




#define WRSR      0x01  /* Write Status Register instruction */

#define WREN      0x06  /* Write enable instruction */

#define WRDI      0x04  /* Write disable instruction */

#define READ      0x03  /* Read from Memory instruction */

#define RDSR      0x05  /* Read Status Register instruction  */

#define RDID      0x9F  /* Read identification */

#define FAST_READ 0x0B  /* Fast read Status Register instruction  */

#define SE        0x20  /* Sector Erase instruction */

#define BE        0xD8  /* Bulk Erase instruction */

#define PP        0x02  /* Page prigrame instruction */

#define RES       0xAB  /* Sector Erase instruction */

#define WIP_FLAG      0x01  /* Write In Progress (WIP) flag */

#define DUMMY_BYTE    0xA5


//u8 TEXT_Buffer[10];

char  Tx_Buffer[]="KKK";
//char  Rx_Buffer[]="ddd";

#define  SIZE  sizeof(TEXT_Buffer)  

#define  SPI_FLASH_PAGESIZE     0x100

#define  FLASH_WriteAddress     0x000000

#define  FLASH_ReadAddress      FLASH_WriteAddress

#define  FLASH_SectorToErase    FLASH_WriteAddress

#define  E25Q80_FLASH_ID        0x1C13


#define  countof(a)   (sizeof(a) / sizeof(*(a)))

#define  BufferSize   (countof(Tx_Buffer)-1)

//--------------------------------------------------------------------- 

/*********************************************************************** 

函数名称：Spi_Flash_init 

函数功能：spi flash 初始化 

***********************************************************************/ 

u8 SPI_FLASH_SendByte(u8 tData)
{
   u8 DD;
   DD=SPI_DSP_SendByte(tData);
   return DD;
}


void SPI_FLASH_CS_LOW(void)
{
GPIO_WriteLow(GPIOE,GPIO_PIN_5);
}



void SPI_FLASH_CS_HIGH(void)
{
GPIO_WriteHigh(GPIOE,GPIO_PIN_5);
}


void Spi_Flash_init(void) 

{ 

DEVICE_ID = ReadDeviceID();//读取Flash ID 

Flash_ChipErase();//Flash 擦除 

} 




/*********************************************************************** 

函数功能：SPI延时 

***********************************************************************/ 

void SpiDelay(void) 

{ 

nop(); 

nop(); 

nop(); 

nop(); 

nop(); 

} 

/********************************************************************** 

函数名称：ReadDeviceID 

函数功能：读取Device ID 

入口参数：无 

出口参数： 

DeviceID-------->设备ID 

***********************************************************************/ 

u16 ReadDeviceID(void) 

{ 

u16 DeviceID=0; 

SPI_FLASH_CS_LOW(); 

f_spistatus=1; 

SPI_FLASH_SendByte(0x90); 

SPI_FLASH_SendByte(0x00); 

SPI_FLASH_SendByte(0x00); 

SPI_FLASH_SendByte(0x00); 

DeviceID = (SPI_FLASH_SendByte(0xff) << 8); 

DeviceID |= SPI_FLASH_SendByte(0xff); 

SPI_FLASH_CS_HIGH(); 

return DeviceID; 

} 

void vFlash_Read_Status(void)
{

	unsigned char read_statu_com=0x05;
	SPI_FLASH_CS_HIGH(); 


	SPI_FLASH_CS_LOW(); 

      Flash_status_buf=SPI_FLASH_SendByte(read_statu_com);

	SPI_FLASH_CS_HIGH(); 
		
}


/*
void vFlash_Write_Wrsr(void)  //Write Status Register
{

	unsigned char read_statu_com=0x01;
	
	SPI_FLASH_CS_HIGH();

	SPI_FLASH_CS_LOW(); 

       SPI_DSP_SendByte(read_statu_com); 
	  
	SPI_FLASH_CS_HIGH();
		
}


void vFlash_Write_256Bytes(unsigned int flash_addr,const unsigned char *data_addr,unsigned int  num)
{

	unsigned char write_com=0x02;
	u8 Flash_Write_addr[3]={0x00,0x00,0x00};

	Flash_Write_addr[2] = (u8)flash_addr;
	Flash_Write_addr[1] = (u8)(flash_addr>>8);
	Flash_Write_addr[0] = (u8)(flash_addr>>16);

	#if 1
	
	SPI_FLASH_WriteEnable();
	SPI_FLASH_CS_HIGH(); 
	vFlash_Write_Wrsr();
 	Wait_For_mSec(1);
	
	
	vFlash_Read_Status();
	
	SPI_FLASH_CS_LOW(); 
	#endif
	
	HAL_SPI_Transmit(&hspi2, (u8*)(&write_com), 1, 5000);	
	
	HAL_SPI_Transmit(&hspi2, (u8*)Flash_Write_addr, sizeof(Flash_Write_addr), 5000);	

	HAL_SPI_Transmit(&hspi2, (u8*)data_addr, num, 5000);

     SPI_FLASH_CS_HIGH(); 		
      // Delay_NMS(600);
}
*/



void SPI_FLASH_SectorErase(u32 SectorAddr)
{

  /* Send write enable instruction */

  SPI_FLASH_WriteEnable();

  /* Sector Erase */

  /* Select the FLASH: Chip Select low */

  SPI_FLASH_CS_LOW();

  /* Send Sector Erase instruction */

  SPI_FLASH_SendByte(SE);

  /* Send SectorAddr high nibble address byte */

  SPI_FLASH_SendByte((SectorAddr & 0xFF0000) >> 16);

  /* Send SectorAddr medium nibble address byte */

  SPI_FLASH_SendByte((SectorAddr & 0xFF00) >> 8);

  /* Send SectorAddr low nibble address byte */

  SPI_FLASH_SendByte(SectorAddr & 0xFF);

  /* Deselect the FLASH: Chip Select high */

  SPI_FLASH_CS_HIGH();

}




/*brief  Writes more than one byte to the FLASH with a single WRITE cycle  */
void SPI_FLASH_PageWrite(u8* pBuffer, u32 WriteAddr, u16 NumByteToWrite)

{
  /* Enable the write access to the FLASH */

  SPI_FLASH_WriteEnable();

  /* Select the FLASH: Chip Select low */

  SPI_FLASH_CS_LOW();

  /* Send "Write to Memory " instruction */

  SPI_FLASH_SendByte(PP);

  /* Send WriteAddr high nibble address byte to write to */

  SPI_FLASH_SendByte((WriteAddr & 0xFF0000) >> 16);

  /* Send WriteAddr medium nibble address byte to write to */

  SPI_FLASH_SendByte((WriteAddr & 0xFF00) >> 8);

  /* Send WriteAddr low nibble address byte to write to */

  SPI_FLASH_SendByte(WriteAddr & 0xFF);

  while(NumByteToWrite--)

  {
  SPI_FLASH_SendByte(*pBuffer);

  pBuffer++;  
  }

  /* Deselect the FLASH: Chip Select high */
  SPI_FLASH_CS_HIGH();

}




/*brief  Writes block of data to the FLASH. In this function, the number of */


void SPI_FLASH_BufferWrite(u8* pBuffer, u32 WriteAddr, u16 NumByteToWrite)


{

  u8 NumOfPage = 0, NumOfSingle = 0, Addr = 0, count = 0, temp = 0;

  Addr = WriteAddr % SPI_FLASH_PAGESIZE;

  count = SPI_FLASH_PAGESIZE - Addr;

  NumOfPage =  NumByteToWrite / SPI_FLASH_PAGESIZE;

  NumOfSingle = NumByteToWrite % SPI_FLASH_PAGESIZE;

  if (Addr == 0) /* WriteAddr is SPI_FLASH_PAGESIZE aligned  */

  {

    if (NumOfPage == 0) /* NumByteToWrite < SPI_FLASH_PAGESIZE */

    {
      SPI_FLASH_PageWrite(pBuffer, WriteAddr, NumByteToWrite);
    }

    else                    /* NumByteToWrite > SPI_FLASH_PAGESIZE */

    {

      while (NumOfPage--)
      {

        SPI_FLASH_PageWrite(pBuffer, WriteAddr, SPI_FLASH_PAGESIZE);

        WriteAddr +=  SPI_FLASH_PAGESIZE;

         pBuffer += SPI_FLASH_PAGESIZE;
      }

      SPI_FLASH_PageWrite(pBuffer, WriteAddr, NumOfSingle);

    }

  }

  else              /* WriteAddr is not SPI_FLASH_PAGESIZE aligned  */

  {

    if (NumOfPage == 0) /* NumByteToWrite < SPI_FLASH_PAGESIZE */

    {

      if (NumOfSingle > count) /* (NumByteToWrite + WriteAddr) > SPI_FLASH_PAGESIZE */

      {

        temp = NumOfSingle - count;

        SPI_FLASH_PageWrite(pBuffer, WriteAddr, count);
		
        WriteAddr +=  count;

        pBuffer += count;

        SPI_FLASH_PageWrite(pBuffer, WriteAddr, temp);
      }

      else

      {

      SPI_FLASH_PageWrite(pBuffer, WriteAddr, NumByteToWrite);

      }
    }

    else          /* NumByteToWrite > SPI_FLASH_PAGESIZE */

    {
      NumByteToWrite -= count;

      NumOfPage =  NumByteToWrite / SPI_FLASH_PAGESIZE;

      NumOfSingle = NumByteToWrite % SPI_FLASH_PAGESIZE;

      SPI_FLASH_PageWrite(pBuffer, WriteAddr, count);

      WriteAddr +=  count;

      pBuffer += count;

      while (NumOfPage--)

      {

        SPI_FLASH_PageWrite(pBuffer, WriteAddr, SPI_FLASH_PAGESIZE);

        WriteAddr +=  SPI_FLASH_PAGESIZE;

        pBuffer += SPI_FLASH_PAGESIZE;

      }

      if (NumOfSingle != 0)

      {

        SPI_FLASH_PageWrite(pBuffer, WriteAddr, NumOfSingle);
      }


    }

  }

}





/*brief  Reads a block of data from the FLASH. */


void SPI_FLASH_BufferRead(u8* pBuffer, u32 ReadAddr, u16 NumByteToRead)


{
  /* Select the FLASH: Chip Select low */
  
  SPI_FLASH_CS_LOW();

  /* Send "Read from Memory " instruction */

  SPI_FLASH_SendByte(READ);

  /* Send ReadAddr high nibble address byte to read from */

  SPI_FLASH_SendByte((ReadAddr & 0xFF0000) >> 16);

  /* Send ReadAddr medium nibble address byte to read from */

  SPI_FLASH_SendByte((ReadAddr& 0xFF00) >> 8);

  /* Send ReadAddr low nibble address byte to read from */

  SPI_FLASH_SendByte(ReadAddr & 0xFF);

  while (NumByteToRead--)  /* while there is data to be read */
  {

    /* Read a byte from the FLASH */

    *pBuffer = SPI_FLASH_SendByte(DUMMY_BYTE);

    /* Point to the next location where the byte read will be saved */

    pBuffer++;
  }

  /* Deselect the FLASH: Chip Select high */

  SPI_FLASH_CS_HIGH();

}





 

/********************************************************************* 

函数名称：Flash_ChipErase 

函数功能：整片擦除 

*********************************************************************/ 

void Flash_ChipErase(void) 

{ 

//LED = 0; 

SPI_FLASH_WriteEnable(); 

SPI_FLASH_CS_LOW(); 

f_spistatus=2; 

SPI_DSP_SendByte(0xc7); 

SPI_FLASH_CS_HIGH(); 

//SPI_FLASH_WaitForWriteEnd(); 

//LED = 1; 

} 

/*********************************************************************** 

函数名称：SPI_FLASH_WriteEnable 

函数功能：SPI写使能 

入口参数：无 

出口参数：无 

************************************************************************/ 

void SPI_FLASH_WriteEnable(void) 

{ 

SPI_FLASH_CS_LOW(); 

SpiDelay(); 

f_spistatus=3; 

SPI_DSP_SendByte(WREN); 

SPI_FLASH_CS_HIGH(); 

} 





 

/************************************************************************ 

函数名称：write_SPI 

函数功能：向从设备写入数据 data 

入口参数： 

data------------>将写入数据 

出口参数：无 

*************************************************************************/ 
//u16 FLASH_ID=0x00;
#if 0
void SPI1_Test(void)
 {


/* Get SPI Flash ID */


//  FLASH_ID = ReadDeviceID();        


//  FLASH_ID = ReadDeviceID();


//f (FLASH_ID == E25Q80_FLASH_ID)


{

/* Write Tx_Buffer data to SPI FLASH memory */


	UART2_DeInit();
       initUart(UART2_MODE_TXRX_ENABLE);


SPI_FLASH_BufferWrite(Tx_Buffer, FLASH_WriteAddress, BufferSize);

Wait_For_mSec(200);

myputstr("Write message is ok!\r\n");


/* Read data from SPI FLASH memory */

memset(Rx_Buffer,0,sizeof(Rx_Buffer));


SPI_FLASH_BufferRead(Rx_Buffer, FLASH_ReadAddress, BufferSize); 



  myputstr("the message you write is:\r\n");



myputstr((char *)Rx_Buffer);



myputstr("\r\n");//插入换行


/* Erase SPI FLASH Sector to write on */



SPI_FLASH_SectorErase(FLASH_SectorToErase);



Wait_For_mSec(100);



/* Read data from SPI FLASH memory    No   data  -----Erase is ok  */



memset(Rx_Buffer,0,sizeof(Rx_Buffer));



SPI_FLASH_BufferRead(Rx_Buffer, FLASH_ReadAddress, BufferSize); 



 myputstr("the message you write is:\r\n");



myputstr((char *)Rx_Buffer);



myputstr("\r\n");//插入换行




myputstr("\r\n");//插入换行



Wait_For_mSec(1000);


}


}   



 #endif

//---------------------------end-----------------------------------------



	










