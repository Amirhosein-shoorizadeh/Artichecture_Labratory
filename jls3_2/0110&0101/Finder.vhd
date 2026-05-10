library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sequence_detector is
    Port (
        clk     : in  STD_LOGIC;      
        reset : in  STD_LOGIC;       
        din     : in  STD_LOGIC;      
        detected : out STD_LOGIC       
    );
end sequence_detector;

architecture Behavioral of sequence_detector is
    type state_type is (S0, S1, S2, S3, S4); 
    signal current_s, next_s : state_type;
begin
    process (clk, reset)
    begin
        if reset = '0' then --reset kardan/activelow
            current_s <= S0; 
        elsif rising_edge(clk) then --assign kardan next_s be current
            current_s <= next_s; 
        end if;
    end process;
    process (current_s, din)
    begin
        detected <= '0'; 
        case current_s is
            when S0 =>
                if din = '0' then
                    next_s <= S1;
                else
                    next_s <= S0;
                end if;
--s1 0
            when S1 =>
                if din = '1' then
                    next_s <= S2;
                else
                    next_s <= S1;
                end if;
--s2 01

            when S2 =>
                if din = '1' then
                    next_s <= S3;  
                else
                    next_s <= S4;  
                end if;
--s3 011
--s4 010
            when S3 =>
                if din = '0' then
                    detected <= '1';   
                    next_s <= S1; 
-- halat bord 
                else
                    next_s <= S0;
                end if;

            when S4 =>
                if din = '1' then
                    detected <= '1';   
                    next_s <= S1;  
                else
                    next_s <= S0;
                end if;
        end case;
    end process;
end Behavioral;
