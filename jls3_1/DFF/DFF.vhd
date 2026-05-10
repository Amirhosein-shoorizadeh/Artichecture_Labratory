library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff is
    Port (
        clk     : in  STD_LOGIC;      
        reset : in  STD_LOGIC;       
        d       : in  STD_LOGIC;         
        q : out std_logic := '0'          
    );
end dff;

architecture Behavioral of dff is
begin
    process (clk, reset)
    begin
        if reset = '0' then
            q <= '0';                   
        elsif rising_edge(clk) then     
            q <= d;
        end if;
    end process;
end Behavioral;
