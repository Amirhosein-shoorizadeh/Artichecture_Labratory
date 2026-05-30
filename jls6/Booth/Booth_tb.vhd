library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_booth is
end tb_booth;

architecture sim of tb_booth is
    signal clk   : std_logic := '0';
    signal rst   : std_logic := '1';
    signal start : std_logic := '0';
    signal m     : std_logic_vector(7 downto 0) := (others => '0');
    signal q_in  : std_logic_vector(7 downto 0) := (others => '0');
    signal prod  : std_logic_vector(15 downto 0);
    signal done  : std_logic;
begin
    uut: entity work.booth_multiplier_8bit
        port map (
            clk   => clk,
            rst   => rst,
            start => start,
            m     => m,
            q_in  => q_in,
            prod  => prod,
            done  => done
        );
     process
       begin
           clk <= '0';
           wait for 5 ns;
           clk <= '1';
           wait for 5 ns;
    end process;
-------
    process
      begin
        wait for 15 ns;
        rst <= '0';
        wait for 10 ns;

        m    <= "00000101";
        q_in <= "00000011";
        start <= '1';
        wait until rising_edge(clk);
        start <= '0';
        wait until done = '1';
        wait until rising_edge(clk);

        m    <= "11111101";
        q_in <= "00000111";
        start <= '1';
        wait until rising_edge(clk);
        start <= '0';
        wait until done = '1';
        wait until rising_edge(clk);

        m    <= "11111100";
        q_in <= "11111010";
        start <= '1';
        wait until rising_edge(clk);
        start <= '0';
        wait until done = '1';
        wait until rising_edge(clk);

        m    <= "00000000";
        q_in <= "00001111";
        start <= '1';
        wait until rising_edge(clk);
        start <= '0';
        wait until done = '1';
        wait until rising_edge(clk);

        m    <= "00001100";
        q_in <= "00000000";
        start <= '1';
        wait until rising_edge(clk);
        start <= '0';
        wait until done = '1';
        wait until rising_edge(clk);

        wait;
    end process;
end sim;
