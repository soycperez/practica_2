library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Como es un archivo TB no tiene puertos
entity secuencia_tb is
end secuencia_tb;

architecture Behavioral of secuencia_tb is

    component secuencia
        port (
            Ent_s: in std_logic;
            clk: in std_logic;
            rst: in std_logic;
            Sec_det: out std_logic
        );
    end component;
    
    --Entradas
    signal Ent_s:std_logic;
    signal clk : std_logic;
    signal rst : std_logic;
    signal Sec_det :std_logic;
     -- Estados en los que se entrara --
    --type MOORE_FSM is (Cero, Uno, UnoUno, UnoUnoUno); 
    -- Señal para cuando se realice cambio de estado --
    --signal pr_state: MOORE_FSM; 
    --definicion del periodo del reloj
    constant clock_period : time := 10ns;
    
    -- Control de simulacion
    shared variable ENDSIM:boolean :=false;

    
begin
    -- Instancia de la maquina de estados finitos para detectar secuencia
    uut: secuencia port map(
        Ent_s =>Ent_s,
        clk=>clk,
        rst=>rst,
        Sec_det=>Sec_det
    );
    
    --Proceso de reloj
    clock_process: process
    begin
        if ENDSIM = false then
            clk <= '0'; 
            wait for clock_period/2; 
            clk <= '1'; 
            wait for clock_period/2;
        else
            wait;
        end if;  
    end process;
    
    --Proceso de estimulos
    stim_proc:process    
    begin
        Ent_s <= '0';
        rst<='1';
        wait for 100 ns;
        rst<='0';
        wait for 20ns;
        Ent_s <= '0';
        wait for 10ns;
        Ent_s <= '1';
        wait for 10ns;
        Ent_s <= '1';
        wait for 10ns;
        Ent_s <= '1';        
        wait for 10ns;
        Ent_s <= '0';       
        wait for 10ns;
        Ent_s <= '1';      
        wait for 10ns;
        Ent_s <= '0';       
                  
        wait until rising_edge(clk);
        ENDSIM:=true;
       wait;
   end process;
end Behavioral;
        

