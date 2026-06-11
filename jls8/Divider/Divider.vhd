library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Restoring_Divider is
    generic (
        N : integer := 4 
    );
    port (
        clk       : in  std_logic;
        reset     : in  std_logic;
        start     : in  std_logic;
        Dividend  : in  std_logic_vector(2*N-1 downto 0); 
        Divisor   : in  std_logic_vector(N-1 downto 0);  
        Quotient  : out std_logic_vector(N-1 downto 0);   
        Remainder : out std_logic_vector(N-1 downto 0);   
        Overflow  : out std_logic;                      
        Ready     : out std_logic                        
    );
end Restoring_Divider;

architecture Behavioral of Restoring_Divider is

    type state_type is (IDLE, OVF_CHECK, SHIFT, SUB_RESTORE, DECREMENT, DONE);
    signal state : state_type;

    signal A, B, R : unsigned(N-1 downto 0);
    signal E       : std_logic;
    signal sc      : integer range 0 to N;
begin
    process(clk, reset)
        variable temp_sum : unsigned(N downto 0);
    begin
        if reset = '1' then
            state <= IDLE;
            A <= (others => '0');
            B <= (others => '0');
            R <= (others => '0');
            E <= '0';
            sc <= 0;
            Quotient <= (others => '0');
            Remainder <= (others => '0');
            Overflow <= '0';
            Ready <= '1';
        elsif rising_edge(clk) then
            case state is
                when IDLE =>
                    if start = '1' then
                        R <= unsigned(Dividend(2*N-1 downto N));
                        A <= unsigned(Dividend(N-1 downto 0));
                        B <= unsigned(Divisor);
                        sc <= N;
                        Ready <= '0';
                        Overflow <= '0';
                        state <= OVF_CHECK;
                    end if;

                when OVF_CHECK =>
                    temp_sum := ('0' & R) + ('0' & not B) + 1;
                    if temp_sum(N) = '1' then
                        Overflow <= '1';
                        state <= DONE;       
                    else                      
                        Overflow <= '0';
                        state <= SHIFT;
                    end if;

                when SHIFT =>
                    E <= R(N-1);
                    R <= R(N-2 downto 0) & A(N-1);
                    A <= A(N-2 downto 0) & '0';
                    state <= SUB_RESTORE;

                when SUB_RESTORE =>
                    temp_sum := ('0' & R) + ('0' & not B) + 1;
                    if E = '1' then 
                        R <= temp_sum(N-1 downto 0);
                        A(0) <= '1';
                    else           
                        if temp_sum(N) = '1' then 
                            R <= temp_sum(N-1 downto 0);
                            A(0) <= '1';
                        else      
                            A(0) <= '0';
                        end if;
                    end if;
                    state <= DECREMENT;
                when DECREMENT =>
                    if sc = 1 then
                        sc <= 0;
                        state <= DONE;
                    else
                        sc <= sc - 1;
                        state <= SHIFT;
                    end if;

                when DONE =>
                    Quotient <= std_logic_vector(A);
                    Remainder <= std_logic_vector(R);
                    Ready <= '1';
                    state <= IDLE;

            end case;
        end if;
    end process;
end Behavioral;