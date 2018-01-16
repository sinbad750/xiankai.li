#include "stm8s_type.h"
#include "stm8s_gpio.h"
#include "main.h"
#include "i2c.h"
#include "uart.h"

#define I2C_WIRELESS_ADDR  0x80
#define I2C_WIRELESS_UPG_ADDR  0x82
#define I2C_dADDR_FOR_Tpa5050  0xd0


u8 RX_Data_recv_array[8];
unsigned char i2c_error = 0;         
unsigned char Tpa5050=0;
#define SDA_HIGH             Wireless_SDA(HIGH)
#define SDA_LOW              Wireless_SDA(LOW)
#define SCL_HIGH             Wireless_SCL(HIGH)
#define SCL_LOW              Wireless_SCL(LOW)
#define SLA_SDA               Wireless_SDA_statu()
#define delay_II(a)              Wireless_IIC_delay(a)

u8 Wireless_i2c_Addr(void)
{
   return  I2C_WIRELESS_ADDR ;
}
void  Wireless_SDA(u8 statu)
{

/* 
  if(statu==HIGH)
  	GPIO_WriteHigh(GPIOE, GPIO_PIN_0);
  else
  	GPIO_WriteLow(GPIOE,GPIO_PIN_0);

 */

#ifdef  use_dv1_pcb
 if(statu==HIGH)
  GPIOD->ODR|=GPIO_PIN_0;
  else
  GPIOD->ODR &=~GPIO_PIN_0;	

  #else
   if(statu==HIGH)
  GPIOE->ODR|=GPIO_PIN_0;
  else
  GPIOE->ODR &=~GPIO_PIN_0;	

#endif

}
void Wireless_SCL(u8 statu)
{ 
/* 
  if(statu==HIGH)
  	GPIO_WriteHigh(GPIOE, GPIO_PIN_1);
  else
  	GPIO_WriteLow(GPIOE,GPIO_PIN_1);
 */
       if(statu==HIGH)
  GPIOE->ODR|=GPIO_PIN_1;
  else
  GPIOE->ODR &=~GPIO_PIN_1;	


}
u8 Wireless_SDA_statu(void)
{
#ifdef  use_dv1_pcb
 return  GPIO_ReadInputPin(GPIOD,  GPIO_PIN_0);
#else
   return  GPIO_ReadInputPin(GPIOE,  GPIO_PIN_0);
#endif
}
void vCheck_SCL_Status(void)
{ 
   u8 I2S_Streching_Cnt= 100;

   //     if(up_state!=UP_STATE_IDLE)   //test speedup upgrade
  //	   return;
   

	while(I2S_Streching_Cnt--)
	{	
		GPIO_WriteHigh(GPIOE, GPIO_PIN_1);
		if(GPIO_ReadInputPin(GPIOE,  GPIO_PIN_1))
		break;
	}
}
void  Wireless_IIC_delay(u8 n)
{
	while(n--)
	{

	}
}
unsigned char SDA_IN(void)
{
	return SLA_SDA;
}
void SDA_OUT(unsigned char b)
{
	if (b == 0)
		{SDA_LOW;}
	else 
		{SDA_HIGH ;}
}
unsigned char i2c_start(void)
{
	SDA_HIGH ;       
	delay_II(1);
	SCL_HIGH;        
	delay_II(1);
#ifdef I2C_CLK_Streching	
	vCheck_SCL_Status();
#endif
	SDA_LOW;   
	delay_II(1);
	SCL_LOW;
	delay_II(1);
        return 0;
}
unsigned char i2c_stop(void)
{
	delay_II(1);
	SDA_LOW;        
	delay_II(1);
	SCL_HIGH;
#ifdef I2C_CLK_Streching	
	vCheck_SCL_Status();
#endif        
	delay_II(2);
	SDA_HIGH ;        
	return (0);
}
unsigned char i2c_bit_out(unsigned char bout)
{
	SDA_OUT(bout);		
	delay_II(1);
	SCL_HIGH;
#ifdef I2C_CLK_Streching	
	vCheck_SCL_Status();
#endif        
	delay_II(2);
	SCL_LOW;			/* Pull SCL back down */
	delay_II(1);
	return 0;			/* OK */	
}
unsigned char i2c_bit_in(void)
{	
         u8 bin;
	SDA_HIGH ;
	delay_II(1);
	SCL_HIGH;			/* Let SCL go up */
#ifdef I2C_CLK_Streching	
	vCheck_SCL_Status();
#endif        
	delay_II(3);
	bin = SDA_IN();		/* Read in data */
	delay_II(1);
	SCL_LOW;			/* Pull SCL back up */
	delay_II(1);
	return bin;			/* Return the sampled bit */
}
unsigned char i2c_bit_in_ACK(void)
{	
	u8 i;
	u8 bin;
	SDA_HIGH ;
	delay_II(1);
	SCL_HIGH;	
#ifdef I2C_CLK_Streching	
	vCheck_SCL_Status();
#endif        /* Let SCL go up */
	delay_II(3);
	#if 1
        i=0;
	while(i<100)
		{
			bin = SDA_IN();		/* Read in data */
			if(bin == 0)
				{ break;}
			i++;			
		}
	#endif
	bin = SDA_IN();		/* Read in data */
	delay_II(1);
	SCL_LOW;			/* Pull SCL back up */
	delay_II(1);
	return bin;			/* Return the sampled bit */
}

