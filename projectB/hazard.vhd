--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_unsigned.ALL;
--
--entity Hazard is -- DO NOT modify the interface (entity)
--    Port ( 	
--			IdEx_Out_MemRead	:	in STD_LOGIC;
--			IdEx_Out_InstrRd	:	in STD_LOGIC_VECTOR(4 downto 0);
--			IfId_Out_Instr		:	in STD_LOGIC_VECTOR(31 downto 0);
--			Contr_Branch		:	in STD_LOGIC;
--			IdEx_Out_RegWrite	:	in STD_LOGIC;
--			Contr_Jump			:	in STD_LOGIC;
--			ALU_busy				:  in STD_LOGIC;
--			pc_stall 		: out STD_LOGIC;
--			if_id_stall 	: out STD_LOGIC;
--			if_id_flush		: out STD_LOGIC;
--			id_ex_stall		: out STD_LOGIC;
--			id_ex_flush		: out STD_LOGIC;
--			ex_mem_stall	: out STD_LOGIC;
--			ex_mem_flush	: out STD_LOGIC;
--			mem_wb_stall	: out STD_LOGIC;
--			mem_wb_flush	: out STD_LOGIC
--			);
--end Hazard;
--
--
--
--
--architecture mixed of Hazard is 
--
--signal	LoadUseHazard				:  STD_LOGIC;
--	 signal	UpdateBranchHazard		:  STD_LOGIC;
--	 signal	UpdateJumpRHazard			:  STD_LOGIC;
--	 signal	ControlHazard				:  STD_LOGIC;
--	 signal ALUBusyHazard				:  STD_LOGIC;
--begin
--
--	 
--	 
--
--LoadUseHazard <= '1' when IdEx_Out_MemRead = '1' 
--								and (IdEx_Out_InstrRd = IfId_Out_Instr(25 downto 21)
--									or IdEx_Out_InstrRd = IfId_Out_Instr(20 downto 16)) else
--					  '0';
--ControlHazard <= '1' when Contr_Branch = '1' or Contr_Jump = '1' else
--					  '0';
--UpdateBranchHazard <= '1' when Contr_Branch = '1' 
--										and IdEx_Out_RegWrite = '1'
--										and not(IdEx_Out_InstrRd = "00000")
--										and IdEx_Out_InstrRd = IfId_Out_Instr(25 downto 21) else
--							 '1' when Contr_Branch = '1'  -- only beq has rt
--										and IdEx_Out_RegWrite = '1'
--										and not(IdEx_Out_InstrRd = "00000")
--										and IdEx_Out_InstrRd = IfId_Out_Instr(20 downto 16) else
--							 '0';
--UpdateJumpRHazard <= '1' when IdEx_Out_RegWrite = '1'
--										and not(IdEx_Out_InstrRd = "00000")
--										and IdEx_Out_InstrRd = IfId_Out_Instr(25 downto 21) else
--							'0';
--							
--ALUBusyHazard <= ALU_busy;
--							
--							pc_stall <= LoadUseHazard when LoadUseHazard = '1' else
--			  UpdateBranchHazard when UpdateBranchHazard = '1' else
--			  UpdateJumpRHazard when UpdateJumpRHazard = '1';
--if_id_stall <= LoadUseHazard when LoadUseHazard = '1' else
--				  UpdateBranchHazard when UpdateBranchHazard = '1' else
--				  UpdateJumpRHazard when UpdateJumpRHazard = '1';
--if_id_flush <= '1' when ControlHazard = '1' and LoadUseHazard = '0' and UpdateBranchHazard = '0' and UpdateJumpRHazard = '0' else
--				  '0';
--
--
--				  
--				  id_ex_stall <= ALUBusyHazard;
--				  id_ex_flush <= '0' when LoadUseHazard = '1' or ALUBusyHazard = '1'
--							or UpdateBranchHazard = '1' or UpdateJumpRHazard = '1';
--				  
--				  ex_mem_stall <= ALUBusyHazard;
--				  
--				  
--				  mem_wb_stall <= ALUBusyHazard;
--				  
--end mixed;




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Hazard is -- DO NOT modify the interface (entity)
    Port ( 	
			control_jump	:	in STD_LOGIC;
			id_branch : in std_logic;
			branch_taken : in std_logic;
			id_ex_memRead : in std_logic;
			id_ex_regRt : in std_logic_vector(4 downto 0);
			if_id_regRs : in std_logic_vector(4 downto 0);
			if_id_regRt : in std_logic_vector(4 downto 0);
			ex_writRegSel : in std_logic_vector(4 downto 0);
			pc_stall 		: out STD_LOGIC;
			if_id_stall 	: out STD_LOGIC;
			if_id_flush		: out STD_LOGIC;
			id_ex_stall		: out STD_LOGIC;
			id_ex_flush		: out STD_LOGIC;
			ex_mem_stall	: out STD_LOGIC;
			ex_mem_flush	: out STD_LOGIC;
			mem_wb_stall	: out STD_LOGIC;
			mem_wb_flush	: out STD_LOGIC
			);
