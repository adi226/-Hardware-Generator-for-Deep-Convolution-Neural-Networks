module multi_64_33_9_10_16_50(clk, reset, s_data_in_x, s_valid_x, s_ready_x, m_data_out_y, m_valid_y, m_ready_y);
    parameter                      T = 16;
    input                          clk, reset, s_valid_x, m_ready_y;
    input signed [T-1:0]           s_data_in_x;
    output logic                   s_ready_x, m_valid_y;
    output logic signed [T-1:0]    m_data_out_y;
    logic                          m_ready_y1, m_ready_y2;
    logic                          m_valid_y1, m_valid_y2;
    logic signed [T-1:0]           m_data_out_y1, m_data_out_y2;
    layer1_64_33_16_32 l1(.clk(clk), .reset(reset), .s_data_in_x(s_data_in_x), .s_valid_x(s_valid_x), .s_ready_x(s_ready_x),
                       .m_data_out_y(m_data_out_y1), .m_valid_y(m_valid_y1), .m_ready_y(m_ready_y1));
    layer2_32_9_16_12 l2(.clk(clk), .reset(reset), .s_data_in_x(m_data_out_y1), .s_valid_x(m_valid_y1), .s_ready_x(m_ready_y1),
                       .m_data_out_y(m_data_out_y2), .m_valid_y(m_valid_y2), .m_ready_y(m_ready_y2));
    layer3_24_10_16_5 l3(.clk(clk), .reset(reset), .s_data_in_x(m_data_out_y2), .s_valid_x(m_valid_y2), .s_ready_x(m_ready_y2),
                      .m_data_out_y(m_data_out_y), .m_valid_y(m_valid_y), .m_ready_y(m_ready_y));
endmodule
module layer1_64_33_16_32(clk, reset, s_data_in_x, s_valid_x, s_ready_x, m_data_out_y, m_valid_y, m_ready_y);
    parameter                      T = 16, X_COUNT = 64, F_COUNT = 33, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT);
    input                          clk, reset, s_valid_x, m_ready_y;
    input signed [T-1:0]           s_data_in_x;
    output logic                   s_ready_x, m_valid_y;
    output logic signed [T-1:0]    m_data_out_y;
    logic [ADDR_X-1:0]             addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12, addr_x13, addr_x14, addr_x15, addr_x16, addr_x17, addr_x18, addr_x19, addr_x20, addr_x21, addr_x22, addr_x23, addr_x24, addr_x25, addr_x26, addr_x27, addr_x28, addr_x29, addr_x30, addr_x31, addr_x32;
    logic [ADDR_F-1:0]             addr_f;
    logic                          wr_en_x, clear_acc, en_acc, op_done;
    datapath1 d(.clk(clk), .reset(reset), .s_data_in_x(s_data_in_x), .wr_en_x(wr_en_x), .clear_acc(clear_acc), .en_acc(en_acc),
               .m_data_out_y(m_data_out_y), .m_valid_y(m_valid_y), .m_ready_y(m_ready_y), .op_done(op_done), .addr_f(addr_f),
               .addr_x1(addr_x1), .addr_x2(addr_x2), .addr_x3(addr_x3), .addr_x4(addr_x4), .addr_x5(addr_x5), .addr_x6(addr_x6), .addr_x7(addr_x7), .addr_x8(addr_x8), .addr_x9(addr_x9), .addr_x10(addr_x10), .addr_x11(addr_x11), .addr_x12(addr_x12), .addr_x13(addr_x13), .addr_x14(addr_x14), .addr_x15(addr_x15), .addr_x16(addr_x16), .addr_x17(addr_x17), .addr_x18(addr_x18), .addr_x19(addr_x19), .addr_x20(addr_x20), .addr_x21(addr_x21), .addr_x22(addr_x22), .addr_x23(addr_x23), .addr_x24(addr_x24), .addr_x25(addr_x25), .addr_x26(addr_x26), .addr_x27(addr_x27), .addr_x28(addr_x28), .addr_x29(addr_x29), .addr_x30(addr_x30), .addr_x31(addr_x31), .addr_x32(addr_x32));
    ctrlpath1 c(.clk(clk), .reset(reset), .s_valid_x(s_valid_x), .m_ready_y(m_ready_y), .wr_en_x(wr_en_x), .clear_acc(clear_acc),
               .en_acc(en_acc), .s_ready_x(s_ready_x), .m_valid_y(m_valid_y), .op_done(op_done), .addr_f(addr_f),
               .addr_x1(addr_x1), .addr_x2(addr_x2), .addr_x3(addr_x3), .addr_x4(addr_x4), .addr_x5(addr_x5), .addr_x6(addr_x6), .addr_x7(addr_x7), .addr_x8(addr_x8), .addr_x9(addr_x9), .addr_x10(addr_x10), .addr_x11(addr_x11), .addr_x12(addr_x12), .addr_x13(addr_x13), .addr_x14(addr_x14), .addr_x15(addr_x15), .addr_x16(addr_x16), .addr_x17(addr_x17), .addr_x18(addr_x18), .addr_x19(addr_x19), .addr_x20(addr_x20), .addr_x21(addr_x21), .addr_x22(addr_x22), .addr_x23(addr_x23), .addr_x24(addr_x24), .addr_x25(addr_x25), .addr_x26(addr_x26), .addr_x27(addr_x27), .addr_x28(addr_x28), .addr_x29(addr_x29), .addr_x30(addr_x30), .addr_x31(addr_x31), .addr_x32(addr_x32));
