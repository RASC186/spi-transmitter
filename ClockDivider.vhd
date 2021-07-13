library ieee;

entity ClockDivider is
	generic(
		DIV	: positive
	);
	port(
		inclk		: in bit;
		clk		: out bit
	);
end ClockDivider;

architecture behavioral of ClockDivider is

	--Declarando o sinal auxiliar do clock de saída:
	signal clock_signal : bit;

begin

	--Processo de divisão de frequência:
	process(inclk)
		
		variable counter : integer := 2*DIV;
		
	begin
		
		if (inclk'event and inclk='1') then
		
			if (counter = 0) then
	
				clock_signal <= '1';
				counter := 2*DIV-1;
			
			elsif (counter <= DIV) then

				clock_signal <= '0';
				counter := counter-1;	
						
			elsif (counter > DIV) then
			
				clock_signal <= '1';
				counter := counter-1;
			
			end if;

		end if;
				
	end process;
	
	--Sinal de Saída:
	clk <= clock_signal;
	
end behavioral;
