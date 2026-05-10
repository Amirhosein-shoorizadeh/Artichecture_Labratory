library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder_2to4 is
    Port (
        A : in  STD_LOGIC_VECTOR (1 downto 0);
        Y : out STD_LOGIC_VECTOR (3 downto 0)
    );
end decoder_2to4;

architecture Gate_Level of decoder_2to4 is

signal nA0, nA1 : STD_LOGIC;

begin

nA0 <= not A(0);
nA1 <= not A(1);

Y(0) <= nA1 and nA0;
Y(1) <= nA1 and A(0);
Y(2) <= A(1) and nA0;
Y(3) <= A(1) and A(0);

end Gate_Level;
