library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Instr_Mem is
    Port ( clk : in STD_LOGIC;
           address : in STD_LOGIC_VECTOR (31 downto 0);
           instruction : out STD_LOGIC_VECTOR (31 downto 0));
end Instr_Mem;

architecture Behavioral of Instr_Mem is

type rom_array is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
constant rom : rom_array := (
        -- normal fib
--        x"1001000A",
--        x"10020000",
--        x"10030001",
--        x"10040000",
--        x"10050002",
--        x"30050001",
--        x"41000007",
--        x"50020003",
--        x"11040002",
--        x"11020003",
--        x"11030004",
--        x"51050001",
--        x"40000005",
--        x"11070004",
        
        -- memory addressing fib
--        x"1001000A",
--        x"10020000",
--        x"10030001",
--        x"10040000",
--        x"10050002",
--        x"20010001",
--        x"20020002",
--        x"20030003",
--        x"20040004",
--        x"31050001",
--        x"4100000A",
--        x"10010000",
--        x"12010002",
--        x"52010003",
--        x"20010004",
--        x"12010003",
--        x"20010002",
--        x"12010004",
--        x"20010003",
--        x"51050001",
--        x"40000009",
--        x"12070004",

        -- Euclid
--        x"100100C6",
--        x"1002002A",      
--        x"30010002",
--        x"42000001",
--        x"43000003",
--        x"41000005",
--        x"53010002",
--        x"40000002",
--        x"00000000",
--        x"53020001",
--        x"40000002",
--        x"00000000", 
--        x"11030001",

--        -- subi and subm
----        lir $R1, 000A
--        x"1001000A",
----        subi $R1, 0005
--        x"54010005",             
----        lir $R1, 0005
--        x"10010005",
----        sm $R1, 0001
--        x"20010001",
----        lir $R2, 000A
--        x"1002000A",
----        subm $R2, 0001
--        x"55020001",
        
        -- Logical instructions
        -- AND
--        x"1001000B",        -- lir $R1, 000B 
--        x"10020005",        -- lir $R2, 0005       
--        x"20020001",        -- sm $R2, 0001
                      
--        x"60010002",        -- and $R1, $R2 => R1 = 1
--        x"1001000B",        -- lir $R1, 000B         
--        x"61010005",        -- andi $R1, 0005 => R1 = 1
--        x"1001000B",        -- lir $R1, 000B         
--        x"62010001",        -- andm $R1, 0001 => R1 = 1       
--        -- OR      
--        x"1001000B",        -- lir $R1, 000B       
--        x"10020005",        -- lir $R2, 0005       
--        x"20020001",        -- sm $R2, 0001        
                      
--        x"63010002",        -- or $R1, $R2 => R1 = F
--        x"1001000B",        -- lir $R1, 000B         
--        x"64010005",        -- ori $R1, 0005 => R1 = F
--        x"1001000B",        -- lir $R1, 000B        
--        x"65010001",        -- orm $R1, 0001 => R1 = F
--        -- XOR          
--        x"1001000B",        -- lir $R1, 000B          
--        x"10020005",        -- lir $R2, 0005          
--        x"20020001",        -- sm $R2, 0001           
                                                      
--        x"66010002",        -- xor $R1, $R2 => R1 = E
--        x"1001000B",        -- lir $R1, 000B   
--        x"67010005",        -- xori $R1, 0005 => R1 = E
--        x"1001000B",        -- lir $R1, 000B 
--        x"68010001",        -- xorm $R1, 0001 => R1 = E
--        -- NOT
--        x"1001000B",        -- lir $R1, 000B 
--        x"69010000",        -- not $R1 => R1 = 4

            x"51010001", --        ADDI $r1, 0001 
            x"20010001", --        SM $R1, 0001
            x"12020001", --        LM $R2, 0001
            x"51020002", --        ADDI $R2, 0002

        others => x"00000000"
    );
    
begin

    process(clk, address)
    begin
        if (rising_edge(clk)) then
            instruction <= rom(conv_integer(address));
        end if;
    end process;

end Behavioral;
