library ieee;

entity spi is
	port(
		clk	: in bit;
		data	: in bit_vector(7 downto 0);
		send	: in bit;
		sclk	: out bit;
		mosi	: out bit;
		cs		: out bit
	);
end spi;

architecture behavioral of spi is

	--Declarando o componente do divisor de frequência:
	component ClockDivider is
		generic(
			DIV	: positive
		);
		port(
			inclk	: in bit;
			clk	: out bit
		);
	end component;
	
	--Declarando o contador da transmissão e os sinais auxiliares: 
	signal counter : natural;
	signal sclk_signal, cs_signal	: bit;
	
begin
	
	--Associando os sinais do componente do divisor de frequência e definindo o fator de divisão de frequência:
	c1 : ClockDivider generic map(5) port map(clk,sclk_signal);
		
	--Sinais de Saída:
	cs 	<= not(cs_signal);
	sclk 	<= sclk_signal and not(send);
	mosi 	<= data(counter-1);
	
	--Processo de contagem:
	process(sclk_signal)
	begin 
	
		if(sclk_signal='0') then
			
			if(send='1') then
				counter <= 8;
			elsif(cs_signal='1' and send='0') then
				counter <= counter-1;
			end if;
		
		end if;
		
	end process;
	
	--Processo de ativação do sinal Chip Select (CS):
	process(counter)
	begin
	
		if(counter>0) then			
			cs_signal <= '1';	
		else
			cs_signal <= '0';
		end if;
		
	end process;
		
end behavioral;