unsigned char i2c_byte_out(unsigned char dat)
{
       unsigned char  bit_count = 8;
	
	while(bit_count)
	{
		if (dat & 0x80)
		{
			if (i2c_bit_out(1)) return 1;
		}
		else
		{
			if (i2c_bit_out(0)) return 1;
		}
		dat <<= 1;
		bit_count--;
	}
	if (i2c_bit_in_ACK())
	{
		i2c_error = I2CERR_NAK;
		return 1;
	}
     return 0;

}
unsigned char i2c_byte_in(unsigned char Ack_Bit)
{
       unsigned char bit_count=8, byte_in=0;
	while(bit_count)
	{
		byte_in <<= 1;
		if (i2c_bit_in()) 
			byte_in |= 0x01;
		bit_count--;
	}
	i2c_bit_out(Ack_Bit);
	SDA_HIGH ;
	return byte_in;
}
unsigned char I2C_8052_Write_Buf (unsigned char *buf, int count)
{
	unsigned char byte_out;
       	i2c_start();
		
         i2c_error = 0;
	if (i2c_byte_out(0x80))	
	{
		if (i2c_error == I2CERR_NAK )
		    i2c_stop();		
		return i2c_error;
	}
	
	while(count)
	{	    
                byte_out = *buf++;
		if (i2c_byte_out(byte_out))
		{
			if (i2c_error == I2CERR_NAK)
				i2c_stop();
                            return i2c_error;
		}
		count--;
	}
	i2c_stop();
	return 0;
}

unsigned char I2C_8052_Read_Buf ( unsigned int rx_count)
{
      unsigned char byte_in , byteptr = 0;  
      if (i2c_start()) 
	  	return 1;
      i2c_error = 0; 
      if (i2c_byte_out(0x80))         //send device address
      {
           if (i2c_error == I2CERR_NAK )
           {
                    i2c_stop();                         
                    return 1;
           }
      }     

	//  i2c_byte_out(0x3E);
      i2c_start();      
      if (i2c_byte_out(0x81))         //send device address
      {
           if (i2c_error == I2CERR_NAK )
           {
                    i2c_stop();                         
                    return 1;
           }
      }        
      while(rx_count)
      {
           if (--rx_count)
           {
                    byte_in = i2c_byte_in(0);
           }
           else
           {
                    byte_in = i2c_byte_in(1); /* No ACK during last byte */
           }
           RX_Data_recv_array[byteptr]     = byte_in;
           byteptr++;               
     }
     i2c_stop();
     return 0 ;         
}


 unsigned char i2c_recv(unsigned char *temp_buff,unsigned char count)
{
	unsigned char byteptr, byte_in;
	 
	if (i2c_start()) return 1;
	i2c_error = 0;
	byteptr = 0;
	
	if (i2c_byte_out(0x37))
	{
		if (i2c_error == I2CERR_NAK) 
			i2c_stop();
		return 
			i2c_error;
	}

	while(count)
	{
		if (--count)
			byte_in = i2c_byte_in(0);
		else
			byte_in = i2c_byte_in(1);   /* No ACK during last byte */
		*temp_buff=byte_in;
		temp_buff++;
	}

	i2c_stop();

	return (i2c_error ? 1 : 0);
}



