library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CPU is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC);
end CPU;

architecture Behavioral of CPU is
-- COMPONENTS

-- Program Counter Component
component PC is
    Port ( clk : in STD_LOGIC;
           PC_Reset : in STD_LOGIC;
           PC_D : in STD_LOGIC_VECTOR (31 downto 0);
           PC_Q : out STD_LOGIC_VECTOR (31 downto 0));
end component;

-- Instruction Memory Component
component Instr_Mem is
    Port ( clk : in STD_LOGIC;
           address : in STD_LOGIC_VECTOR (31 downto 0);
           instruction : out STD_LOGIC_VECTOR (31 downto 0));
end component;

-- Data Memory Component
component Data_Mem is
    Port ( clk : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR (31 downto 0);
           WriteData : in std_logic_vector(31 downto 0);
           MemWrite : in STD_LOGIC;
           MemRead : in STD_LOGIC;
           data : out STD_LOGIC_VECTOR (31 downto 0));
end component;

-- Instruction Register Component
--component IR is
--Port (
--    clk : in STD_LOGIC;
--    rst : in STD_LOGIC;
--    memdata : in STD_LOGIC_VECTOR(31 DOWNTO 0);
--    instruction : out STD_LOGIC_VECTOR(31 DOWNTO 0));
--end component;

-- Register File Component
component RegFile is
    Port ( clk : in STD_LOGIC;
           ra1 : in STD_LOGIC_VECTOR (7 downto 0);
           ra2 : in STD_LOGIC_VECTOR (7 downto 0);
           wa : in STD_LOGIC_VECTOR (7 downto 0);
           wd : in STD_LOGIC_VECTOR (31 downto 0);
           RegWr : in STD_LOGIC;
           rd1 : out STD_LOGIC_VECTOR (31 downto 0);
           rd2 : out STD_LOGIC_VECTOR (31 downto 0));
end component;

-- Control Unit Component
component CU is
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
end component;

-- Extension Unit component
component ExtUnit is
    Port ( ExtOp : in STD_LOGIC;
           Instruction : in STD_LOGIC_VECTOR (31 downto 0);
           Ext_Imm : out STD_LOGIC_VECTOR (31 downto 0));
end component;

-- Arithmetic Logic Unit component
component ALU is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           opcode : in STD_LOGIC_VECTOR (2 downto 0);
           result : out STD_LOGIC_VECTOR (31 downto 0);
           zero : out STD_LOGIC;
           carry : out STD_LOGIC;
           sign : out STD_LOGIC;
           overflow : out STD_LOGIC);
end component;

-- Flag Register Component
component FlagReg is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           FlagEn : in STD_LOGIC;
           Carry : in STD_LOGIC;
           Zero : in STD_LOGIC;
           Sign : in STD_LOGIC;
           Overflow : in STD_LOGIC;
           CF : out STD_LOGIC;
           ZF : out STD_LOGIC;
           SF : out STD_LOGIC;
           OvF : out STD_LOGIC);
end component;

-- Decoder Component
component DCD is
    Port ( data : in STD_LOGIC_VECTOR (3 downto 0);
           output : out STD_LOGIC_VECTOR (15 downto 0));
end component;

-- 2 to 1 MUX
component MUX_2 is
    Port ( sel : in STD_LOGIC;
           in1 : in STD_LOGIC_VECTOR (31 downto 0);
           in2 : in STD_LOGIC_VECTOR (31 downto 0);
           output : out STD_LOGIC_VECTOR (31 downto 0));
end component;

-- SIGNALS
signal MemWrite_sig : STD_LOGIC;
signal MemRead_sig : STD_LOGIC;
signal RegWrite_sig : STD_LOGIC;
signal MemtoReg_sig : STD_LOGIC;
signal ALUSrcA_sig : STD_LOGIC;
signal ALUSrcB_sig : STD_LOGIC_VECTOR(1 downto 0);
signal ALUCntrl_sig : STD_LOGIC_VECTOR (2 downto 0);
signal FlagEnable_sig : STD_LOGIC;
signal Branch_sig : STD_LOGIC;
signal Jump_sig : STD_LOGIC;
signal R_sig : STD_LOGIC;

