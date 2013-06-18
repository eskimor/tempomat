
entity tempomat_cpu is
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
    port(
            rst_in : in std_logic;
            clk_in : in std_logic;

            data_in : in data_t; -- 8 bits required.
            addr_out : out addr_t; -- only 5 bits required for our 20 byte program.

            wheel_knob_in : in std_logic_vector(7 downto 0);
            display_out: out std_logic_vector(7 downto 0);
            display_en_out: out std_logic;
    );
end; 

entity tempomat_mem is 
    port(
            rst_in : in std_logic;
            clk_in : in std_logic;
            data_out : out std_logic_vector(7 downto 0); 
            addr_in : out std_logic_vector(7 downto 0) 
        );
begin
end;

architecture tempomat_mc_