unsigned char I2C_Read_Buf (unsigned char map,unsigned char *temp,unsigned char  rx_count)
{
	u8 bdata=0;
	if ( I2C_Write_Buf (map, &bdata, 0))//, 0))/* second map addres is dummy pointer no data writtten only i2cSlave address and map address*/
	{
		/* If send fails, abort but don't send a stop condition if we lost
		arbitration */
		if (i2c_error != I2CERR_LOST) 
		i2c_stop();
		return 1;
	}

	SDA_HIGH ;        /* One of these may be low now, in which case the next */
	SCL_HIGH;        /*   start condition wouldn't be detected so make */
	delay_II(2);    /*   sure that they're up and wait for one delay slot */
	if (i2c_recv(temp,rx_count))
	return 1;

	return (i2c_error ? 1 : 0);
}


unsigned char I2C_Write_Buf (unsigned char addr, unsigned char *buf, unsigned char count) //unsigned char flash_type)
{
	unsigned char byte_out;//=flash_type;
	unsigned char add_slave;


	   if(Tpa5050)
	 	add_slave=I2C_dADDR_FOR_Tpa5050;
	    else 
		add_slave=0x36;	
		
	if (i2c_start()) 	return 1;
		i2c_error = 0;
		

	if (i2c_byte_out(add_slave))
	{
		if (i2c_error == I2CERR_NAK )
		i2c_stop();		
		return i2c_error;
	}
	byte_out = (addr & 0xFF);
	count = count+1;                    /* Include map addres to byte count */
	while(count)
	{	     
		if (i2c_byte_out(byte_out))
		{
			if (i2c_error == I2CERR_NAK)
				i2c_stop();
				return i2c_error;
		}
		byte_out = *buf++;
		count--;
	}
	i2c_stop();
	return 0;
}


unsigned char I2C_Write_TAS5711(unsigned char write_addr,unsigned char *write_buff,unsigned char count)
{

		
		if(I2CERR_OK ==I2C_Write_Buf(write_addr,write_buff,count));

	      return(0);
}

unsigned char I2C_Read_TAS5711(unsigned char read_addr,unsigned char *read_buff,unsigned char count)
{
	
	    return (I2C_Read_Buf(read_addr,read_buff,count));
}



unsigned char I2C_Write_Tpa5050(unsigned char write_addr,unsigned char *write_buff,unsigned char count)
{
              
		Tpa5050=1;
	       I2C_Write_Buf(write_addr,write_buff,count);
             Tpa5050=0;
	        return(0);
}





//#ifdef  UPG_WIRELESS_MOUDLE

u8 I2C_Write_Buf_W (u16 addr, u8 *buf, unsigned int count)
{
	u8 byte_out = (u8 ) (addr>>8) ;
	i2c_start();
	if (i2c_byte_out(I2C_WIRELESS_UPG_ADDR & 0xFE))
	{
		i2c_stop();
		return 1;
	}
	i2c_byte_out(byte_out);
	//Wireless_IIC_delay(2);
	i2c_byte_out(addr & 0xFF);
	//Wireless_IIC_delay(2);
	while(count)
	{
		byte_out = *buf++;
		if (i2c_byte_out(byte_out))
		{
			i2c_stop();
			return 1;
		}
		count--;
		Wireless_IIC_delay(2);
	}
	i2c_stop();
	return 0;
}
/*
 * Read in 'count' bytes from slave 'addr'.
 * Returns 0 on success.
 */
unsigned char i2c_recv_W(unsigned char count)
{
	unsigned char byteptr, byte_in;
	byteptr = 0;
	i2c_start();
	byte_in = I2C_WIRELESS_UPG_ADDR |0x01;
	if (i2c_byte_out(byte_in))
	{
		i2c_stop();
		return 1;
	}
	while(count)
	{
		if (--count)
			byte_in = i2c_byte_in(0);
		else
			byte_in = i2c_byte_in(1); /* No ACK during last byte */
		RX_Data_recv_array[byteptr]	= byte_in;
		byteptr++;
	}
	i2c_stop();
	return 0;
}
/* read data is availeble in RX_Data_recv_array */
u8 I2C_Read_Buf_W(u16 map, signed int rx_count)
{
	if ( I2C_Write_Buf_W (map, (u8*) &map, 0))/* second map addres is dummy pointer no data writtten only i2cSlave address and map address*/
	{
		i2c_stop();
		return 1;
	}
	SDA_HIGH;
	SCL_HIGH;
	Wireless_IIC_delay(2);  
	/*sure that they're up and wait for one delay slot */
	return (i2c_recv_W(rx_count));
}





