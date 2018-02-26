
module mi3 (
	clk_clk,
	reset_reset_n,
	dips_export,
	botao_export,
	a_export,
	b_export,
	produto_export,
	quociente_export,
	resto_export,
	uart_rxd,
	uart_txd);	

	input		clk_clk;
	input		reset_reset_n;
	input	[3:0]	dips_export;
	output		botao_export;
	output	[31:0]	a_export;
	output	[31:0]	b_export;
	input	[31:0]	produto_export;
	input	[31:0]	quociente_export;
	input	[31:0]	resto_export;
	input		uart_rxd;
	output		uart_txd;
endmodule