signal ZF_sig : STD_LOGIC;
signal CF_sig : STD_LOGIC;
signal SF_sig : STD_LOGIC;
signal OF_sig : STD_LOGIC;

signal FlagReg_ZF : STD_LOGIC;
signal FlagReg_CF : STD_LOGIC;
signal FlagReg_SF : STD_LOGIC;
signal FlagReg_OF : STD_LOGIC;

signal PC_in : STD_LOGIC_VECTOR(31 downto 0) := x"00000000";
signal PC_out : STD_LOGIC_VECTOR(31 downto 0);

--signal Instr_Mem_Out : STD_LOGIC_VECTOR(31 downto 0);

signal R_MUX_out : STD_LOGIC_VECTOR(7 downto 0);

signal instruction : STD_LOGIC_VECTOR(31 downto 0);
signal Write_Register : STD_LOGIC_VECTOR(31 downto 0);
signal rd1_sig : STD_LOGIC_VECTOR(31 downto 0);
signal rd2_sig : STD_LOGIC_VECTOR(31 downto 0);
signal imm_se : STD_LOGIC_VECTOR(31 downto 0);

signal ALU_in1 : STD_LOGIC_VECTOR(31 downto 0);
signal ALU_in2 : STD_LOGIC_VECTOR(31 downto 0);
signal ALU_out : STD_LOGIC_VECTOR(31 downto 0);

signal Data_Mem_Addr : STD_LOGIC_VECTOR(31 downto 0);
signal Data_Mem_OUT : STD_LOGIC_VECTOR(31 downto 0);

signal DCD1_out : STD_LOGIC_VECTOR (15 downto 0);
signal DCD2_out : STD_LOGIC_VECTOR (15 downto 0);
signal BEQ : STD_LOGIC;
signal BGT : STD_LOGIC;
signal BLT : STD_LOGIC;
signal BEQ_sig : STD_LOGIC;
signal BGT_sig : STD_LOGIC;
signal BLT_sig : STD_LOGIC;
signal Branch_MUXSel : STD_LOGIC;

signal Branch_MUX_Out : STD_LOGIC_VECTOR(31 downto 0);
signal PC_Plus4 : STD_LOGIC_VECTOR(31 downto 0);
signal PC_Branch : STD_LOGIC_VECTOR(31 downto 0);
signal PC_Jump : STD_LOGIC_VECTOR(31 downto 0);

signal Acc_out : STD_LOGIC_VECTOR(31 downto 0);

begin

    Program_Counter : PC port map ( 
        clk => clk, 
        PC_Reset  => rst,
        PC_D => PC_in,
        PC_Q => PC_out
    );
    
    Instruction_Memory : Instr_Mem port map (
       clk => clk,
       address => PC_out,
       instruction => instruction
    );
    
    Data_Memory : Data_Mem port map (
       clk => clk,
       addr => Data_Mem_Addr,
       WriteData => ALU_out,
       MemWrite => MemWrite_sig,
       MemRead => MemRead_sig,
       data => Data_Mem_OUT
    );
    