endmodule

module datapath1 (clk, reset, s_data_in_x, wr_en_x, clear_acc, en_acc, m_data_out_y, m_valid_y, m_ready_y, op_done, addr_f,
                 addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12, addr_x13, addr_x14, addr_x15, addr_x16, addr_x17, addr_x18, addr_x19, addr_x20, addr_x21, addr_x22, addr_x23, addr_x24, addr_x25, addr_x26, addr_x27, addr_x28, addr_x29, addr_x30, addr_x31, addr_x32);
    parameter                      T = 16, P = 32, X_COUNT = 64, F_COUNT = 33, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT);
    input                          clk, reset, wr_en_x, clear_acc, en_acc;
    input signed [T-1:0]           s_data_in_x;
    input [ADDR_X-1:0]             addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12, addr_x13, addr_x14, addr_x15, addr_x16, addr_x17, addr_x18, addr_x19, addr_x20, addr_x21, addr_x22, addr_x23, addr_x24, addr_x25, addr_x26, addr_x27, addr_x28, addr_x29, addr_x30, addr_x31, addr_x32;
    input [ADDR_F-1:0]             addr_f;
    logic signed [T-1:0]           m_data_out_y1, m_data_out_y2, m_data_out_y3, m_data_out_y4, m_data_out_y5, m_data_out_y6, m_data_out_y7, m_data_out_y8, m_data_out_y9, m_data_out_y10, m_data_out_y11, m_data_out_y12, m_data_out_y13, m_data_out_y14, m_data_out_y15, m_data_out_y16, m_data_out_y17, m_data_out_y18, m_data_out_y19, m_data_out_y20, m_data_out_y21, m_data_out_y22, m_data_out_y23, m_data_out_y24, m_data_out_y25, m_data_out_y26, m_data_out_y27, m_data_out_y28, m_data_out_y29, m_data_out_y30, m_data_out_y31, m_data_out_y32;
    logic signed [T-1:0]           s_data_out_f, s_data_out_x1, s_data_out_x2, s_data_out_x3, s_data_out_x4, s_data_out_x5, s_data_out_x6, s_data_out_x7, s_data_out_x8, s_data_out_x9, s_data_out_x10, s_data_out_x11, s_data_out_x12, s_data_out_x13, s_data_out_x14, s_data_out_x15, s_data_out_x16, s_data_out_x17, s_data_out_x18, s_data_out_x19, s_data_out_x20, s_data_out_x21, s_data_out_x22, s_data_out_x23, s_data_out_x24, s_data_out_x25, s_data_out_x26, s_data_out_x27, s_data_out_x28, s_data_out_x29, s_data_out_x30, s_data_out_x31, s_data_out_x32;
    output logic signed [T-1:0]    m_data_out_y;
    input logic                    m_valid_y, m_ready_y;
    logic [P:0]                    counter2;
    output logic                   op_done;
    layer1_64_33_16_32_f_rom rom(.clk(clk), .addr(addr_f), .z(s_data_out_f));
    memory1 #(T, X_COUNT, ADDR_X) x_mem1(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x1), .addr(addr_x1), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem2(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x2), .addr(addr_x2), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem3(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x3), .addr(addr_x3), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem4(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x4), .addr(addr_x4), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem5(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x5), .addr(addr_x5), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem6(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x6), .addr(addr_x6), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem7(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x7), .addr(addr_x7), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem8(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x8), .addr(addr_x8), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem9(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x9), .addr(addr_x9), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem10(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x10), .addr(addr_x10), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem11(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x11), .addr(addr_x11), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem12(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x12), .addr(addr_x12), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem13(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x13), .addr(addr_x13), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem14(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x14), .addr(addr_x14), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem15(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x15), .addr(addr_x15), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem16(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x16), .addr(addr_x16), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem17(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x17), .addr(addr_x17), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem18(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x18), .addr(addr_x18), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem19(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x19), .addr(addr_x19), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem20(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x20), .addr(addr_x20), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem21(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x21), .addr(addr_x21), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem22(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x22), .addr(addr_x22), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem23(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x23), .addr(addr_x23), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem24(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x24), .addr(addr_x24), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem25(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x25), .addr(addr_x25), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem26(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x26), .addr(addr_x26), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem27(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x27), .addr(addr_x27), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem28(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x28), .addr(addr_x28), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem29(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x29), .addr(addr_x29), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem30(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x30), .addr(addr_x30), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem31(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x31), .addr(addr_x31), .wr_en(wr_en_x));
    memory1 #(T, X_COUNT, ADDR_X) x_mem32(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x32), .addr(addr_x32), .wr_en(wr_en_x));
    mac1 m1 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x1), .inf(s_data_out_f), .out(m_data_out_y1),
        	.m_valid_y(m_valid_y));
    mac1 m2 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x2), .inf(s_data_out_f), .out(m_data_out_y2),
        	.m_valid_y(m_valid_y));
    mac1 m3 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x3), .inf(s_data_out_f), .out(m_data_out_y3),
        	.m_valid_y(m_valid_y));
    mac1 m4 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x4), .inf(s_data_out_f), .out(m_data_out_y4),
        	.m_valid_y(m_valid_y));
    mac1 m5 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x5), .inf(s_data_out_f), .out(m_data_out_y5),
        	.m_valid_y(m_valid_y));
    mac1 m6 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x6), .inf(s_data_out_f), .out(m_data_out_y6),
        	.m_valid_y(m_valid_y));
    mac1 m7 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x7), .inf(s_data_out_f), .out(m_data_out_y7),
        	.m_valid_y(m_valid_y));
    mac1 m8 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x8), .inf(s_data_out_f), .out(m_data_out_y8),
        	.m_valid_y(m_valid_y));
    mac1 m9 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x9), .inf(s_data_out_f), .out(m_data_out_y9),
        	.m_valid_y(m_valid_y));
    mac1 m10 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x10), .inf(s_data_out_f), .out(m_data_out_y10),
        	.m_valid_y(m_valid_y));
    mac1 m11 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x11), .inf(s_data_out_f), .out(m_data_out_y11),
        	.m_valid_y(m_valid_y));
    mac1 m12 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x12), .inf(s_data_out_f), .out(m_data_out_y12),
        	.m_valid_y(m_valid_y));
    mac1 m13 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x13), .inf(s_data_out_f), .out(m_data_out_y13),
        	.m_valid_y(m_valid_y));
    mac1 m14 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x14), .inf(s_data_out_f), .out(m_data_out_y14),
        	.m_valid_y(m_valid_y));
    mac1 m15 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x15), .inf(s_data_out_f), .out(m_data_out_y15),
        	.m_valid_y(m_valid_y));
    mac1 m16 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x16), .inf(s_data_out_f), .out(m_data_out_y16),
        	.m_valid_y(m_valid_y));
    mac1 m17 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x17), .inf(s_data_out_f), .out(m_data_out_y17),
        	.m_valid_y(m_valid_y));
    mac1 m18 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x18), .inf(s_data_out_f), .out(m_data_out_y18),
        	.m_valid_y(m_valid_y));
    mac1 m19 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x19), .inf(s_data_out_f), .out(m_data_out_y19),
        	.m_valid_y(m_valid_y));
    mac1 m20 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x20), .inf(s_data_out_f), .out(m_data_out_y20),
        	.m_valid_y(m_valid_y));
    mac1 m21 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x21), .inf(s_data_out_f), .out(m_data_out_y21),
        	.m_valid_y(m_valid_y));
    mac1 m22 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x22), .inf(s_data_out_f), .out(m_data_out_y22),
        	.m_valid_y(m_valid_y));
    mac1 m23 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x23), .inf(s_data_out_f), .out(m_data_out_y23),
        	.m_valid_y(m_valid_y));
    mac1 m24 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x24), .inf(s_data_out_f), .out(m_data_out_y24),
        	.m_valid_y(m_valid_y));
    mac1 m25 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x25), .inf(s_data_out_f), .out(m_data_out_y25),
        	.m_valid_y(m_valid_y));
    mac1 m26 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x26), .inf(s_data_out_f), .out(m_data_out_y26),
        	.m_valid_y(m_valid_y));
    mac1 m27 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x27), .inf(s_data_out_f), .out(m_data_out_y27),
        	.m_valid_y(m_valid_y));
    mac1 m28 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x28), .inf(s_data_out_f), .out(m_data_out_y28),
        	.m_valid_y(m_valid_y));
    mac1 m29 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x29), .inf(s_data_out_f), .out(m_data_out_y29),
        	.m_valid_y(m_valid_y));
    mac1 m30 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x30), .inf(s_data_out_f), .out(m_data_out_y30),
        	.m_valid_y(m_valid_y));
    mac1 m31 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x31), .inf(s_data_out_f), .out(m_data_out_y31),
        	.m_valid_y(m_valid_y));
    mac1 m32 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x32), .inf(s_data_out_f), .out(m_data_out_y32),
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
            else if(counter2 ==8) begin
                m_data_out_y = m_data_out_y9;
            end
            else if(counter2 ==9) begin
                m_data_out_y = m_data_out_y10;
            end
            else if(counter2 ==10) begin
                m_data_out_y = m_data_out_y11;
            end
            else if(counter2 ==11) begin
                m_data_out_y = m_data_out_y12;
            end
            else if(counter2 ==12) begin
                m_data_out_y = m_data_out_y13;
            end
            else if(counter2 ==13) begin
                m_data_out_y = m_data_out_y14;
            end
            else if(counter2 ==14) begin
                m_data_out_y = m_data_out_y15;
            end
            else if(counter2 ==15) begin
                m_data_out_y = m_data_out_y16;
            end
            else if(counter2 ==16) begin
                m_data_out_y = m_data_out_y17;
            end
            else if(counter2 ==17) begin
                m_data_out_y = m_data_out_y18;
            end
            else if(counter2 ==18) begin
                m_data_out_y = m_data_out_y19;
            end
            else if(counter2 ==19) begin
                m_data_out_y = m_data_out_y20;
            end
            else if(counter2 ==20) begin
                m_data_out_y = m_data_out_y21;
            end
            else if(counter2 ==21) begin
                m_data_out_y = m_data_out_y22;
            end
            else if(counter2 ==22) begin
                m_data_out_y = m_data_out_y23;
            end
            else if(counter2 ==23) begin
                m_data_out_y = m_data_out_y24;
            end
            else if(counter2 ==24) begin
                m_data_out_y = m_data_out_y25;
            end
            else if(counter2 ==25) begin
                m_data_out_y = m_data_out_y26;
            end
            else if(counter2 ==26) begin
                m_data_out_y = m_data_out_y27;
            end
            else if(counter2 ==27) begin
                m_data_out_y = m_data_out_y28;
            end
            else if(counter2 ==28) begin
                m_data_out_y = m_data_out_y29;
            end
            else if(counter2 ==29) begin
                m_data_out_y = m_data_out_y30;
            end
            else if(counter2 ==30) begin
                m_data_out_y = m_data_out_y31;
            end
            else if(counter2 ==31) begin
                m_data_out_y = m_data_out_y32;
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
                 addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12, addr_x13, addr_x14, addr_x15, addr_x16, addr_x17, addr_x18, addr_x19, addr_x20, addr_x21, addr_x22, addr_x23, addr_x24, addr_x25, addr_x26, addr_x27, addr_x28, addr_x29, addr_x30, addr_x31, addr_x32);
    parameter                      T = 16, P = 32, X_COUNT = 64, F_COUNT = 33, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT),
	                               OP_COUNT = X_COUNT-F_COUNT+1, COUNTER_V = $clog2(OP_COUNT);
    input logic                    clk, reset, s_valid_x, m_ready_y;
    output logic                   s_ready_x, m_valid_y;
    output logic [ADDR_X-1:0]             addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12, addr_x13, addr_x14, addr_x15, addr_x16, addr_x17, addr_x18, addr_x19, addr_x20, addr_x21, addr_x22, addr_x23, addr_x24, addr_x25, addr_x26, addr_x27, addr_x28, addr_x29, addr_x30, addr_x31, addr_x32;
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
            addr_x9<= 0;
            addr_x10<= 0;
            addr_x11<= 0;
            addr_x12<= 0;
            addr_x13<= 0;
            addr_x14<= 0;
            addr_x15<= 0;
            addr_x16<= 0;
            addr_x17<= 0;
            addr_x18<= 0;
            addr_x19<= 0;
            addr_x20<= 0;
            addr_x21<= 0;
            addr_x22<= 0;
            addr_x23<= 0;
            addr_x24<= 0;
            addr_x25<= 0;
            addr_x26<= 0;
            addr_x27<= 0;
            addr_x28<= 0;
            addr_x29<= 0;
            addr_x30<= 0;
            addr_x31<= 0;
            addr_x32<= 0;
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
            addr_x9 <= addr_x9 + 1;
            addr_x10 <= addr_x10 + 1;
            addr_x11 <= addr_x11 + 1;
            addr_x12 <= addr_x12 + 1;
            addr_x13 <= addr_x13 + 1;
            addr_x14 <= addr_x14 + 1;
            addr_x15 <= addr_x15 + 1;
            addr_x16 <= addr_x16 + 1;
            addr_x17 <= addr_x17 + 1;
            addr_x18 <= addr_x18 + 1;
            addr_x19 <= addr_x19 + 1;
            addr_x20 <= addr_x20 + 1;
            addr_x21 <= addr_x21 + 1;
            addr_x22 <= addr_x22 + 1;
            addr_x23 <= addr_x23 + 1;
            addr_x24 <= addr_x24 + 1;
            addr_x25 <= addr_x25 + 1;
            addr_x26 <= addr_x26 + 1;
            addr_x27 <= addr_x27 + 1;
            addr_x28 <= addr_x28 + 1;
            addr_x29 <= addr_x29 + 1;
            addr_x30 <= addr_x30 + 1;
            addr_x31 <= addr_x31 + 1;
            addr_x32 <= addr_x32 + 1;
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
            addr_x9 <= 8;
            addr_x10 <= 9;
            addr_x11 <= 10;
            addr_x12 <= 11;
            addr_x13 <= 12;
            addr_x14 <= 13;
            addr_x15 <= 14;
            addr_x16 <= 15;
            addr_x17 <= 16;
            addr_x18 <= 17;
            addr_x19 <= 18;
            addr_x20 <= 19;
            addr_x21 <= 20;
            addr_x22 <= 21;
            addr_x23 <= 22;
            addr_x24 <= 23;
            addr_x25 <= 24;
            addr_x26 <= 25;
            addr_x27 <= 26;
            addr_x28 <= 27;
            addr_x29 <= 28;
            addr_x30 <= 29;
            addr_x31 <= 30;
            addr_x32 <= 31;
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
                    addr_x9 <= addr_x9 + 1;
                    addr_x10 <= addr_x10 + 1;
                    addr_x11 <= addr_x11 + 1;
                    addr_x12 <= addr_x12 + 1;
                    addr_x13 <= addr_x13 + 1;
                    addr_x14 <= addr_x14 + 1;
                    addr_x15 <= addr_x15 + 1;
                    addr_x16 <= addr_x16 + 1;
                    addr_x17 <= addr_x17 + 1;
                    addr_x18 <= addr_x18 + 1;
                    addr_x19 <= addr_x19 + 1;
                    addr_x20 <= addr_x20 + 1;
                    addr_x21 <= addr_x21 + 1;
                    addr_x22 <= addr_x22 + 1;
                    addr_x23 <= addr_x23 + 1;
                    addr_x24 <= addr_x24 + 1;
                    addr_x25 <= addr_x25 + 1;
                    addr_x26 <= addr_x26 + 1;
                    addr_x27 <= addr_x27 + 1;
                    addr_x28 <= addr_x28 + 1;
                    addr_x29 <= addr_x29 + 1;
                    addr_x30 <= addr_x30 + 1;
                    addr_x31 <= addr_x31 + 1;
                    addr_x32 <= addr_x32 + 1;
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
                    addr_x9 <= counter + 8;
                    addr_x10 <= counter + 9;
                    addr_x11 <= counter + 10;
                    addr_x12 <= counter + 11;
                    addr_x13 <= counter + 12;
                    addr_x14 <= counter + 13;
                    addr_x15 <= counter + 14;
                    addr_x16 <= counter + 15;
                    addr_x17 <= counter + 16;
                    addr_x18 <= counter + 17;
                    addr_x19 <= counter + 18;
                    addr_x20 <= counter + 19;
                    addr_x21 <= counter + 20;
                    addr_x22 <= counter + 21;
                    addr_x23 <= counter + 22;
                    addr_x24 <= counter + 23;
                    addr_x25 <= counter + 24;
                    addr_x26 <= counter + 25;
                    addr_x27 <= counter + 26;
                    addr_x28 <= counter + 27;
                    addr_x29 <= counter + 28;
                    addr_x30 <= counter + 29;
                    addr_x31 <= counter + 30;
                    addr_x32 <= counter + 31;
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
                addr_x9<= 0;
                addr_x10<= 0;
                addr_x11<= 0;
                addr_x12<= 0;
                addr_x13<= 0;
                addr_x14<= 0;
                addr_x15<= 0;
                addr_x16<= 0;
                addr_x17<= 0;
                addr_x18<= 0;
                addr_x19<= 0;
                addr_x20<= 0;
                addr_x21<= 0;
                addr_x22<= 0;
                addr_x23<= 0;
                addr_x24<= 0;
                addr_x25<= 0;
                addr_x26<= 0;
                addr_x27<= 0;
                addr_x28<= 0;
                addr_x29<= 0;
                addr_x30<= 0;
                addr_x31<= 0;
                addr_x32<= 0;
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

