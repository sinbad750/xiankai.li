#ifndef _I2C_H
#define _I2C_H

extern u8 RX_Data_recv_array[8];

#define I2CERR_OK       0            /* No error */
#define I2CERR_NAK      1           /* No ACK from slave */
#define I2CERR_LOST     2            /* Arbitration lost */
#define I2CERR_BUS      3            /* Bus is stuck (not used yet) */
#define I2CERR_TIMEOUT  4         /* Timeout on bus */
#define I2C_CLK_Streching

#define OK 	1
#define NOK     0

#define ERR         1
#define NO_ERR  0

#define HIGH    1
#define LOW     0

u8 I2C_8052_Write_Buf(unsigned char *buf, int count); 
u8 I2C_8052_Read_Buf (unsigned int rx_count);
unsigned char I2C_Read_Buf (unsigned char map,unsigned char *temp,unsigned char  rx_count);
unsigned char I2C_Write_Buf (unsigned char addr, unsigned char *buf, unsigned char count);
unsigned char I2C_Write_TAS5711(unsigned char write_addr,unsigned char *write_buff,unsigned char count);

u8 I2C_Read_Buf_W (u16 map, signed int rx_count);

u8 I2C_Write_Buf_W(u16 addr, u8 *buf, unsigned int count);

#endif
