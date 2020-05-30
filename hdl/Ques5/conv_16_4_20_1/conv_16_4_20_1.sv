module conv_16_4_20_1(clk, reset, s_data_in_x, s_valid_x, s_ready_x, m_data_out_y, m_valid_y, m_ready_y);
    parameter                      T = 20, X_COUNT = 16, F_COUNT = 4, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT);
    input                          clk, reset, s_valid_x, m_ready_y;
    input signed [T-1:0]           s_data_in_x;
    output logic                   s_ready_x, m_valid_y;
    output logic signed [T-1:0]    m_data_out_y;
    logic [ADDR_X-1:0]             addr_x1;
    logic [ADDR_F-1:0]             addr_f;
    logic                          wr_en_x, clear_acc, en_acc, op_done;
    datapath1 d(.clk(clk), .reset(reset), .s_data_in_x(s_data_in_x), .wr_en_x(wr_en_x), .clear_acc(clear_acc), .en_acc(en_acc),
               .m_data_out_y(m_data_out_y), .m_valid_y(m_valid_y), .m_ready_y(m_ready_y), .op_done(op_done), .addr_f(addr_f),
               .addr_x1(addr_x1));
    ctrlpath1 c(.clk(clk), .reset(reset), .s_valid_x(s_valid_x), .m_ready_y(m_ready_y), .wr_en_x(wr_en_x), .clear_acc(clear_acc),
               .en_acc(en_acc), .s_ready_x(s_ready_x), .m_valid_y(m_valid_y), .op_done(op_done), .addr_f(addr_f),
               .addr_x1(addr_x1));
endmodule

module datapath1 (clk, reset, s_data_in_x, wr_en_x, clear_acc, en_acc, m_data_out_y, m_valid_y, m_ready_y, op_done, addr_f,
                 addr_x1);
    parameter                      T = 20, P = 1, X_COUNT = 16, F_COUNT = 4, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT);
    input                          clk, reset, wr_en_x, clear_acc, en_acc;
    input signed [T-1:0]           s_data_in_x;
    input [ADDR_X-1:0]             addr_x1;
    input [ADDR_F-1:0]             addr_f;
    logic signed [T-1:0]           m_data_out_y1;
    logic signed [T-1:0]           s_data_out_f, s_data_out_x1;
    output logic signed [T-1:0]    m_data_out_y;
    input logic                    m_valid_y, m_ready_y;
    logic [P:0]                    counter2;
    output logic                   op_done;
    conv_16_4_20_1_f_rom rom(.clk(clk), .addr(addr_f), .z(s_data_out_f));
    memory1 #(T, X_COUNT, ADDR_X) x_mem1(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x1), .addr(addr_x1), .wr_en(wr_en_x));
    mac1 m1 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x1), .inf(s_data_out_f), .out(m_data_out_y1),
        	.m_valid_y(m_valid_y));

    always_comb begin
        if((m_valid_y == 1) & (m_ready_y == 1)) begin
            if(counter2 == 0) begin
                m_data_out_y = m_data_out_y1;
            end
            else begin
                m_data_out_y = 0;
            end
        end
        else begin
            m_data_out_y = 0;
        end
    end
    assign op_done = (m_valid_y == 1) & (m_ready_y == 1) & (counter2 == P-1); 
    always_ff @(posedge clk) begin
        if (reset == 1) begin
            counter2 <= 0;
        end
        if((m_valid_y == 1) & (m_ready_y == 1)) begin
            counter2 <= counter2 + 1;
        end
        else if((m_valid_y == 0) & (m_ready_y == 1)) begin
            counter2 <= 0;
        end
        else if((m_valid_y == 0) & (m_ready_y == 0)) begin
            counter2 <= 0;
        end
    end
endmodule