module layer1_64_33_16_32_f_rom(clk, addr, z);
   input clk;
   input [5:0] addr;
   output logic signed [15:0] z;
   always_ff @(posedge clk) begin
      case(addr)
        0: z <= -16'd68;
        1: z <= -16'd189;
        2: z <= 16'd166;
        3: z <= 16'd192;
        4: z <= 16'd32;
        5: z <= -16'd37;
        6: z <= 16'd181;
        7: z <= -16'd191;
        8: z <= -16'd79;
        9: z <= -16'd87;
        10: z <= 16'd57;
        11: z <= 16'd64;
        12: z <= -16'd54;
        13: z <= -16'd194;
        14: z <= -16'd2;
        15: z <= 16'd197;
        16: z <= 16'd144;
        17: z <= 16'd188;
        18: z <= -16'd153;
        19: z <= 16'd46;
        20: z <= 16'd124;
        21: z <= 16'd40;
        22: z <= 16'd237;
        23: z <= -16'd165;
        24: z <= 16'd224;
        25: z <= -16'd134;
        26: z <= 16'd20;
        27: z <= 16'd217;
        28: z <= -16'd79;
        29: z <= -16'd153;
        30: z <= -16'd249;
        31: z <= 16'd109;
        32: z <= -16'd86;
      endcase
   end
