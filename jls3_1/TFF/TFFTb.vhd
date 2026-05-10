library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TFFTb is
end TFFTb;

architecture behavior of TFFTb is

    signal clk     : std_logic := '0';
    signal reset   : std_logic := '1';
    signal t       : std_logic := '0';
    signal q       : std_logic;

    constant clk_period : time := 20 ns;

begin
    uut: entity work.tff
        port map (
            clk     => clk,
            reset => reset,
            t       => t,
            q       => q
        );
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
    end process;


    stim_proc: process
    begin

        t <= '0';
        reset <= '1';
        wait for 40 ns;


        t <= '0';
        wait for 60 ns;

        t <= '1';
        wait for 60 ns;

        t <= '0';
        wait for 40 ns;

        reset <= '0';
        wait for 25 ns;


        reset <= '1';
        t <= '1';
        wait for 60 ns;

        wait;
    end process;

end behavior;