module ctrlpath1 (clk, reset, s_valid_x, m_ready_y, wr_en_x, clear_acc, en_acc, s_ready_x, m_valid_y, op_done, addr_f,
                 addr_x1);
    parameter                      T = 20, P = 1, X_COUNT = 16, F_COUNT = 4, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT),
	                               OP_COUNT = X_COUNT-F_COUNT+1, COUNTER_V = $clog2(OP_COUNT);
    input logic                    clk, reset, s_valid_x, m_ready_y;
    output logic                   s_ready_x, m_valid_y;
    output logic [ADDR_X-1:0]             addr_x1;
    output logic [ADDR_F-1:0]      addr_f;
    output logic                   wr_en_x, clear_acc, en_acc;
    logic                          wr_done_x, loaded_x; 
    logic [COUNTER_V + 1:0]        counter;
    logic [ADDR_F:0]               counter1;
    input logic                    op_done;
    always_ff @(posedge clk) begin
        if (reset == 1) begin
            s_ready_x <= 1;
            addr_x1<= 0;
            addr_f <= 0;
            counter1 <= 0;
            en_acc <= 0;
            counter <= P;
            wr_done_x <= 0;
            m_valid_y <= 0;
        end
        if (wr_en_x == 1) begin
            addr_x1 <= addr_x1 + 1;
        end
        if (loaded_x == 1) begin
            addr_x1 <= 0;
            addr_f <= 0;
            counter1 <= 0;
            s_ready_x <= 0;
        end
        if ((s_ready_x == 0) & (m_valid_y == 0)) begin
            if (counter < OP_COUNT+1) begin
                if (counter1 == 1) begin
                    en_acc <= 1;
                end
                else if (counter1 == F_COUNT+1) begin
                    en_acc <= 0;
                end
                if (counter1 < F_COUNT+1) begin
                    addr_x1 <= addr_x1 + 1;
                    addr_f <=  addr_f + 1;
                    counter1 <= counter1 + 1;
                end
                else begin
                    m_valid_y <= 1;
                    counter <= counter + P;
                    addr_x1 <= counter + 0;
                    addr_f <= 0;
                    counter1 <= 0;
                end
            end
            else begin
                addr_x1<= 0;
                addr_f <= 0;
                counter1 <= 0;
                s_ready_x <= 1;
                counter <= P;
            end
        end
        if (clear_acc == 1) begin
            m_valid_y <= 0;
        end
    end
    assign wr_en_x = (s_ready_x == 1) & (s_valid_x == 1);
    assign loaded_x = (addr_x1 == X_COUNT-1) & (wr_en_x == 1);
    assign clear_acc = (m_valid_y == 1) & (m_ready_y == 1) & (op_done == 1);

endmodule

module mac1(clk, en_acc, reset, clear_acc, inx, inf, out, m_valid_y);
    parameter                    T = 20, MAX_VAL = ((1<<(T-1))-1), MIN_VAL = (-1*(1<<(T-1)));
    input                        clk, clear_acc, reset;
    input signed [T-1:0]         inx, inf;
    output logic signed[T-1:0]   out;
    logic signed[T:0]            out_temp;
    logic signed[T-1:0]          mul;
    logic signed[2*T-1:0]        mul_temp;
    input                        en_acc;
    input logic                  m_valid_y;

    always_ff @(posedge clk)
    begin
        mul_temp <= inx * inf;
    end

    always_ff @(posedge clk) begin
        if (reset == 1) begin
           out_temp <= 0;
        end
        else if (clear_acc == 1) begin
           out_temp <= 0;
        end
         else if(en_acc == 1) begin
           out_temp <= mul + out;
        end
    end

    always_comb begin
        if(mul_temp>MAX_VAL) begin
            mul = MAX_VAL;
        end
        else if(mul_temp<MIN_VAL) begin
            mul = MIN_VAL;
        end
        else begin
            mul = mul_temp;
        end

        if(m_valid_y == 1) begin
            if(out_temp < 0) begin
                out = 0;
            end
            else if(out_temp>MAX_VAL) begin
                out = MAX_VAL;
            end
            else begin
                out = out_temp;
            end
        end
        else if(out_temp>MAX_VAL) begin
            out = MAX_VAL;
        end
        else if(out_temp<MIN_VAL)begin 
            out = MIN_VAL;
        end
        else begin
            out = out_temp;
        end
    end
endmodule

module memory1(clk, data_in, data_out, addr, wr_en);
    parameter                   WIDTH=16, SIZE=64, LOGSIZE=6;
    input [WIDTH-1:0]           data_in;
    output logic [WIDTH-1:0]    data_out;
    input [LOGSIZE-1:0]         addr;
    input                       clk, wr_en;

    logic [SIZE-1:0][WIDTH-1:0] mem;

    always_ff @(posedge clk) begin
        data_out <= mem[addr];
        if (wr_en)
            mem[addr] <= data_in;
    end
endmodule

module conv_16_4_20_1_f_rom(clk, addr, z);
   input clk;
   input [1:0] addr;
   output logic signed [19:0] z;
   always_ff @(posedge clk) begin
      case(addr)
        0: z <= 20'd767;
        1: z <= 20'd459;
        2: z <= -20'd46;
        3: z <= -20'd608;
      endcase
   end
endmodule

