library verilog;
use verilog.vl_types.all;
entity top is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        writedata       : out    vl_logic_vector(31 downto 0);
        dataadr         : out    vl_logic_vector(31 downto 0);
        memwrite        : out    vl_logic
    );
end top;
