library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RippleCarryAdder_TB is
end RippleCarryAdder_TB;

architecture Behavioral of RippleCarryAdder_TB is

   
    signal A     : STD_LOGIC_VECTOR (3 downto 0);
    signal B     : STD_LOGIC_VECTOR (3 downto 0);
    signal Cin   : STD_LOGIC;
    signal Sum   : STD_LOGIC_VECTOR (3 downto 0);
    signal Cout  : STD_LOGIC;


    component RippleCarryAdder
        Port ( A     : in  STD_LOGIC_VECTOR (3 downto 0);
               B     : in  STD_LOGIC_VECTOR (3 downto 0);
               Cin   : in  STD_LOGIC;
               Sum   : out STD_LOGIC_VECTOR (3 downto 0);
               Cout  : out STD_LOGIC);
    end component;

begin


    UUT: RippleCarryAdder port map (
        A    => A,
        B    => B,
        Cin  => Cin,
        Sum  => Sum,
        Cout => Cout
    );


    process
    begin
        --0+0
        A <= "0000"; B <= "0000"; Cin <= '0';
        wait for 10 ns;
        --1+1
        A <= "0001"; B <= "0001"; Cin <= '0';
        wait for 10 ns;
        --5+3
        A <= "0101"; B <= "0011"; Cin <= '0';
        wait for 10 ns;
        --7+5
        A <= "0111"; B <= "0101"; Cin <= '1';
        wait for 10 ns;
        --15+1
        A <= "1111"; B <= "0001"; Cin <= '0';
        wait for 10 ns;
        --15+15
        A <= "1111"; B <= "1111"; Cin <= '1';
        wait for 10 ns;
        --8+8
        A <= "1000"; B <= "1000"; Cin <= '0';
        wait for 10 ns;
        --10+10
        A <= "1010"; B <= "0101"; Cin <= '1';
        wait for 10 ns;
        wait;
    end process;

end Behavioral;
