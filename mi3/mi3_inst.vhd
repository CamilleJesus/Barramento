	component mi3 is
		port (
			clk_clk          : in  std_logic                     := 'X';             -- clk
			reset_reset_n    : in  std_logic                     := 'X';             -- reset_n
			dips_export      : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- export
			botao_export     : out std_logic;                                        -- export
			a_export         : out std_logic_vector(31 downto 0);                    -- export
			b_export         : out std_logic_vector(31 downto 0);                    -- export
			produto_export   : in  std_logic_vector(31 downto 0) := (others => 'X'); -- export
			quociente_export : in  std_logic_vector(31 downto 0) := (others => 'X'); -- export
			resto_export     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- export
			uart_rxd         : in  std_logic                     := 'X';             -- rxd
			uart_txd         : out std_logic                                         -- txd
		);
	end component mi3;

	u0 : component mi3
		port map (
			clk_clk          => CONNECTED_TO_clk_clk,          --       clk.clk
			reset_reset_n    => CONNECTED_TO_reset_reset_n,    --     reset.reset_n
			dips_export      => CONNECTED_TO_dips_export,      --      dips.export
			botao_export     => CONNECTED_TO_botao_export,     --     botao.export
			a_export         => CONNECTED_TO_a_export,         --         a.export
			b_export         => CONNECTED_TO_b_export,         --         b.export
			produto_export   => CONNECTED_TO_produto_export,   --   produto.export
			quociente_export => CONNECTED_TO_quociente_export, -- quociente.export
			resto_export     => CONNECTED_TO_resto_export,     --     resto.export
			uart_rxd         => CONNECTED_TO_uart_rxd,         --      uart.rxd
			uart_txd         => CONNECTED_TO_uart_txd          --          .txd
		);

