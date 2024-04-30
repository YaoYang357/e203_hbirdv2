//=====================================================================
// Description: The mini-decode module to decode the instruction in IFU 
//
// 只需要译出IFU所需的部分指令信息，这些信息包括此指令是属于普通指令还是分支跳转指令、分支跳转指令的类型和细节
// 简单译码模块内部例化、调用一个完整的译码模块，将其不相关的输入信号接0，将输出信号悬空，从而使综合工具将完整
// 译码模块中无关逻辑优化掉
// ====================================================================
`include "e203_defines.v"

module e203_ifu_minidec(

  //////////////////////////////////////////////////////////////
  // The IR stage to Decoder
  input  [`E203_INSTR_SIZE-1:0] instr,// 对输入进行部分译码，instruct：指令
  
  //////////////////////////////////////////////////////////////
  // The Decoded Info-Bus


  output dec_rs1en,
  output dec_rs2en,
  output [`E203_RFIDX_WIDTH-1:0] dec_rs1idx,
  output [`E203_RFIDX_WIDTH-1:0] dec_rs2idx,

  output dec_mulhsu,
  output dec_mul   ,
  output dec_div   ,
  output dec_rem   ,
  output dec_divu  ,
  output dec_remu  ,

  output dec_rv32, // 指示当前指令为16位还是32位
  output dec_bjp, // 指示当前指令属于普通指令还是分支跳转指令
  output dec_jal, // 属于jal指令
  output dec_jalr,// 属于jalr指令
  output dec_bxx, // 属于bxx指令（beq、bne等带条件分支指令）
  output [`E203_RFIDX_WIDTH-1:0] dec_jalr_rs1idx,
  output [`E203_XLEN-1:0] dec_bjp_imm 

  );

  e203_exu_decode u_e203_exu_decode(

  .i_instr(instr),
  .i_pc(`E203_PC_SIZE'b0),// 不相关输入信号接0
  .i_prdt_taken(1'b0), 
  .i_muldiv_b2b(1'b0), 

  .i_misalgn (1'b0),
  .i_buserr  (1'b0),

  .dbg_mode  (1'b0),

  .dec_misalgn(),// 不相关的输出信号悬空
  .dec_buserr(),
  .dec_ilegl(),

  .dec_rs1x0(),
  .dec_rs2x0(),
  .dec_rs1en(dec_rs1en),
  .dec_rs2en(dec_rs2en),
  .dec_rdwen(),
  .dec_rs1idx(dec_rs1idx),
  .dec_rs2idx(dec_rs2idx),
  .dec_rdidx(),
  .dec_info(),  
  .dec_imm(),
  .dec_pc(),

`ifdef E203_HAS_NICE//{
  .dec_nice   (),
  .nice_xs_off(1'b0),  
  .nice_cmt_off_ilgl_o(),
`endif//}

  .dec_mulhsu(dec_mulhsu),
  .dec_mul   (dec_mul   ),
  .dec_div   (dec_div   ),
  .dec_rem   (dec_rem   ),
  .dec_divu  (dec_divu  ),
  .dec_remu  (dec_remu  ),

  .dec_rv32(dec_rv32),
  .dec_bjp (dec_bjp ),
  .dec_jal (dec_jal ),
  .dec_jalr(dec_jalr),
  .dec_bxx (dec_bxx ),

  .dec_jalr_rs1idx(dec_jalr_rs1idx),
  .dec_bjp_imm    (dec_bjp_imm    )  
  );


endmodule
