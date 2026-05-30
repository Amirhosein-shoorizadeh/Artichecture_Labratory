library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplier_4x4_CLA is
    Port ( X : in  STD_LOGIC_VECTOR (3 downto 0);
           Y : in  STD_LOGIC_VECTOR (3 downto 0);
           P : out STD_LOGIC_VECTOR (7 downto 0)
         );
end Multiplier_4x4_CLA;

architecture Structural of Multiplier_4x4_CLA is

    component CLA_4bit is
        Port ( A     : in  STD_LOGIC_VECTOR (3 downto 0);
               B     : in  STD_LOGIC_VECTOR (3 downto 0);
               Cin   : in  STD_LOGIC;
               Sum   : out STD_LOGIC_VECTOR (3 downto 0);
               Cout  : out STD_LOGIC
             );
    end component;

 
    signal pp0, pp1, pp2, pp3 : STD_LOGIC_VECTOR (3 downto 0);
    
  
    signal sum1, sum2, sum3 : STD_LOGIC_VECTOR (3 downto 0);
    signal cout1, cout2, cout3 : STD_LOGIC;
    
    
    signal A2, B2 : STD_LOGIC_VECTOR (3 downto 0);
    signal A3, B3 : STD_LOGIC_VECTOR (3 downto 0);

begin

 
    pp0(0) <= X(0) AND Y(0);
    pp0(1) <= X(1) AND Y(0);
    pp0(2) <= X(2) AND Y(0);
    pp0(3) <= X(3) AND Y(0);
    
    pp1(0) <= X(0) AND Y(1);
    pp1(1) <= X(1) AND Y(1);
    pp1(2) <= X(2) AND Y(1);
    pp1(3) <= X(3) AND Y(1);
    
    pp2(0) <= X(0) AND Y(2);
    pp2(1) <= X(1) AND Y(2);
    pp2(2) <= X(2) AND Y(2);
    pp2(3) <= X(3) AND Y(2);
    
    pp3(0) <= X(0) AND Y(3);
    pp3(1) <= X(1) AND Y(3);
    pp3(2) <= X(2) AND Y(3);
    pp3(3) <= X(3) AND Y(3);

  
    P(0) <= pp0(0);


     --radif1
    CLA1: CLA_4bit 
        port map (
            A(0) => pp0(1), A(1) => pp0(2), A(2) => pp0(3), A(3) => '0',
            B    => pp1,
            Cin  => '0',
            Sum  => sum1,
            Cout => cout1
        );

   
    P(1) <= sum1(0);

    -- A2 = sum1(3..1) & cout1
    A2(0) <= sum1(1);
    A2(1) <= sum1(2);
    A2(2) <= sum1(3);
    A2(3) <= cout1;
    B2 <= pp2;

    --radif2
    CLA2: CLA_4bit 
        port map (
            A    => A2,
            B    => B2,
            Cin  => '0',
            Sum  => sum2,
            Cout => cout2
        );


    P(2) <= sum2(0);

    -- A3 = sum2(3..1) & cout2
    A3(0) <= sum2(1);
    A3(1) <= sum2(2);
    A3(2) <= sum2(3);
    A3(3) <= cout2;
    B3 <= pp3;

    -- radif3
    CLA3: CLA_4bit 
        port map (
            A    => A3,
            B    => B3,
            Cin  => '0',
            Sum  => sum3,
            Cout => cout3
        );

    -- porting
    P(3) <= sum3(0);
    P(4) <= sum3(1);
    P(5) <= sum3(2);
    P(6) <= sum3(3);
    P(7) <= cout3;

end Structural;