endmodule

module layer2_32_9_16_12(clk, reset, s_data_in_x, s_valid_x, s_ready_x, m_data_out_y, m_valid_y, m_ready_y);
    parameter                      T = 16, X_COUNT = 32, F_COUNT = 9, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT);
    input                          clk, reset, s_valid_x, m_ready_y;
    input signed [T-1:0]           s_data_in_x;
    output logic                   s_ready_x, m_valid_y;
    output logic signed [T-1:0]    m_data_out_y;
    logic [ADDR_X-1:0]             addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12;
    logic [ADDR_F-1:0]             addr_f;
    logic                          wr_en_x, clear_acc, en_acc, op_done;
    datapath2 d(.clk(clk), .reset(reset), .s_data_in_x(s_data_in_x), .wr_en_x(wr_en_x), .clear_acc(clear_acc), .en_acc(en_acc),
               .m_data_out_y(m_data_out_y), .m_valid_y(m_valid_y), .m_ready_y(m_ready_y), .op_done(op_done), .addr_f(addr_f),
               .addr_x1(addr_x1), .addr_x2(addr_x2), .addr_x3(addr_x3), .addr_x4(addr_x4), .addr_x5(addr_x5), .addr_x6(addr_x6), .addr_x7(addr_x7), .addr_x8(addr_x8), .addr_x9(addr_x9), .addr_x10(addr_x10), .addr_x11(addr_x11), .addr_x12(addr_x12));
    ctrlpath2 c(.clk(clk), .reset(reset), .s_valid_x(s_valid_x), .m_ready_y(m_ready_y), .wr_en_x(wr_en_x), .clear_acc(clear_acc),
               .en_acc(en_acc), .s_ready_x(s_ready_x), .m_valid_y(m_valid_y), .op_done(op_done), .addr_f(addr_f),
               .addr_x1(addr_x1), .addr_x2(addr_x2), .addr_x3(addr_x3), .addr_x4(addr_x4), .addr_x5(addr_x5), .addr_x6(addr_x6), .addr_x7(addr_x7), .addr_x8(addr_x8), .addr_x9(addr_x9), .addr_x10(addr_x10), .addr_x11(addr_x11), .addr_x12(addr_x12));
