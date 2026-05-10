library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_decoder_2to4 is
end tb_decoder_2to4;

architecture behavior of tb_decoder_2to4 is

signal A : STD_LOGIC_VECTOR(1 downto 0);
signal Y : STD_LOGIC_VECTOR(3 downto 0);

begin

uut: entity work.decoder_2to4
port map(
    A => A,
    Y => Y
);

process
begin

A <= "00";
wait for 40 ns;

A <= "01";
wait for 40 ns;

A <= "10";
wait for 40 ns;

A <= "11";
wait for 40 ns;

wait;

end process;

end behavior;
