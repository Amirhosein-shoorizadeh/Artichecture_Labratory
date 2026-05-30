library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Multiplier_4x4_tb is
end Multiplier_4x4_tb;

architecture Behavioral of Multiplier_4x4_tb is

    component Multiplier_4x4 is
        Port ( X : in  STD_LOGIC_VECTOR (3 downto 0);
               Y : in  STD_LOGIC_VECTOR (3 downto 0);
               P : out STD_LOGIC_VECTOR (7 downto 0)
             );
    end component;

    signal X_tb : STD_LOGIC_VECTOR (3 downto 0);
    signal Y_tb : STD_LOGIC_VECTOR (3 downto 0);
    signal P_tb : STD_LOGIC_VECTOR (7 downto 0);

begin

    UUT: Multiplier_4x4 port map (X => X_tb, Y => Y_tb, P => P_tb);

    process
    begin
        -- 15= 3*5
        X_tb <= "0011";  -- 3
        Y_tb <= "0101";  -- 5
        wait for 10 ns;
        
        -- 14 = 2*7
        X_tb <= "0111";  -- 7
        Y_tb <= "0010";  -- 2
        wait for 10 ns;
        
        -- 15 * 15 = 225 = 11110001
        X_tb <= "1111";  -- 15
        Y_tb <= "1111";  -- 15
        wait for 10 ns;
        
        --  0 * 8 = 0
        X_tb <= "0000";  -- 0
        Y_tb <= "1000";  -- 8
        wait for 10 ns;
        
        --  10 * 10 = 100
        X_tb <= "1010";  -- 10
        Y_tb <= "1010";  -- 10
        wait for 10 ns;
        
        wait;
    end process;

end Behavioral;