endmodule

module datapath2 (clk, reset, s_data_in_x, wr_en_x, clear_acc, en_acc, m_data_out_y, m_valid_y, m_ready_y, op_done, addr_f,
                 addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12);
    parameter                      T = 16, P = 12, X_COUNT = 32, F_COUNT = 9, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT);
    input                          clk, reset, wr_en_x, clear_acc, en_acc;
    input signed [T-1:0]           s_data_in_x;
    input [ADDR_X-1:0]             addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12;
    input [ADDR_F-1:0]             addr_f;
    logic signed [T-1:0]           m_data_out_y1, m_data_out_y2, m_data_out_y3, m_data_out_y4, m_data_out_y5, m_data_out_y6, m_data_out_y7, m_data_out_y8, m_data_out_y9, m_data_out_y10, m_data_out_y11, m_data_out_y12;
    logic signed [T-1:0]           s_data_out_f, s_data_out_x1, s_data_out_x2, s_data_out_x3, s_data_out_x4, s_data_out_x5, s_data_out_x6, s_data_out_x7, s_data_out_x8, s_data_out_x9, s_data_out_x10, s_data_out_x11, s_data_out_x12;
    output logic signed [T-1:0]    m_data_out_y;
    input logic                    m_valid_y, m_ready_y;
    logic [P:0]                    counter2;
    output logic                   op_done;
    layer2_32_9_16_12_f_rom rom(.clk(clk), .addr(addr_f), .z(s_data_out_f));
    memory2 #(T, X_COUNT, ADDR_X) x_mem1(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x1), .addr(addr_x1), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem2(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x2), .addr(addr_x2), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem3(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x3), .addr(addr_x3), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem4(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x4), .addr(addr_x4), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem5(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x5), .addr(addr_x5), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem6(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x6), .addr(addr_x6), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem7(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x7), .addr(addr_x7), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem8(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x8), .addr(addr_x8), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem9(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x9), .addr(addr_x9), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem10(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x10), .addr(addr_x10), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem11(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x11), .addr(addr_x11), .wr_en(wr_en_x));
    memory2 #(T, X_COUNT, ADDR_X) x_mem12(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x12), .addr(addr_x12), .wr_en(wr_en_x));
    mac2 m1 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x1), .inf(s_data_out_f), .out(m_data_out_y1),
        	.m_valid_y(m_valid_y));
    mac2 m2 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x2), .inf(s_data_out_f), .out(m_data_out_y2),
        	.m_valid_y(m_valid_y));
    mac2 m3 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x3), .inf(s_data_out_f), .out(m_data_out_y3),
        	.m_valid_y(m_valid_y));
    mac2 m4 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x4), .inf(s_data_out_f), .out(m_data_out_y4),
        	.m_valid_y(m_valid_y));
    mac2 m5 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x5), .inf(s_data_out_f), .out(m_data_out_y5),
        	.m_valid_y(m_valid_y));
    mac2 m6 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x6), .inf(s_data_out_f), .out(m_data_out_y6),
        	.m_valid_y(m_valid_y));
    mac2 m7 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x7), .inf(s_data_out_f), .out(m_data_out_y7),
        	.m_valid_y(m_valid_y));
    mac2 m8 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x8), .inf(s_data_out_f), .out(m_data_out_y8),
        	.m_valid_y(m_valid_y));
    mac2 m9 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x9), .inf(s_data_out_f), .out(m_data_out_y9),
        	.m_valid_y(m_valid_y));
    mac2 m10 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x10), .inf(s_data_out_f), .out(m_data_out_y10),
        	.m_valid_y(m_valid_y));
    mac2 m11 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x11), .inf(s_data_out_f), .out(m_data_out_y11),
        	.m_valid_y(m_valid_y));
    mac2 m12 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x12), .inf(s_data_out_f), .out(m_data_out_y12),
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
            else if(counter2 ==8) begin
                m_data_out_y = m_data_out_y9;
            end
            else if(counter2 ==9) begin
                m_data_out_y = m_data_out_y10;
            end
            else if(counter2 ==10) begin
                m_data_out_y = m_data_out_y11;
            end
            else if(counter2 ==11) begin
                m_data_out_y = m_data_out_y12;
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

