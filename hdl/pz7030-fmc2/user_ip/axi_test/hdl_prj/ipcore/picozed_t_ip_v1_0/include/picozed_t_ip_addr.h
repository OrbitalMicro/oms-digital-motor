/*
 * File Name:         hdl_prj/ipcore/picozed_t_ip_v1_0/include/picozed_t_ip_addr.h
 * Description:       C Header File
 * Created:           2025-10-08 11:52:55
*/

#ifndef PICOZED_T_IP_H_
#define PICOZED_T_IP_H_

#define  IPCore_Reset_picozed_t_ip              0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_picozed_t_ip             0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_picozed_t_ip          0x8  //contains unique IP timestamp (yymmddHHMM): 2510081152
#define  countTrigger_i_Data_picozed_t_ip       0x100  //data register for Inport countTrigger_i
#define  countEnable_i_Data_picozed_t_ip        0x104  //data register for Inport countEnable_i
#define  incrCount_o_Data_picozed_t_ip          0x108  //data register for Outport incrCount_o
#define  measureLatency_o_Data_picozed_t_ip     0x10C  //data register for Outport measureLatency_o
#define  countMax_i_Data_picozed_t_ip           0x110  //data register for Inport countMax_i
#define  timer_isr_enable_i_Data_picozed_t_ip   0x114  //data register for Inport timer_isr_enable_i
#define  counterDisable_i_Data_picozed_t_ip     0x118  //data register for Inport counterDisable_i

#endif /* PICOZED_T_IP_H_ */
