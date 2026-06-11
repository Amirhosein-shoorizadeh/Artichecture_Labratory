library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Restoring_Divider is
end tb_Restoring_Divider;

architecture behavior of tb_Restoring_Divider is
    constant N : integer := 4;
    signal clk, reset, start : std_logic := '0';
    signal Dividend : std_logic_vector(2*N-1 downto 0) := (others => '0');
    signal Divisor  : std_logic_vector(N-1 downto 0) := (others => '0');
    signal Quotient, Remainder : std_logic_vector(N-1 downto 0);
    signal Overflow, Ready : std_logic;

    constant clk_period : time := 10 ns;
begin

    uut: entity work.Restoring_Divider
        generic map (N => N)
        port map (
            clk => clk, reset => reset, start => start,
            Dividend => Dividend, Divisor => Divisor,
            Quotient => Quotient, Remainder => Remainder,
            Overflow => Overflow, Ready => Ready
        );


    clk_process :process
    begin
        clk <= '0'; wait for clk_period/2;
        clk <= '1'; wait for clk_period/2;
    end process;

 
    stim_proc: process
    begin
    
        reset <= '1'; wait for 20 ns;
        reset <= '0'; wait for 20 ns;

      
        Dividend <= "00001110"; 
        Divisor  <= "0100";     
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until Ready = '1';
        wait for 20 ns;

        Dividend <= "00101111"; -- 47
        Divisor  <= "0011";     -- 3
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until Ready = '1';
        wait for 20 ns;

  
        Dividend <= "00110010"; -- 50
        Divisor  <= "0011";     -- 3
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until Ready = '1';
        wait for 20 ns;


        Dividend <= "00001010"; -- 10
        Divisor  <= "0000";     -- 0
        start <= '1';
        wait for clk_period;
        start <= '0';
        wait until Ready = '1';

        wait;
    end process;
end behavior;
