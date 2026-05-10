library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RippleCounter_tff_tb is
end RippleCounter_tff_tb;

architecture tb of RippleCounter_tff_tb is


    component RippleCounter_tff
        Port (
            clk   : in  STD_LOGIC;
            reset : in  STD_LOGIC;
            q     : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;


    signal clk_tb   : STD_LOGIC := '0';
    signal reset_tb : STD_LOGIC := '0';
    signal q_tb     : STD_LOGIC_VECTOR(3 downto 0);

begin


    UUT: RippleCounter_tff
        port map (
            clk   => clk_tb,
            reset => reset_tb,
            q     => q_tb
        );

 
    clk_process : process
    begin
        clk_tb <= '0';
        wait for 10 ns;
        clk_tb <= '1';
        wait for 10 ns;
    end process;


    stim_process : process
    begin
        -- ????? 1: ???? ????
        reset_tb <= '0';
        wait for 30 ns;

        -- ????? 2: ???? ??????? ? ????? ???? ??????
        reset_tb <= '1';
        wait for 300 ns;

        -- ????? 3: ???? ?????? ???? ??? ??????
        reset_tb <= '1';
        wait for 20 ns;
        reset_tb <= '0';

        wait for 200 ns;

        -- ????? ???
        wait;
    end process;

end tb;
