library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tff is
    Port (
        clk     : in  STD_LOGIC; 
        reset: in  STD_LOGIC;  
        t       : in  STD_LOGIC;  
        q       : out STD_LOGIC   
    );
end tff;

architecture Behavioral of tff is
    signal q_reg : STD_LOGIC := '0';  
begin
    process (clk, reset)
    begin
        if reset = '0' then
            q_reg <= '0'; 
        elsif rising_edge(clk) then
            if t = '1' then
                q_reg <= not q_reg; 
            end if;
        end if;
    end process;
    q <= q_reg;  
end Behavioral;
