module conv_64_33_16_8(clk, reset, s_data_in_x, s_valid_x, s_ready_x, m_data_out_y, m_valid_y, m_ready_y);
    parameter                      T = 16, X_COUNT = 64, F_COUNT = 33, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT);
    input                          clk, reset, s_valid_x, m_ready_y;
    input signed [T-1:0]           s_data_in_x;
    output logic                   s_ready_x, m_valid_y;
    output logic signed [T-1:0]    m_data_out_y;
    logic [ADDR_X-1:0]             addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8;
    logic [ADDR_F-1:0]             addr_f;
    logic                          wr_en_x, clear_acc, en_acc, op_done;
    datapath d(.clk(clk), .reset(reset), .s_data_in_x(s_data_in_x), .wr_en_x(wr_en_x), .clear_acc(clear_acc), .en_acc(en_acc),
               .m_data_out_y(m_data_out_y), .m_valid_y(m_valid_y), .m_ready_y(m_ready_y), .op_done(op_done), .addr_f(addr_f),
               .addr_x1(addr_x1), .addr_x2(addr_x2), .addr_x3(addr_x3), .addr_x4(addr_x4), .addr_x5(addr_x5), .addr_x6(addr_x6), .addr_x7(addr_x7), .addr_x8(addr_x8));
    ctrlpath c(.clk(clk), .reset(reset), .s_valid_x(s_valid_x), .m_ready_y(m_ready_y), .wr_en_x(wr_en_x), .clear_acc(clear_acc),
               .en_acc(en_acc), .s_ready_x(s_ready_x), .m_valid_y(m_valid_y), .op_done(op_done), .addr_f(addr_f),
               .addr_x1(addr_x1), .addr_x2(addr_x2), .addr_x3(addr_x3), .addr_x4(addr_x4), .addr_x5(addr_x5), .addr_x6(addr_x6), .addr_x7(addr_x7), .addr_x8(addr_x8));
endmodule

module datapath (clk, reset, s_data_in_x, wr_en_x, clear_acc, en_acc, m_data_out_y, m_valid_y, m_ready_y, op_done, addr_f,
                 addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8);
    parameter                      T = 16, P = 8, X_COUNT = 64, F_COUNT = 33, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT);
    input                          clk, reset, wr_en_x, clear_acc, en_acc;
    input signed [T-1:0]           s_data_in_x;
    input [ADDR_X-1:0]             addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8;
    input [ADDR_F-1:0]             addr_f;
    logic signed [T-1:0]           m_data_out_y1, m_data_out_y2, m_data_out_y3, m_data_out_y4, m_data_out_y5, m_data_out_y6, m_data_out_y7, m_data_out_y8;
    logic signed [T-1:0]           s_data_out_f, s_data_out_x1, s_data_out_x2, s_data_out_x3, s_data_out_x4, s_data_out_x5, s_data_out_x6, s_data_out_x7, s_data_out_x8;
    output logic signed [T-1:0]    m_data_out_y;
    input logic                    m_valid_y, m_ready_y;
    logic [P:0]                    counter2;
    output logic                   op_done;
    conv_64_33_16_8_f_rom rom(.clk(clk), .addr(addr_f), .z(s_data_out_f));
    memory #(T, X_COUNT, ADDR_X) x_mem1(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x1), .addr(addr_x1), .wr_en(wr_en_x));
    memory #(T, X_COUNT, ADDR_X) x_mem2(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x2), .addr(addr_x2), .wr_en(wr_en_x));
    memory #(T, X_COUNT, ADDR_X) x_mem3(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x3), .addr(addr_x3), .wr_en(wr_en_x));
    memory #(T, X_COUNT, ADDR_X) x_mem4(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x4), .addr(addr_x4), .wr_en(wr_en_x));
    memory #(T, X_COUNT, ADDR_X) x_mem5(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x5), .addr(addr_x5), .wr_en(wr_en_x));
    memory #(T, X_COUNT, ADDR_X) x_mem6(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x6), .addr(addr_x6), .wr_en(wr_en_x));
    memory #(T, X_COUNT, ADDR_X) x_mem7(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x7), .addr(addr_x7), .wr_en(wr_en_x));
    memory #(T, X_COUNT, ADDR_X) x_mem8(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x8), .addr(addr_x8), .wr_en(wr_en_x));
    mac m1 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x1), .inf(s_data_out_f), .out(m_data_out_y1),
        	.m_valid_y(m_valid_y));
    mac m2 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x2), .inf(s_data_out_f), .out(m_data_out_y2),
        	.m_valid_y(m_valid_y));
    mac m3 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x3), .inf(s_data_out_f), .out(m_data_out_y3),
        	.m_valid_y(m_valid_y));
    mac m4 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x4), .inf(s_data_out_f), .out(m_data_out_y4),
        	.m_valid_y(m_valid_y));
    mac m5 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x5), .inf(s_data_out_f), .out(m_data_out_y5),
        	.m_valid_y(m_valid_y));
    mac m6 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x6), .inf(s_data_out_f), .out(m_data_out_y6),
        	.m_valid_y(m_valid_y));
    mac m7 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x7), .inf(s_data_out_f), .out(m_data_out_y7),
        	.m_valid_y(m_valid_y));
    mac m8 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x8), .inf(s_data_out_f), .out(m_data_out_y8),
        	.m_valid_y(m_valid_y));

    always_comb begin
        if((m_valid_y == 1) & (m_ready_y == 1)) begin
            if(counter2 == 0) begin
                m_data_out_y = m_data_out_y1;
            end
            else if(counter2 ==1) begin
                m_data_out_y = m_data_out_y2;
            end
            else if(counter2 ==2) begin
                m_data_out_y = m_data_out_y3;
            end
            else if(counter2 ==3) begin
                m_data_out_y = m_data_out_y4;
            end
            else if(counter2 ==4) begin
                m_data_out_y = m_data_out_y5;
            end
            else if(counter2 ==5) begin
                m_data_out_y = m_data_out_y6;
            end
            else if(counter2 ==6) begin
                m_data_out_y = m_data_out_y7;
            end
            else if(counter2 ==7) begin
                m_data_out_y = m_data_out_y8;
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

