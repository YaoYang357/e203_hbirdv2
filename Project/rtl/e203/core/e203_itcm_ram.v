//=====================================================================
// Designer   : Bob Hu
//
// Description:
//  The ITCM-SRAM module to implement ITCM SRAM
//
// ====================================================================

`include "e203_defines.v"

  `ifdef E203_HAS_ITCM //{
module e203_itcm_ram(

  input                              sd,
  input                              ds,
  input                              ls,

  input                              cs,  
  input                              we,  
  input  [`E203_ITCM_RAM_AW-1:0] addr, 
  input  [`E203_ITCM_RAM_MW-1:0] wem,
  input  [`E203_ITCM_RAM_DW-1:0] din,          
  output [`E203_ITCM_RAM_DW-1:0] dout,
  input                              rst_n,
  input                              clk

);

 
  sirv_gnrl_ram #(
      `ifndef E203_HAS_ECC//{
    .FORCE_X2ZERO(0),
      `endif//}
    .DP(`E203_ITCM_RAM_DP),
    .DW(`E203_ITCM_RAM_DW),
    .MW(`E203_ITCM_RAM_MW),
    .AW(`E203_ITCM_RAM_AW) 
  ) u_e203_itcm_gnrl_ram(
  .sd  (sd  ),
  .ds  (ds  ),
  .ls  (ls  ),

  .rst_n (rst_n ),
  .clk (clk ),
  .cs  (cs  ),
  .we  (we  ),
  .addr(addr),
  .din (din ),
  .wem (wem ),
  .dout(dout)
  );
                                                      
endmodule
  `endif//}