module ctrlpath2 (clk, reset, s_valid_x, m_ready_y, wr_en_x, clear_acc, en_acc, s_ready_x, m_valid_y, op_done, addr_f,
                 addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12);
    parameter                      T = 16, P = 12, X_COUNT = 32, F_COUNT = 9, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT),
	                               OP_COUNT = X_COUNT-F_COUNT+1, COUNTER_V = $clog2(OP_COUNT);
    input logic                    clk, reset, s_valid_x, m_ready_y;
    output logic                   s_ready_x, m_valid_y;
    output logic [ADDR_X-1:0]             addr_x1, addr_x2, addr_x3, addr_x4, addr_x5, addr_x6, addr_x7, addr_x8, addr_x9, addr_x10, addr_x11, addr_x12;
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
            addr_x9<= 0;
            addr_x10<= 0;
            addr_x11<= 0;
            addr_x12<= 0;
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
            addr_x9 <= addr_x9 + 1;
            addr_x10 <= addr_x10 + 1;
            addr_x11 <= addr_x11 + 1;
            addr_x12 <= addr_x12 + 1;
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
            addr_x9 <= 8;
            addr_x10 <= 9;
            addr_x11 <= 10;
            addr_x12 <= 11;
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
                    addr_x9 <= addr_x9 + 1;
                    addr_x10 <= addr_x10 + 1;
                    addr_x11 <= addr_x11 + 1;
                    addr_x12 <= addr_x12 + 1;
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
                    addr_x9 <= counter + 8;
                    addr_x10 <= counter + 9;
                    addr_x11 <= counter + 10;
                    addr_x12 <= counter + 11;
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
                addr_x9<= 0;
                addr_x10<= 0;
                addr_x11<= 0;
                addr_x12<= 0;
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