--    Instruction_Register : IR port map (
--        clk => clk,
--        rst => rst,
--        memdata => Instr_Mem_Out,
--        instruction => instruction
--    );
    
    Control_Unit : CU port map (
        opcode => instruction(31 downto 24),
        MemWrite => MemWrite_sig,
        MemRead => MemRead_sig,
        R => R_sig,
        RegWrite => RegWrite_sig,
        MemtoReg => MemtoReg_sig,
        ALUSrcA => ALUSrcA_sig,
        ALUSrcB => ALUSrcB_sig,
        ALUCntrl => ALUCntrl_sig,
        FlagEnable => FlagEnable_sig,
        Branch => Branch_sig,
        Jump => Jump_sig
    );
    
    -- R MUX Process
    process(R_sig, instruction(7 downto 0))
    begin
        case R_sig is
            when '0' => R_MUX_out <= x"00";
            when '1' => R_MUX_out <= instruction(7 downto 0);
            when others => R_MUX_out <= x"00";
        end case;
    end process;
    
    -- Process for MemtoReg MUX
    process(MemtoReg_sig, Data_Mem_OUT, ALU_out)
    begin
        case MemtoReg_sig is
            when '0' => Write_Register <= ALU_out;
            when '1' => Write_Register <= Data_Mem_OUT;
            when others => Write_Register <= x"00000000";
        end case;
    end process;
    
    Register_File : RegFile port map (
        clk => clk,
        ra1 => instruction(23 downto 16),
        ra2 => R_MUX_out,
        wa => instruction(23 downto 16),
        wd => Write_Register,
        RegWr => RegWrite_sig,
        rd1 => rd1_sig,
        rd2 => rd2_sig  
    );
    
    Zero_Ext : ExtUnit port map (
        ExtOp => '0',
        Instruction => instruction,
        Ext_Imm => Data_Mem_Addr     
    );
    
    Sign_Ext : ExtUnit port map (
        ExtOp => '1',
        Instruction => instruction,
        Ext_Imm => imm_se     
    );
    
    -- Process for A Reg MUX
    process(ALUSrcA_sig, rd1_sig)
    begin
        case ALUSrcA_sig is
            when '0' => ALU_in1 <= rd1_sig;
            when '1' => ALU_in1 <= x"00000000";
            when others => ALU_in1 <= x"00000000";           
        end case;
    end process;

    -- Process for B Reg MUX
    process(ALUSrcB_sig, rd2_sig, imm_se, Data_Mem_OUT)
    begin
        case ALUSrcB_sig is
            when "00" => ALU_in2 <= rd2_sig;
            when "01" => ALU_in2 <= imm_se;
            when "10" => ALU_in2 <= x"00000000";
            when "11" => ALU_in2 <= Data_Mem_OUT;
            when others => ALU_in2 <= x"00000000";           
        end case;
    end process;
    
    Arithmetic_Logic_Unit : ALU port map (
       A => ALU_in1,
       B => ALU_in2,
       opcode => ALUCntrl_sig,
       result => ALU_out,
       zero => ZF_sig,
       carry => CF_sig,
       sign => SF_sig,
       overflow => OF_sig    
    );
    
    Flag_Register : FlagReg port map (
       clk => clk,
       rst => rst,
       FlagEn => FlagEnable_sig,
       Carry => CF_sig,
       Zero => ZF_sig,
       Sign => SF_sig,
       Overflow => OF_sig,
       CF => FlagReg_CF,
       ZF => FlagReg_ZF,
       SF => FlagReg_SF,
       OvF => FlagReg_OF
    );
    
    -- Process for Accumulator Register Component
    process(clk, rst, ALU_out)
    begin
        if (rst = '1') then
            Acc_out <= x"00000000";
        elsif (rising_edge(clk)) then
            Acc_out <= ALU_out;
        end if;
    end process;
    
    DCD_1 : DCD port map (
        data => instruction(31 downto 28),
        output => DCD1_out
    );
    
    DCD_2 : DCD port map (
        data => instruction(27 downto 24),
        output => DCD2_out
    );
    
    BEQ <= DCD1_out(4) and DCD2_out(1);
    BGT <= DCD1_out(4) and DCD2_out(2);
    BLT <= DCD1_out(4) and DCD2_out(3);
    
    BEQ_sig <= Branch_sig and BEQ and FlagReg_ZF;
    BGT_sig <= Branch_sig and BGT and (not((FlagReg_SF xor FlagReg_OF) or FlagReg_ZF)); 
    BLT_sig <= Branch_sig and BLT and (FlagReg_SF xor FlagReg_OF);
    
    Branch_MUXSel <= BEQ_sig or BGT_sig or BLT_sig;
    
    PC_Plus4 <= PC_out + 1;
    PC_Branch <= PC_Plus4 + imm_se(15 downto 0); 
    PC_Jump <= Data_Mem_Addr;
    
    
    Branch_MUX : MUX_2 port map (
        sel => Branch_MUXSel,
        in1 => PC_Plus4,
        in2 => PC_Branch,
        output => Branch_MUX_Out
    );
    
    Jump_MUX : MUX_2 port map (
        sel => Jump_sig,
        in1 => Branch_MUX_Out,
        in2 => PC_Jump,
        output => PC_in
    );

end Behavioral;
