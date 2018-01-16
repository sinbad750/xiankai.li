#ifndef _UPG_H
#define _UPG_H

typedef enum
{
  Upg_Step_None=0x0,
  Upg_Step_Setup=0x01,
  Upg_Step_Erase=0x02,
  Upg_Step_Transmit_Data=0x03
}_WirelessUpgStep;

#define DARR_BASE            0xFC00
#define MCUCC2_ADDR      (DARR_BASE + 769)  
#define MPRR_ADDR           (DARR_BASE + 771)
#define ISCLC_ADDR           (DARR_BASE + 1020)
#define ISDLC_ADDR           (DARR_BASE + 1021)
#define GPCS41_ADDR       (DARR_BASE + 1011)
#define GPCS40_ADDR        (DARR_BASE +1010)
#define MAX_TX_SIZE	      256





extern void Wireless_Reset(void);
extern void Wireless_Tx_Upgrade(u8 *rxbuff);
void Wireless_Upg_Init(void);
void Wireless_Enter_Upgrade(void);


#endif