module mac2(clk, en_acc, reset, clear_acc, inx, inf, out, m_valid_y);
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

module memory2(clk, data_in, data_out, addr, wr_en);
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

module layer2_32_9_16_12_f_rom(clk, addr, z);
   input clk;
   input [3:0] addr;
   output logic signed [15:0] z;
   always_ff @(posedge clk) begin
      case(addr)
        0: z <= 16'd173;
        1: z <= 16'd45;
        2: z <= 16'd203;
        3: z <= -16'd120;
        4: z <= -16'd30;
        5: z <= -16'd244;
        6: z <= 16'd57;
        7: z <= 16'd139;
        8: z <= 16'd69;
      endcase
   end
endmodule

module layer3_24_10_16_5(clk, reset, s_data_in_x, s_valid_x, s_ready_x, m_data_out_y, m_valid_y, m_ready_y);
    parameter                      T = 16, X_COUNT = 24, F_COUNT = 10, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT);
    input                          clk, reset, s_valid_x, m_ready_y;
    input signed [T-1:0]           s_data_in_x;
    output logic                   s_ready_x, m_valid_y;
    output logic signed [T-1:0]    m_data_out_y;
    logic [ADDR_X-1:0]             addr_x1, addr_x2, addr_x3, addr_x4, addr_x5;
    logic [ADDR_F-1:0]             addr_f;
    logic                          wr_en_x, clear_acc, en_acc, op_done;
    datapath3 d(.clk(clk), .reset(reset), .s_data_in_x(s_data_in_x), .wr_en_x(wr_en_x), .clear_acc(clear_acc), .en_acc(en_acc),
               .m_data_out_y(m_data_out_y), .m_valid_y(m_valid_y), .m_ready_y(m_ready_y), .op_done(op_done), .addr_f(addr_f),
               .addr_x1(addr_x1), .addr_x2(addr_x2), .addr_x3(addr_x3), .addr_x4(addr_x4), .addr_x5(addr_x5));
    ctrlpath3 c(.clk(clk), .reset(reset), .s_valid_x(s_valid_x), .m_ready_y(m_ready_y), .wr_en_x(wr_en_x), .clear_acc(clear_acc),
               .en_acc(en_acc), .s_ready_x(s_ready_x), .m_valid_y(m_valid_y), .op_done(op_done), .addr_f(addr_f),
               .addr_x1(addr_x1), .addr_x2(addr_x2), .addr_x3(addr_x3), .addr_x4(addr_x4), .addr_x5(addr_x5));
