
entity tempomat_cpu is
    type commands is (
        IN_C,
        OUTL_C,
        OUTH_C,
        OUTCR_C,
        LDA_C,
        INC_C,
        DEC_C,
        STA_C,
        LDA_C,
        CMP_C,
        JC_C,
        JZ_C,
        JMP_C,
        WAIT_C
    );

    type registers is (
        ACC,
        Reg1
    );
    port(
            rst_in : in std_logic;
            clk_in : in std_logic;
            data_in : in std_logic_vector(7 downto 0); -- 8 bits required.
            addr_out : out std_logic_vector(7 downto 0) -- Quite possible that we can make this smaller.
    );
begin
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
