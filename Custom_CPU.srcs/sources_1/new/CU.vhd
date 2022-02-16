library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU is
    Port ( opcode : in STD_LOGIC_VECTOR (7 downto 0);
           MemWrite : out STD_LOGIC;
           MemRead : out STD_LOGIC;
           R : out STD_LOGIC;
           RegWrite : out STD_LOGIC;
           MemtoReg : out STD_LOGIC;
           ALUSrcA : out STD_LOGIC;
           ALUSrcB : out STD_LOGIC_VECTOR (1 downto 0);
           ALUCntrl : out STD_LOGIC_VECTOR (2 downto 0);
           FlagEnable : out STD_LOGIC;
           Branch : out STD_LOGIC;
           Jump : out STD_LOGIC);
end CU;

architecture Behavioral of CU is

begin

    process(opcode)
    begin
        case opcode is
            when x"10" =>   MemWrite <= '0';    -- load immediate register        
                            MemRead <= '0';
                            R <= '0';
                            RegWrite <= '1';
                            MemtoReg <= '0';
                            ALUSrcA <= '1';
                            ALUSrcB <= "01";
                            ALUCntrl <= "000";
                            FlagEnable <= '0';
                            Branch <= '0';
                            Jump <= '0';
                            
            when x"11" =>   MemWrite <= '0';    -- load register register
                            MemRead <= '0';
                            R <= '1';
                            RegWrite <= '1';
                            MemtoReg <= '0';
                            ALUSrcA <= '1';
                            ALUSrcB <= "00";
                            ALUCntrl <= "000";
                            FlagEnable <= '0';
                            Branch <= '0';
                            Jump <= '0';       
                            
            when x"12" =>   MemWrite <= '0';    -- load memory
                            MemRead <= '1';
                            R <= '0';
                            RegWrite <= '1';
                            MemtoReg <= '1';
                            ALUSrcA <= '-';
                            ALUSrcB <= "--";
                            ALUCntrl <= "---";
                            FlagEnable <= '0';
                            Branch <= '0';
                            Jump   <=  '0';
                            
            when x"20" =>   -- store memory
                            MemWrite    <=  '1';
                            MemRead     <=  '0';
                            R           <=  '0';
                            RegWrite    <=  '0';
                            MemtoReg    <=  '-';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "10";
                            ALUCntrl    <=  "000";
                            FlagEnable  <=  '0';
                            Branch      <=  '0';
                            Jump        <=  '0';
                            
            when x"30" =>   -- cmp
                            MemWrite    <=  '0';
                            MemRead     <=  '0';
                            R           <=  '1';
                            RegWrite    <=  '0';
                            MemtoReg    <=  '-';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "00";
                            ALUCntrl    <=  "001";
                            FlagEnable  <=  '1';
                            Branch      <=  '0';
                            Jump        <=  '0';  
                            
            when x"31" =>   -- cmpa
                            MemWrite    <=  '0';
                            MemRead     <=  '1';
                            R           <=  '0';
                            RegWrite    <=  '0';
                            MemtoReg    <=  '-';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "11";
                            ALUCntrl    <=  "001";
                            FlagEnable  <=  '1';
                            Branch      <=  '0';
                            Jump        <=  '0';       
                            
            when x"40" =>   -- jmp
                            MemWrite    <=  '0';
                            MemRead     <=  '0';
                            R           <=  '0';
                            RegWrite    <=  '0';
                            MemtoReg    <=  '-';
                            ALUSrcA     <=  '-';
                            ALUSrcB     <=  "--";
                            ALUCntrl    <=  "---";
                            FlagEnable  <=  '0';
                            Branch      <=  '0';
                            Jump        <=  '1';
                            
            when x"41" =>   -- beq
                            MemWrite    <=  '0';
                            MemRead     <=  '0';
                            R           <=  '0';
                            RegWrite    <=  '0';
                            MemtoReg    <=  '-';
                            ALUSrcA     <=  '-';
                            ALUSrcB     <=  "--";
                            ALUCntrl    <=  "---";
                            FlagEnable  <=  '0';
                            Branch      <=  '1';
                            Jump        <=  '0';   
                            
            when x"42" =>   -- bgt
                            MemWrite    <=  '0';
                            MemRead     <=  '0';
                            R           <=  '0';
                            RegWrite    <=  '0';
                            MemtoReg    <=  '-';
                            ALUSrcA     <=  '-';
                            ALUSrcB     <=  "--";
                            ALUCntrl    <=  "---";
                            FlagEnable  <=  '0';
                            Branch      <=  '1';
                            Jump        <=  '0';
                             
            when x"43" =>   -- blt
                            MemWrite    <=  '0';
                            MemRead     <=  '0';
                            R           <=  '0';
                            RegWrite    <=  '0';
                            MemtoReg    <=  '-';
                            ALUSrcA     <=  '-';
                            ALUSrcB     <=  "--";
                            ALUCntrl    <=  "---";
                            FlagEnable  <=  '0';
                            Branch      <=  '1';
                            Jump        <=  '0';
                            
            when x"50" =>   -- add
                            MemWrite    <=  '0';
                            MemRead     <=  '0';
                            R           <=  '1';
                            RegWrite    <=  '1';
                            MemtoReg    <=  '0';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "00";
                            ALUCntrl    <=  "000";
                            FlagEnable  <=  '1';
                            Branch      <=  '0';
                            Jump        <=  '0';  
                            
            when x"51" =>   -- addi
                            MemWrite    <=  '0';
                            MemRead     <=  '0';
                            R           <=  '0';
                            RegWrite    <=  '1';
                            MemtoReg    <=  '0';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "01";
                            ALUCntrl    <=  "000";
                            FlagEnable  <=  '1';
                            Branch      <=  '0';
                            Jump        <=  '0';
                            
            when x"52" =>   -- addm
                            MemWrite    <=  '0';
                            MemRead     <=  '1';
                            R           <=  '0';
                            RegWrite    <=  '1';
                            MemtoReg    <=  '0';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "11";
                            ALUCntrl    <=  "000";
                            FlagEnable  <=  '1';
                            Branch      <=  '0';
                            Jump        <=  '0';
                            
            when x"53" =>   -- sub
                            MemWrite    <=  '0';
                            MemRead     <=  '0';
                            R           <=  '1';
                            RegWrite    <=  '1';
                            MemtoReg    <=  '0';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "00";
                            ALUCntrl    <=  "001";
                            FlagEnable  <=  '1';
                            Branch      <=  '0';
                            Jump        <=  '0';                            
                            
            when x"54" =>   -- subi
                            MemWrite    <=  '0';
                            MemRead     <=  '0';
                            R           <=  '0';
                            RegWrite    <=  '1';
                            MemtoReg    <=  '0';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "01";
                            ALUCntrl    <=  "001";
                            FlagEnable  <=  '1';
                            Branch      <=  '0';
                            Jump        <=  '0'; 
                             
            when x"55" =>   -- subm
                            MemWrite    <=  '0';
                            MemRead     <=  '1';
                            R           <=  '0';
                            RegWrite    <=  '1';
                            MemtoReg    <=  '0';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "11";
                            ALUCntrl    <=  "001";
                            FlagEnable  <=  '1';
                            Branch      <=  '0';
                            Jump        <=  '0';
                            
            when x"60" =>   -- and
                            MemWrite    <=  '0';
                            MemRead     <=  '0';
                            R           <=  '1';
                            RegWrite    <=  '1';
                            MemtoReg    <=  '0';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "00";
                            ALUCntrl    <=  "010";
                            FlagEnable  <=  '1';
                            Branch      <=  '0';
                            Jump        <=  '0';
                            
            when x"61" =>   -- andi
                            MemWrite    <=  '0';
                            MemRead     <=  '0';
                            R           <=  '0';
                            RegWrite    <=  '1';
                            MemtoReg    <=  '0';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "01";
                            ALUCntrl    <=  "010";
                            FlagEnable  <=  '1';
                            Branch      <=  '0';
                            Jump        <=  '0';
                             
            when x"62" =>   -- andm
                            MemWrite    <=  '0';
                            MemRead     <=  '1';
                            R           <=  '0';
                            RegWrite    <=  '1';
                            MemtoReg    <=  '0';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "11";
                            ALUCntrl    <=  "010";
                            FlagEnable  <=  '1';
                            Branch      <=  '0';
                            Jump        <=  '0';
                            
            when x"63" =>   -- or
                            MemWrite    <=  '0';
                            MemRead     <=  '0';
                            R           <=  '1';
                            RegWrite    <=  '1';
                            MemtoReg    <=  '0';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "00";
                            ALUCntrl    <=  "011";
                            FlagEnable  <=  '1';
                            Branch      <=  '0';
                            Jump        <=  '0';
                            
            when x"64" =>   -- ori
                            MemWrite    <=  '0';
                            MemRead     <=  '0';
                            R           <=  '0';
                            RegWrite    <=  '1';
                            MemtoReg    <=  '0';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "01";
                            ALUCntrl    <=  "011";
                            FlagEnable  <=  '1';
                            Branch      <=  '0';
                            Jump        <=  '0';
                             
            when x"65" =>   -- orm
                            MemWrite    <=  '0';
                            MemRead     <=  '1';
                            R           <=  '0';
                            RegWrite    <=  '1';
                            MemtoReg    <=  '0';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "11";
                            ALUCntrl    <=  "011";
                            FlagEnable  <=  '1';
                            Branch      <=  '0';
                            Jump        <=  '0';
                             
            when x"66" =>   -- xor
                            MemWrite    <=  '0';
                            MemRead     <=  '0';
                            R           <=  '1';
                            RegWrite    <=  '1';
                            MemtoReg    <=  '0';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "00";
                            ALUCntrl    <=  "100";
                            FlagEnable  <=  '1';
                            Branch      <=  '0';
                            Jump        <=  '0';
                            
            when x"67" =>   -- xori
                            MemWrite    <=  '0';
                            MemRead     <=  '0';
                            R           <=  '0';
                            RegWrite    <=  '1';
                            MemtoReg    <=  '0';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "01";
                            ALUCntrl    <=  "100";
                            FlagEnable  <=  '1';
                            Branch      <=  '0';
                            Jump        <=  '0';
                            
            when x"68" =>   -- xorm
                            MemWrite    <=  '0';
                            MemRead     <=  '1';
                            R           <=  '0';
                            RegWrite    <=  '1';
                            MemtoReg    <=  '0';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "11";
                            ALUCntrl    <=  "100";
                            FlagEnable  <=  '1';
                            Branch      <=  '0';
                            Jump        <=  '0';
 
            when x"69" =>   -- not
                            MemWrite    <=  '0';
                            MemRead     <=  '0';
                            R           <=  '0';
                            RegWrite    <=  '1';
                            MemtoReg    <=  '0';
                            ALUSrcA     <=  '0';
                            ALUSrcB     <=  "--";
                            ALUCntrl    <=  "101";
                            FlagEnable  <=  '1';
                            Branch      <=  '0';
                            Jump        <=  '0';
                            
            when x"00"  =>  -- noOp (0+0)
                            MemWrite    <=  '0';
                            MemRead     <=  '0';
                            R           <=  '0';
                            RegWrite    <=  '0';
                            MemtoReg    <=  '0';
                            ALUSrcA     <=  '1';
                            ALUSrcB     <=  "10";
                            ALUCntrl    <=  "000";
                            FlagEnable  <=  '0';
                            Branch      <=  '0';
                            Jump        <=  '0';
                                        
            when others =>  
                            MemWrite    <=  '0';
                            MemRead     <=  '0';
                            R           <=  '0';
                            RegWrite    <=  '-';
                            MemtoReg    <=  '-';
                            ALUSrcA     <=  '-';
                            ALUSrcB     <=  "--";
                            ALUCntrl    <=  "---";
                            FlagEnable  <=  '-';
                            Branch      <=  '0';
                            Jump        <=  '0';                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
        end case;
    end process;

end Behavioral;
