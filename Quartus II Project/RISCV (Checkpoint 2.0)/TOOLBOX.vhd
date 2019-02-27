-- This is a Custom PACKAGE file used to avoid duplicate code being written
-- in other files (e.g. ARCHITECTURES).

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE TOOLBOX IS

-- ================== INSTRUCTION FETCH COMPONENTS ================== --
------------------------------------------------------------------------
	-- Defined @ "I_F_RAM.vhd" file. 
	COMPONENT I_F_RAM IS
	
			PORT
				(
					address		: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
					clock		: IN STD_LOGIC  := '1';
					data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
					wren		: IN STD_LOGIC ;
					q		    : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
				);
				
	END COMPONENT I_F_RAM;
-------------------------------------------------------------------------	
-- ================== INSTRUCTION DECODE COMPONENTS ================== --
-------------------------------------------------------------------------
	-- Defined @ "MUX2X1.vhd" file.
	COMPONENT MUX2X1 IS

		GENERIC ( INSIZE : INTEGER := 10 );
	
		PORT (
				D0  : IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0);
				D1  : IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0);
			    SEL : IN  STD_LOGIC;
				O   : OUT STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0)
			 );

	END COMPONENT MUX2X1;
	
-------------------------------------------------------------------------
	-- Defined @ "MUX8X1.vhd" file.
	COMPONENT MUX8X1 IS 
		-- Defined @ "MUX8X1.vhd" file.
		GENERIC ( INSIZE : INTEGER := 10 );
		
		PORT (	
				D0  : IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D1  : IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D2  : IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D3  : IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D4  : IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D5  : IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D6  : IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D7  : IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				
				SEL : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
			 
				O : OUT STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0)
			 );

	END COMPONENT MUX8X1;
	
-------------------------------------------------------------------------
	-- Defined @ "MUX32X1.vhd" file.
	COMPONENT MUX32X1 IS

		GENERIC ( INSIZE : INTEGER := 10 );
		
		PORT (
		
				 D0: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0);
				 D1: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				 D2: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				 D3: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				 D4: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0);
				 D5: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0);
				 D6: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				 D7: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				 D8: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0);
				 D9: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D10: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D11: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D12: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0);
				D13: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0);
				D14: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D15: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D16: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D17: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D18: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D19: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D20: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D21: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D22: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D23: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D24: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0);
				D25: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0);
				D26: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D27: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0);
				D28: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D29: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D30: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				D31: IN  STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0) := NULL;
				
				SEL: IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
				
				O  : OUT STD_LOGIC_VECTOR(INSIZE-1 DOWNTO 0)
			);
			
	END COMPONENT MUX32X1;
	
-------------------------------------------------------------------------	
	-- Defined @ "REG_FLIPPER.vhd" file.
	COMPONENT REG_FLIPPER IS

		PORT (
				IF_WORD : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
				FLIP    : OUT STD_LOGIC
			 );
			 
	END COMPONENT REG_FLIPPER;
	
-------------------------------------------------------------------------
	-- Defined @ "ID_DECODER.vhd" file.
	COMPONENT ID_DECODER IS

		GENERIC ( CTRL_WORD_SIZE : INTEGER := 10 );
	
		PORT(
				MUX_2X1_SEL  : IN  STD_LOGIC;                    
				MUX_8X1_SEL  : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
				MUX_32X1_SEL : IN  STD_LOGIC_VECTOR(4 DOWNTO 0); 
				CONTROL_WORD : OUT STD_LOGIC_VECTOR(CTRL_WORD_SIZE-1 DOWNTO 0)
			);

	END COMPONENT ID_DECODER;
-------------------------------------------------------------------------
	-- Defined @ "ID_IMM_GENERATOR.vhd" file.
	COMPONENT ID_IMM_GENERATOR IS

			PORT(
					IMM_TYPE  : IN  STD_LOGIC_VECTOR(2  DOWNTO 0);
					IF_WORD   : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
					IMMEDIATE : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)	
				);
		 
	END COMPONENT ID_IMM_GENERATOR;
-------------------------------------------------------------------------	
END PACKAGE TOOLBOX;