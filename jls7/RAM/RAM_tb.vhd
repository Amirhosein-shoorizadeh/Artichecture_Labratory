library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_ram is
end entity tb_ram;

architecture test of tb_ram is
    constant DATA_WIDTH : integer := 8;
    constant ADDR_WIDTH : integer := 4;
    constant CLK_PERIOD : time := 10 ns;
    
    signal clk      : std_logic := '0';
    signal rst      : std_logic := '0';
    signal wr_en    : std_logic := '0';
    signal rd_en    : std_logic := '0';
    signal addr     : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
    signal data_in  : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
    signal data_out : std_logic_vector(DATA_WIDTH-1 downto 0);
    
begin

    clk <= not clk after CLK_PERIOD/2;
    

    uut: entity work.ram
        generic map (
            DATA_WIDTH => DATA_WIDTH,
            ADDR_WIDTH => ADDR_WIDTH
        )
        port map (
            clk      => clk,
            rst      => rst,
            wr_en    => wr_en,
            rd_en    => rd_en,
            addr     => addr,
            data_in  => data_in,
            data_out => data_out
        );
    
 
    process
    begin
        -- Reset
        rst <= '0';
        wait for 20 ns;
        rst <= '1';
        wait for 10 ns;
        
        -- Write  0 to 7
        wr_en <= '1';
        for i in 0 to 7 loop
            addr   <= std_logic_vector(to_unsigned(i, ADDR_WIDTH));
            data_in <= std_logic_vector(to_unsigned(i * 10, DATA_WIDTH));
            wait for CLK_PERIOD;
        end loop;
        wr_en <= '0';
        wait for CLK_PERIOD;
        
        -- Read  0 to 7
        rd_en <= '1';
        for i in 0 to 7 loop
            addr <= std_logic_vector(to_unsigned(i, ADDR_WIDTH));
            wait for CLK_PERIOD;
        end loop;
        rd_en <= '0';

        wait for CLK_PERIOD;
        rst <= '0';
        wait for 15 ns;
        rst <= '1';
        wait for CLK_PERIOD;

        rd_en <= '1';
        for i in 0 to 3 loop
            addr <= std_logic_vector(to_unsigned(i, ADDR_WIDTH));
            wait for CLK_PERIOD;
        end loop;
        rd_en <= '0';
        
        wait;
    end process;
    
end architecture test;