end Hazard;




architecture mixed of Hazard is 

signal temp_stall : std_logic;

begin


			

			id_ex_stall		<= '0';
			ex_mem_stall	<= '0';
			ex_mem_flush	<= '0';
			mem_wb_stall	<= '0';
			mem_wb_flush	<= '0';

--write_process : process(control_jump, id_branch, id_ex_memRead, id_ex_regRt, if_id_regRs, if_id_regRt, ex_writRegSel)
--begin
--	 if(control_jump = '1') then
--		if_id_flush <= '1';
--	 end if;
--	 
--	 if(id_branch = '1') then
--		if_id_flush <= '1';
--	 end if;
--	 
--	 if(id_ex_memRead = '1' and ((id_ex_regRt = if_id_regRs) or (id_ex_regRt = if_id_regRt))) then
--		pc_stall <= '1';
--		if_id_stall <= '1';
--		id_ex_flush <= '1';
--	 end if;
--
--	 if(id_branch = '1' and ((ex_writRegSel = if_id_regRs) or (ex_writRegSel = if_id_regRt))) then
--		pc_stall <= '1';
--		if_id_stall <= '1';
--		id_ex_flush <= '1';
--	 end if;
--		
--end process write_process;	 



if_id_flush <= '1' when control_jump = '1' or (branch_taken = '1' and not (id_branch = '1' and (not (ex_writRegSel = "00000")) and ((ex_writRegSel = if_id_regRs) or (ex_writRegSel = if_id_regRt)))) else
					'0';
	
temp_stall <= '1' when (id_ex_memRead = '1' and (not (id_ex_regRt = "00000")) and ((id_ex_regRt = if_id_regRs) or (id_ex_regRt = if_id_regRt))) or (id_branch = '1' and (not (ex_writRegSel = "00000")) and ((ex_writRegSel = if_id_regRs) or (ex_writRegSel = if_id_regRt))) else
				'0';
				
--if_id_stall <= '1' when (id_ex_memRead = '1' and ((id_ex_regRt = if_id_regRs) or (id_ex_regRt = if_id_regRt))) or (id_branch = '1' and ((ex_writRegSel = if_id_regRs) or (ex_writRegSel = if_id_regRt))) else
--				'0';
				
--id_ex_flush <= '1' when (id_ex_memRead = '1' and ((id_ex_regRt = if_id_regRs) or (id_ex_regRt = if_id_regRt))) or (id_branch = '1' and ((ex_writRegSel = if_id_regRs) or (ex_writRegSel = if_id_regRt))) else
--				'0';
pc_stall <= temp_stall;
if_id_stall <= temp_stall;
id_ex_flush <= temp_stall;				




end mixed;