endmodule

module datapath3 (clk, reset, s_data_in_x, wr_en_x, clear_acc, en_acc, m_data_out_y, m_valid_y, m_ready_y, op_done, addr_f,
                 addr_x1, addr_x2, addr_x3, addr_x4, addr_x5);
    parameter                      T = 16, P = 5, X_COUNT = 24, F_COUNT = 10, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT);
    input                          clk, reset, wr_en_x, clear_acc, en_acc;
    input signed [T-1:0]           s_data_in_x;
    input [ADDR_X-1:0]             addr_x1, addr_x2, addr_x3, addr_x4, addr_x5;
    input [ADDR_F-1:0]             addr_f;
    logic signed [T-1:0]           m_data_out_y1, m_data_out_y2, m_data_out_y3, m_data_out_y4, m_data_out_y5;
    logic signed [T-1:0]           s_data_out_f, s_data_out_x1, s_data_out_x2, s_data_out_x3, s_data_out_x4, s_data_out_x5;
    output logic signed [T-1:0]    m_data_out_y;
    input logic                    m_valid_y, m_ready_y;
    logic [P:0]                    counter2;
    output logic                   op_done;
    layer3_24_10_16_5_f_rom rom(.clk(clk), .addr(addr_f), .z(s_data_out_f));
    memory3 #(T, X_COUNT, ADDR_X) x_mem1(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x1), .addr(addr_x1), .wr_en(wr_en_x));
    memory3 #(T, X_COUNT, ADDR_X) x_mem2(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x2), .addr(addr_x2), .wr_en(wr_en_x));
    memory3 #(T, X_COUNT, ADDR_X) x_mem3(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x3), .addr(addr_x3), .wr_en(wr_en_x));
    memory3 #(T, X_COUNT, ADDR_X) x_mem4(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x4), .addr(addr_x4), .wr_en(wr_en_x));
    memory3 #(T, X_COUNT, ADDR_X) x_mem5(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x5), .addr(addr_x5), .wr_en(wr_en_x));
    mac3 m1 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x1), .inf(s_data_out_f), .out(m_data_out_y1),
        	.m_valid_y(m_valid_y));
    mac3 m2 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x2), .inf(s_data_out_f), .out(m_data_out_y2),
        	.m_valid_y(m_valid_y));
    mac3 m3 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x3), .inf(s_data_out_f), .out(m_data_out_y3),
        	.m_valid_y(m_valid_y));
    mac3 m4 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x4), .inf(s_data_out_f), .out(m_data_out_y4),
        	.m_valid_y(m_valid_y));
    mac3 m5 (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x5), .inf(s_data_out_f), .out(m_data_out_y5),
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

module ctrlpath3 (clk, reset, s_valid_x, m_ready_y, wr_en_x, clear_acc, en_acc, s_ready_x, m_valid_y, op_done, addr_f,
                 addr_x1, addr_x2, addr_x3, addr_x4, addr_x5);
    parameter                      T = 16, P = 5, X_COUNT = 24, F_COUNT = 10, ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT),
	                               OP_COUNT = X_COUNT-F_COUNT+1, COUNTER_V = $clog2(OP_COUNT);
    input logic                    clk, reset, s_valid_x, m_ready_y;
    output logic                   s_ready_x, m_valid_y;
    output logic [ADDR_X-1:0]             addr_x1, addr_x2, addr_x3, addr_x4, addr_x5;
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
        end
        if (loaded_x == 1) begin
            addr_x1 <= 0;
            addr_x2 <= 1;
            addr_x3 <= 2;
            addr_x4 <= 3;
            addr_x5 <= 4;
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

module mac3(clk, en_acc, reset, clear_acc, inx, inf, out, m_valid_y);
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

module memory3(clk, data_in, data_out, addr, wr_en);
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

module layer3_24_10_16_5_f_rom(clk, addr, z);
   input clk;
   input [3:0] addr;
   output logic signed [15:0] z;
   always_ff @(posedge clk) begin
      case(addr)
        0: z <= -16'd134;
        1: z <= -16'd171;
        2: z <= 16'd131;
        3: z <= 16'd120;
        4: z <= -16'd230;
        5: z <= 16'd19;
        6: z <= 16'd52;
        7: z <= -16'd127;
        8: z <= -16'd190;
        9: z <= -16'd80;
      endcase
   end
endmodule

