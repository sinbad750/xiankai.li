#ifndef _BT830_H
#define _BT830_H


void SpiDelay(void); 

void write_SPI(u8 data); 


void SPI_FLASH_WriteEnable(void); 

void Flash_ChipErase(void); 

void Spi_PageWrite(u8* tBuf,u32 tWriteAddr,u16 tNum); 

void SpiFlashBufWrite(u8* pBuffer, u32 WriteAddr, u16 NumByteToWrite); 

void Spi_PageRead(u8* pBuf, u32 tReadAddr, u16 tNum); 

u8 SpiReadOneByte(u32 ReadAddr); 

u8 SPI_FLASH_SendByte(u8 tData); 

u16 ReadDeviceID(void); 

void SPI_FLASH_WaitForWriteEnd(void); 

void SPIReadStatus(void); 

void Spi_Flash_init(void); 


void  SPI1_Test(void);
#endif

