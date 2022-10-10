library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity secuencia is
    port (
        Ent_s: in std_logic;
        clk: in std_logic;
        rst: in std_logic;
        Sec_det: out std_logic
    ); 
end secuencia;

architecture Behavioral of secuencia is
    -- Estados en los que se entrara --
    type MOORE_FSM is (Cero, Uno, UnoUno, UnoUnoUno); 
    -- Señal para cuando se realice cambio de estado --
    signal pr_state, nx_state: MOORE_FSM; 
begin
-- memoria secuencial --
process (rst, clk)
begin
    --si el reset esta activo se regresa a esatdo cero
    if(rst='1') then
        pr_state <= Cero; 
        
    elsif (rising_edge(clk)) then
    --elsif (clk'EVENT AND clk='1') then
        pr_state <= nx_state;
    end if; 
end process;

-- Logica para la maquina de estados y el detector de secuencia --
process (Ent_s, pr_state)
begin
    case pr_state is
    when Cero =>
        Sec_det <= '0';
        if(Ent_s = '1') then 
            nx_state <= Uno;
        else 
            nx_state <= Cero; 
        end if;
    when Uno =>
        Sec_det <= '0';
        if (Ent_s = '1') then 
            nx_state <= UnoUno;
        else 
            nx_state <= Cero; 
        end if;
    when UnoUno =>
        Sec_det <= '0';
        if(Ent_s = '1') then 
            nx_state <= UnoUnoUno;
        else 
            nx_state <= Cero;
           
        end if; 
    when UnoUnoUno =>
        Sec_det <= '1';
        if(Ent_s = '0') then 
            nx_state <= Cero;
        else  
            nx_state <= UnoUnoUno;
            
        end if; 
    end case;
end process; 
-- Logica para cuando de salida para cuando
-- encuentre la secuencia 
--process(pr_state)
--begin
    --case pr_state is
        --when Cero =>
            --Sec_det <= '0';
        
        --when Uno =>
            --Sec_det <= '0';
        
        --when UnoUno =>
            --Sec_det <= '0';
         
        --when UnoUnoUno =>
            --Sec_det <= '1';
     --end case;
--end process;
end Behavioral;
        

