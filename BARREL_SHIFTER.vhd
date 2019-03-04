-- =============================================================
-- |				RISC-V RV32I(M) ISA IMPLEMENTATION  	   |
-- =============================================================
-- |student:    Deligiannis Nikos							   |
-- |supervisor: Aristides Efthymiou						       |
-- =============================================================
-- |			    UNIVERSITY OF IOANNINA - 2019 			   |
-- |  					 VCAS LABORATORY 					   |
-- =============================================================

-- *** 3/5: ARITHMETIC AND LOGIC UNIT (EXE-ALU) MODULE DESIGN ***
----------------------------------------------------------------------
-- PART#3: BARREL SHIFTER
-- " This Barrel Shifter will be doing the following operations: 
--   Shift Left Logical, Shift Right Logical, Shift Right Arithmetic
--   which will be defined by the following opcodes
--              *---------------------------------*
--              |     OPCODE     ||     OP        |
--			    |---------------------------------|
--              |       00       ||    SRL        |
--              |       01       ||    SLL        |
--              |       10       ||    SRA        |
--              |       11       ||   ERROR       |
--              *---------------------------------* "
----------------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

LIBRARY WORK;
USE WORK.TOOLBOX.ALL;

ENTITY BARREL_SHIFTER IS

	PORT (
			VALUE_A : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
			SHAMT_B : IN  STD_LOGIC_VECTOR(4  DOWNTO 0);
			OPCODE  : IN  STD_LOGIC_VECTOR(1  DOWNTO 0); 
			RESULT  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		 );
		 
END BARREL_SHIFTER;

ARCHITECTURE STRUCTURAL OF BARREL_SHIFTER IS
	
	SIGNAL SRA_BUF   : STD_LOGIC;
	SIGNAL R_L_SHIFT : STD_LOGIC;
	
	SIGNAL STAGE_16_SHIFT : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL STAGE_8_SHIFT  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL STAGE_4_SHIFT  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL STAGE_2_SHIFT  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL STAGE_1_SHIFT  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	BEGIN
				
	R_L_SHIFT <= OPCODE(0);
	
	
	SRA_MUX: MUX2X1_BIT
			 PORT MAP ( 
						D0  => '0',
						D1  => VALUE_A(31),
						SEL => OPCODE(1),
						O   => SRA_BUF
					  );
					  
	SHIFT_STAGES: FOR I IN 4 DOWNTO 0 GENERATE
		
		SHIFT_BY_16: IF I = 4 GENERATE
				
			CELLS: FOR J IN 31 DOWNTO 0 GENERATE 
			
				TOP_16_BITS: IF J >= 16 GENERATE 
					
					MSBS: BARREL_CELL
						  PORT MAP (
									 D0  => VALUE_A(J),
									 D1  => VALUE_A(J-16),
									 D2  => SRA_BUF, -- RIGHT SHIFT LOGIC OR ARITHMETIC
									 SEL => (NOT(R_L_SHIFT) AND SHAMT_B(I)) & (R_L_SHIFT AND SHAMT_B(I)),
									 O   => STAGE_16_SHIFT(J)
									);
									
				END GENERATE TOP_16_BITS;
				
				BOT_16_BITS: IF J <= 15 GENERATE
					
					LSBS: BARREL_CELL
						  PORT MAP (
									 D0  => VALUE_A(J),
									 D1  => SRA_BUF, -- LEFT SHIFT LOGIC
									 D2  => VALUE_A(J+16),
									 SEL => (NOT(R_L_SHIFT) AND SHAMT_B(I)) & (R_L_SHIFT AND SHAMT_B(I)),
									 O   => STAGE_16_SHIFT(J)
								   );
								   
				END GENERATE BOT_16_BITS;
			
			END GENERATE CELLS;	
			
		END GENERATE SHIFT_BY_16;	
		
		SHIFT_BY_8:  IF I = 3 GENERATE
	
			CELLS: FOR J IN 31 DOWNTO 0 GENERATE
	
				TOP_8_BITS: IF J >= 24 GENERATE
	
					MSBS: BARREL_CELL
						  PORT MAP (
									 D0  => STAGE_16_SHIFT(J),
									 D1  => STAGE_16_SHIFT(J-8),
									 D2  => SRA_BUF,
									 SEL => (NOT(R_L_SHIFT) AND SHAMT_B(I)) & (R_L_SHIFT AND SHAMT_B(I)),
									 O   => STAGE_8_SHIFT(J)
									);
				END GENERATE TOP_8_BITS;
				
				MID_16_BITS: IF J < 24 AND J > 7 GENERATE
	
					MIDS: BARREL_CELL
						  PORT MAP (
								     D0  => STAGE_16_SHIFT(J),
								     D1  => STAGE_16_SHIFT(J-8),
								     D2  => STAGE_16_SHIFT(J+8),
								     SEL => (NOT(R_L_SHIFT) AND SHAMT_B(I)) & (R_L_SHIFT AND SHAMT_B(I)),
								     O   => STAGE_8_SHIFT(J)
								    );
				END GENERATE MID_16_BITS;
				
				BOT_8_BITS: IF J <= 7 GENERATE
	
					LSBS: BARREL_CELL
						  PORT MAP (
									 D0  => STAGE_16_SHIFT(J),
									 D1  => SRA_BUF,
									 D2  => STAGE_16_SHIFT(J+8),
									 SEL => (NOT(R_L_SHIFT) AND SHAMT_B(I)) & (R_L_SHIFT AND SHAMT_B(I)),
									 O   => STAGE_8_SHIFT(J)
									);
									
				END GENERATE BOT_8_BITS;
				
			END GENERATE CELLS;
			
		END GENERATE SHIFT_BY_8;
		
		SHIFT_BY_4: IF I = 2 GENERATE
	
			CELLS: FOR J IN 31 DOWNTO 0 GENERATE
	
				TOP_4_BITS: IF J >= 28 GENERATE
	
					MSBS: BARREL_CELL
						  PORT MAP (
									 D0  => STAGE_8_SHIFT(J),
									 D1  => STAGE_8_SHIFT(J-4),
									 D2  => SRA_BUF,
									 SEL => (NOT(R_L_SHIFT) AND SHAMT_B(I)) & (R_L_SHIFT AND SHAMT_B(I)),
									 O   => RESULT(J)
								   );
								   
				END GENERATE TOP_4_BITS;
				
				MID_24_BITS: IF J < 28 AND J > 3 GENERATE
	
					MIDS: BARREL_CELL
						  PORT MAP ( 
									 D0  => STAGE_8_SHIFT(J),
									 D1  => STAGE_8_SHIFT(J-4),
									 D2  => STAGE_8_SHIFT(J+4),
									 SEL => (NOT(R_L_SHIFT) AND SHAMT_B(I)) & (R_L_SHIFT AND SHAMT_B(I)),
									 O   => RESULT(J)
									);
									
				END GENERATE MID_24_BITS;
				
				BOT_4_BITS: IF J <= 3 GENERATE
	
					LSBS: BARREL_CELL
						  PORT MAP (
									 D0  => STAGE_8_SHIFT(J),
									 D1  => SRA_BUF,
									 D2  => STAGE_8_SHIFT(J+4),
									 SEL => (NOT(R_L_SHIFT) AND SHAMT_B(I)) & (R_L_SHIFT AND SHAMT_B(I)),
									 O   => RESULT(J)
									);
									
				END GENERATE BOT_4_BITS;
				
			END GENERATE CELLS;
			
		END GENERATE SHIFT_BY_4;
		
	END GENERATE SHIFT_STAGES;
			
END STRUCTURAL;
				
	