library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RippleCarryAdder is
    Port ( A     : in  STD_LOGIC_VECTOR (3 downto 0);
           B     : in  STD_LOGIC_VECTOR (3 downto 0);
           Cin   : in  STD_LOGIC;
           Sum   : out STD_LOGIC_VECTOR (3 downto 0);
           Cout  : out STD_LOGIC);
end RippleCarryAdder;

architecture Structural of RippleCarryAdder is

    component FullAdder
        Port ( A  : in  STD_LOGIC;
               B  : in  STD_LOGIC;
               Cin: in  STD_LOGIC;
               Sum: out STD_LOGIC;
               Cout: out STD_LOGIC);
    end component;

    signal carry : STD_LOGIC_VECTOR (4 downto 0);

begin

    carry(0) <= Cin;

    FA0: FullAdder port map (A(0), B(0), carry(0), Sum(0), carry(1));
    FA1: FullAdder port map (A(1), B(1), carry(1), Sum(1), carry(2));
    FA2: FullAdder port map (A(2), B(2), carry(2), Sum(2), carry(3));
    FA3: FullAdder port map (A(3), B(3), carry(3), Sum(3), carry(4));

    Cout <= carry(4);

end Structural;
