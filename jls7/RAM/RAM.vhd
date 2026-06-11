library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ram is
    generic (
        DATA_WIDTH  : integer := 8;  
        ADDR_WIDTH  : integer := 4   
    );
    port (
        clk      : in  std_logic;                     
        rst      : in  std_logic;                        
        

        wr_en    : in  std_logic;        
        rd_en    : in  std_logic;                          
        
        addr     : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
        data_in  : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        data_out : out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end entity ram;

architecture rtl of ram is
    type ram_memory_t is array (0 to (2**ADDR_WIDTH)-1) of std_logic_vector(DATA_WIDTH-1 downto 0);

    signal memory : ram_memory_t;
    signal data_out_reg : std_logic_vector(DATA_WIDTH-1 downto 0);
begin

    process(clk, rst)
    begin
        if rst = '0' then
            for i in 0 to (2**ADDR_WIDTH)-1 loop
                memory(i) <= (others => '0');
            end loop;
            data_out_reg <= (others => '0');            
        elsif rising_edge(clk) then
            if wr_en = '1' and rd_en = '0' then
                memory(to_integer(unsigned(addr))) <= data_in;
            end if;  
            if rd_en = '1' and wr_en = '0' then
                data_out_reg <= memory(to_integer(unsigned(addr)));
            end if;
        end if;
    end process;
    data_out <= data_out_reg;

end architecture rtl;
