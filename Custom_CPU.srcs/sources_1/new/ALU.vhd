library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           opcode : in STD_LOGIC_VECTOR (2 downto 0);
           result : out STD_LOGIC_VECTOR (31 downto 0);
           zero : out STD_LOGIC;
           carry : out STD_LOGIC;
           sign : out STD_LOGIC;
           overflow : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
   type op_type is (op_add, op_sub, op_and, op_or, 
                    op_xor, op_neg, op_nop);
   signal enum_op : op_type;

   signal a_minus_b  : STD_LOGIC_VECTOR(32 downto 0);
   signal a_plus_b   : STD_LOGIC_VECTOR(32 downto 0);
   signal reg        : STD_LOGIC_VECTOR(32 downto 0);
   signal result_sig : STD_LOGIC_VECTOR(31 downto 0);
begin
   -- based on the opcode, choose the enum type for the operation
   process(A,B,opcode)
   begin
      case opcode is
          when "000" => enum_op <= op_add;
          when "001" => enum_op <= op_sub;
          when "010" => enum_op <= op_and;
          when "011" => enum_op <= op_or;
          when "100" => enum_op <= op_xor;
          when "101" => enum_op <= op_neg;
          when others => enum_op <= op_nop;
      end case;
   end process;
   
   a_plus_b  <= STD_LOGIC_VECTOR(signed('0'&(a)) + signed('0'&(b)));
   a_minus_b <= STD_LOGIC_VECTOR(signed('0'&(a)) - signed('0'&(b)));
   
   -- based on the selected operation, update the reg signal; reg is used in computing the carry signal 
    process(A,B,enum_op,result_sig, a_plus_b, a_minus_b)
    begin
        case enum_op is
            when op_add       => reg <= a_plus_b;
            when op_sub       => reg <= a_minus_b;
            when op_and       => reg <= '0' & (A and B);
            when op_or        => reg <= '0' & (A or B);
            when op_xor       => reg <= '0' & (A xor B);
            when op_neg       => reg <= '0' & (not B);
            when op_nop       => reg <= '0' & x"00000000";
        end case;
    end process;
    
    -- -- based on the selected operation, update the result signal
    process(A,B,enum_op)
    begin
        case enum_op is
            when op_add       => result_sig <= (A + B);
            when op_sub       => result_sig <= (A - B);
            when op_and       => result_sig <= (A and B);
            when op_or        => result_sig <= (A or B);
            when op_xor       => result_sig <= (A xor B);
            when op_neg       => result_sig <= (not A);
            when op_nop       => result_sig <= x"00000000";
        end case;
    end process;
    
    -- compute the flag signals
    process(A,B,reg,enum_op,result_sig)
    begin
        -- set zero flag
        if (result_sig = x"00000000") then
            zero <= '1';
        else
            zero <= '0';
        end if;
        
        -- set carry flag
        carry <=  reg(32);
        
        -- set sign flag
        sign <= result_sig(31);
        
        -- set overflow flag
        if (enum_op = op_add) then
            if (A(31) = '0' and B(31) = '0') then
                if (result_sig(31) = '1') then
                    overflow <= '1';
                else
                    overflow <= '0';
                end if;
            elsif (A(31) = '1' and B(31) = '1') then
                if (result_sig(31) = '0') then
                    overflow <= '1';
                else
                    overflow <= '0';
                end if;
            else
                overflow <= '0';
            end if;
        elsif (enum_op = op_sub) then
            if (A(31) = '0' and B(31) = '1') then
                if (result_sig(31) = '1') then
                    overflow <= '1';
                else
                    overflow <= '0';
                end if;
            elsif (A(31) = '1' and B(31) = '0') then
                if (result_sig(31) = '0') then
                    overflow <= '1';
                else
                    overflow <= '0';
                end if;
            else
                overflow <= '0';
            end if;
        else
            overflow <= '0';
        end if;
    end process;
    
   result <= result_sig;
   
end Behavioral;
