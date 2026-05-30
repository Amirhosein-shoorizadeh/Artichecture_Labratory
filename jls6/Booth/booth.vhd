library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity booth_multiplier_8bit is
    port (
        clk   : in  std_logic;
        rst   : in  std_logic;
        start : in  std_logic;
        m     : in  std_logic_vector(7 downto 0); 
        q_in  : in  std_logic_vector(7 downto 0);  
        prod  : out std_logic_vector(15 downto 0);
        done  : out std_logic
    );
end booth_multiplier_8bit;

architecture Behavioral of booth_multiplier_8bit is
    type state_type is (IDLE, COMPUTE, DONE_S);
    signal state : state_type := IDLE;

    signal A     : std_logic_vector(7 downto 0);
    signal Q     : std_logic_vector(7 downto 0);
    signal Q_1   : std_logic;
    signal M_reg : std_logic_vector(7 downto 0);
    signal count : integer range 0 to 7;  
begin

    process(clk, rst)
        variable a_var, q_var : std_logic_vector(7 downto 0);
        variable q_1_var      : std_logic;
        variable m_var        : std_logic_vector(7 downto 0);
        variable cnt          : integer range 0 to 7;
    begin
        if rst = '1' then
            state <= IDLE;
            A     <= (others => '0');
            Q     <= (others => '0');
            Q_1   <= '0';
            M_reg <= (others => '0');
            count <= 0;
            done  <= '0';
            prod  <= (others => '0');

        elsif rising_edge(clk) then
            done <= '0';
            case state is
                when IDLE =>
                    if start = '1' then
                        M_reg <= m;
                        Q     <= q_in;
                        A     <= (others => '0');
                        Q_1   <= '0';
                        count <= 7;
                        state <= COMPUTE;
                    end if;

                when COMPUTE =>
                    a_var   := A;
                    q_var   := Q;
                    q_1_var := Q_1;
                    m_var   := M_reg;
                    cnt     := count;

                    if (q_var(0) = '0' and q_1_var = '1') then
                        a_var := std_logic_vector(signed(a_var) + signed(m_var));
                    elsif (q_var(0) = '1' and q_1_var = '0') then
                        a_var := std_logic_vector(signed(a_var) - signed(m_var));
                    end if;

                    q_1_var := q_var(0);
                    q_var   := a_var(0) & q_var(7 downto 1);
                    a_var   := a_var(7) & a_var(7 downto 1);  

                    A   <= a_var;
                    Q   <= q_var;
                    Q_1 <= q_1_var;

                    if cnt = 0 then
                        state <= DONE_S;
                    else
                        count <= cnt - 1;
                    end if;

                when DONE_S =>
                    prod <= A & Q;
                    done <= '1';
                    state <= IDLE;
            end case;
        end if;
    end process;
end Behavioral;
