library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.All;

entity rom is

generic(
	W : integer := 8;
	C : integer := 4
	);
	Port(
		addr : in std_logic_vector(C-1 downto 0);
		clk : in std_logic;
		output_data : out std_logic_vector(W-1 downto 0)
	);
end rom;

architecture Behavioral of rom is
type reg is array ( 0 to (2 ** C )-1) of std_logic_vector(W-1 downto 0);
signal romBlock : reg := (
    "00000000",  
    "00000001",     
    "00000010",      
    "00000100",     
    "00001000",    
    "00010000",      
    "00100000",  
    "01000000",    
    "10000000",   
    "11111111", 	    
    "10101010",    
    "01010101",    
    "11001100",    
    "00110011",    
    "11110000",   
    "00001111"     
);

begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			output_data <= romBlock(to_integer(unsigned(addr)));
		end if;
	end process;


end Behavioral;