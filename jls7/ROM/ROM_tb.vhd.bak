library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_ram_dual_port is
end tb_ram_dual_port;

architecture behavior of tb_ram_dual_port is
    constant W : integer := 8;
    constant C : integer := 4;
    constant clk_period : time := 10 ns;

    signal wr_A, wr_B, rd_A, rd_B : std_logic := '0';
    signal clk : std_logic := '0';
    signal addr_RD, addr_WR : std_logic_vector(C-1 downto 0) := (others => '0');
    signal rst : std_logic := '0';
    signal data_in_A, data_in_B : std_logic_vector(W-1 downto 0) := (others => '0');
    signal data_out_A, data_out_B : std_logic_vector(W-1 downto 0);

begin
    uut: entity work.ram_dual_port
        generic map(W => W, C => C)
        port map(
            wr_A => wr_A, wr_B => wr_B,
            rd_A => rd_A, rd_B => rd_B,
            clk => clk,
            addr_RD => addr_RD,
            addr_WR => addr_WR,
            rst => rst,
            data_in_A => data_in_A,
            data_in_B => data_in_B,
            data_out_A => data_out_A,
            data_out_B => data_out_B
        );


    clk <= not clk after clk_period/2;


    process
    begin
        -- Rst
        rst <= '0';
        wait for 20 ns;
        rst <= '1';
        wait for 20 ns;
        
        -- Write A at  0
        wr_A <= '1';
        addr_WR <= "0000";
        data_in_A <= x"AA";
        wait for clk_period;
        wr_A <= '0';
        
        --  Read A from 0
        rd_A <= '1';
        addr_RD <= "0000";
        wait for clk_period;
        rd_A <= '0';
        
        -- Write B at 1
        wr_B <= '1';
        addr_WR <= "0001";
        data_in_B <= x"BB";
        wait for clk_period;
        wr_B <= '0';
        
        -- Read B from  1
        rd_B <= '1';
        addr_RD <= "0001";
        wait for clk_period;
        rd_B <= '0';
        
        --  
        wr_A <= '1';
        rd_B <= '1';
        addr_WR <= "0010";
        addr_RD <= "0001";
        data_in_A <= x"CC";
        wait for clk_period;
        wr_A <= '0';
        rd_B <= '0';
        
        -- Write B and read A simultaneously
        wr_B <= '1';
        rd_A <= '1';
        addr_WR <= "0011";
        addr_RD <= "0010";
        data_in_B <= x"DD";
        wait for clk_period;
        wr_B <= '0';
        rd_A <= '0';
        
        --  Write 2tash  to yeki
        wr_A <= '1';
        wr_B <= '1';
        addr_WR <= "0100";
        data_in_A <= x"11";
        data_in_B <= x"22";
        wait for clk_period;
        wr_A <= '0';
        wr_B <= '0';
        
        -- 
        rd_A <= '1';
        addr_RD <= "0100";
        wait for clk_period;
        rd_A <= '0';
        
        wait;
    end process;
end behavior;
