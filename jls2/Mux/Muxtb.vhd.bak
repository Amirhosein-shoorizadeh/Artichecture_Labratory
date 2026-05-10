
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux4to1 is
end tb_mux4to1;

architecture behavior of tb_mux4to1 is

signal I : STD_LOGIC_VECTOR(3 downto 0);
signal S : STD_LOGIC_VECTOR(1 downto 0);
signal Y : STD_LOGIC;

begin

uut: entity work.mux4to1
port map(
    I => I,
    S => S,
    Y => Y
);

process
begin

I <= "1010";

S <= "00";
wait for 10 ns;

S <= "01";
wait for 10 ns;

S <= "10";
wait for 10 ns;

S <= "11";
wait for 10 ns;

wait;

end process;

end behavior;