module ctrlpath (clk, reset, s_valid_x, m_ready_y, wr_en_x, clear_acc, en_acc, s_ready_x, m_valid_y, op_done, addr_f,
                 addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8);
    parameter                      T = 16, P = 8, X_COUNT = 64, F_COUNT = 33, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT),
	                               OP_COUNT = X_COUNT-F_COUNT+1, COUNTER_V = $clog2(OP_COUNT);
    input logic                    clk, reset, s_valid_x, m_ready_y;
    output logic                   s_ready_x, m_valid_y;
    output logic [ADDR_X-1:0]             addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8;
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
            addr_x2<= 0;
            addr_x3<= 0;
            addr_x4<= 0;
            addr_x5<= 0;
            addr_x6<= 0;
            addr_x7<= 0;
            addr_x8<= 0;
            addr_f <= 0;
            counter1 <= 0;
            en_acc <= 0;
            counter <= P;
            wr_done_x <= 0;
            m_valid_y <= 0;
        end
        if (wr_en_x == 1) begin
            addr_x1 <= addr_x1 + 1;
            addr_x2 <= addr_x2 + 1;
            addr_x3 <= addr_x3 + 1;
            addr_x4 <= addr_x4 + 1;
            addr_x5 <= addr_x5 + 1;
            addr_x6 <= addr_x6 + 1;
            addr_x7 <= addr_x7 + 1;
            addr_x8 <= addr_x8 + 1;
        end
        if (loaded_x == 1) begin
            addr_x1 <= 0;
            addr_x2 <= 1;
            addr_x3 <= 2;
            addr_x4 <= 3;
            addr_x5 <= 4;
            addr_x6 <= 5;
            addr_x7 <= 6;
            addr_x8 <= 7;
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
                    addr_x2 <= addr_x2 + 1;
                    addr_x3 <= addr_x3 + 1;
                    addr_x4 <= addr_x4 + 1;
                    addr_x5 <= addr_x5 + 1;
                    addr_x6 <= addr_x6 + 1;
                    addr_x7 <= addr_x7 + 1;
                    addr_x8 <= addr_x8 + 1;
                    addr_f <=  addr_f + 1;
                    counter1 <= counter1 + 1;
                end
                else begin
                    m_valid_y <= 1;
                    counter <= counter + P;
                    addr_x1 <= counter + 0;
                    addr_x2 <= counter + 1;
                    addr_x3 <= counter + 2;
                    addr_x4 <= counter + 3;
                    addr_x5 <= counter + 4;
                    addr_x6 <= counter + 5;
                    addr_x7 <= counter + 6;
                    addr_x8 <= counter + 7;
                    addr_f <= 0;
                    counter1 <= 0;
                end
            end
            else begin
                addr_x1<= 0;
                addr_x2<= 0;
                addr_x3<= 0;
                addr_x4<= 0;
                addr_x5<= 0;
                addr_x6<= 0;
                addr_x7<= 0;
                addr_x8<= 0;
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

module mac(clk, en_acc, reset, clear_acc, inx, inf, out, m_valid_y);
    parameter                    T = 16, MAX_VAL = ((1<<(T-1))-1), MIN_VAL = (-1*(1<<(T-1)));
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

module memory(clk, data_in, data_out, addr, wr_en);
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

module conv_64_33_16_8_f_rom(clk, addr, z);
   input clk;
   input [5:0] addr;
   output logic signed [15:0] z;
   always_ff @(posedge clk) begin
      case(addr)
        0: z <= -16'd164;
        1: z <= -16'd181;
        2: z <= -16'd31;
        3: z <= 16'd225;
        4: z <= 16'd146;
        5: z <= -16'd24;
        6: z <= 16'd44;
        7: z <= 16'd219;
        8: z <= 16'd228;
        9: z <= 16'd24;
        10: z <= 16'd29;
        11: z <= 16'd159;
        12: z <= -16'd91;
        13: z <= -16'd92;
        14: z <= -16'd159;
        15: z <= -16'd98;
        16: z <= -16'd233;
        17: z <= -16'd247;
        18: z <= 16'd83;
        19: z <= 16'd209;
        20: z <= 16'd182;
        21: z <= -16'd118;
        22: z <= -16'd95;
        23: z <= 16'd10;
        24: z <= 16'd12;
        25: z <= -16'd104;
        26: z <= -16'd134;
        27: z <= -16'd90;
        28: z <= 16'd143;
        29: z <= -16'd35;
        30: z <= -16'd173;
        31: z <= 16'd235;
        32: z <= 16'd40;
      endcase
   end
endmodule

