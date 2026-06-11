library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ram_dual_port is
    generic (
        W : integer := 8;
        C : integer := 4
    );
    port (
     
        wr_A : in std_logic;
        wr_B : in std_logic;
      
        rd_A : in std_logic;
        rd_B : in std_logic;
     
        clk : in std_logic;
     
        addr_RD : in std_logic_vector(C-1 downto 0);
   
        addr_WR : in std_logic_vector(C-1 downto 0);
  
        rst : in std_logic;
   
        data_in_A : in std_logic_vector(W-1 downto 0);
        data_in_B : in std_logic_vector(W-1 downto 0);
 
        data_out_A : out std_logic_vector(W-1 downto 0);
        data_out_B : out std_logic_vector(W-1 downto 0)
    );
end ram_dual_port;

architecture Behavioral of ram_dual_port is
    type mem is array ((2 ** C) - 1 downto 0) of std_logic_vector(W - 1 downto 0);
    signal memory : mem;
begin
    process(rst, clk)
    begin
        if(rst = '0') then
            for i in 0 to (2 ** C) - 1 loop
                memory(i) <= std_logic_vector(to_unsigned(i, W));
            end loop;
        elsif(rising_edge(clk)) then
            
            if(wr_A = '1') then
                memory(to_integer(unsigned(addr_WR))) <= data_in_A;
            end if;
            
            if(rd_A = '1') then
                data_out_A <= memory(to_integer(unsigned(addr_RD)));
            end if;
            
        
            if(wr_B = '1') then
                memory(to_integer(unsigned(addr_WR))) <= data_in_B;
            end if;
            
            if(rd_B = '1') then
                data_out_B <= memory(to_integer(unsigned(addr_RD)));
            end if;
        end if;
    end process;
end Behavioral;
