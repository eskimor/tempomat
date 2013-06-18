-- DDR memory:
entity tempomat_memory is
    -- Should go to package (cpu uses it too!):
    type commands is (
        IN_C,
        OUTL_C,
        OUTH_C,
        OUTCR_C,
        LDI_C, -- Load immediate
        INC_C,
        DEC_C,
        STR_C, -- Store register
        LDR_C, -- Load register
        CMP_C,
        JC_C,
        JZ_C,
        JMP_C,
        WAIT_C
    );


    type addr_t is std_logic(4 downto 0);
    type data_t is std_logic(7 downto 0);
    
    -- end common stuff
    port(
            rst_in : in std_logic;
            clk_in : in std_logic;

            data_out : in data_t; -- 8 bits required.
            addr_in : out addr_t; -- only 5 bits required for our 20 byte program.
    );
end; 
