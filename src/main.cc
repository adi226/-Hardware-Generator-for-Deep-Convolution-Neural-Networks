// ESE 507 Project 3 Handout Code
// Fall 2019
// You may not redistribute this code

// Getting started:
// The main() function contains the code to read the parameters.
// For Parts 1 and 2, your code should be in the genLayer() function. Please
// also look at this function to see an example for how to create the ROMs.
//
// For Part 3, your code should be in the genAllLayers() function.



#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <cstdlib>
#include <cstring>
#include <assert.h>
#include <math.h>
#include<bits/stdc++.h>
using namespace std;

void printUsage();
void genLayer(int N, int M, int T, int P, vector<int>& constvector, string modName, ofstream &os);
void genAllLayers(int N, int M1, int M2, int M3, int T, int A, vector<int>& constVector, string modName, ofstream &os);
void readConstants(ifstream &constStream, vector<int>& constvector);
void genROM(vector<int>& constVector, int bits, string modName, ofstream &os);




int main(int argc, char* argv[]) {

    // If the user runs the program without enough parameters, print a helpful message
    // and quit.
    if (argc < 7) {
        printUsage();
        return 1;
    }

    int mode = atoi(argv[1]);

    ifstream const_file;
    ofstream os;
    vector<int> constVector;

    //----------------------------------------------------------------------
    // Look here for Part 1 and 2
    if ((mode == 1) && (argc == 7)) {
        // Mode 1: Generate one layer with given dimensions and one testbench

        // --------------- read parameters, etc. ---------------
        int N = atoi(argv[2]);
        int M = atoi(argv[3]);
        int T = atoi(argv[4]);
        int P = atoi(argv[5]);
        const_file.open(argv[6]);
        if (const_file.is_open() != true) {
            cout << "ERROR reading constant file " << argv[6] << endl;
            return 1;
        }

        // Read the constants out of the provided file and place them in the constVector vector
        readConstants(const_file, constVector);

        string out_file = "conv_" + to_string(N) + "_" + to_string(M) + "_" + to_string(T) + "_" + to_string(P) + ".sv";

        os.open(out_file);
        if (os.is_open() != true) {
            cout << "ERROR opening " << out_file << " for write." << endl;
            return 1;
        }
        // -------------------------------------------------------------

        // call the genLayer function you will write to generate this layer
        string modName = "conv_" + to_string(N) + "_" + to_string(M) + "_" + to_string(T) + "_" + to_string(P);
        genLayer(N, M, T, P, constVector, modName, os);

    }
    //--------------------------------------------------------------------


    // ----------------------------------------------------------------
    // Look here for Part 3
    else if ((mode == 2) && (argc == 9)) {
        // Mode 2: Generate three layer with given dimensions and interconnect them

        // --------------- read parameters, etc. ---------------
        int N  = atoi(argv[2]);
        int M1 = atoi(argv[3]);
        int M2 = atoi(argv[4]);
        int M3 = atoi(argv[5]);
        int T  = atoi(argv[6]);
        int A  = atoi(argv[7]);
        const_file.open(argv[8]);
        if (const_file.is_open() != true) {
            cout << "ERROR reading constant file " << argv[8] << endl;
            return 1;
        }
        readConstants(const_file, constVector);

        string out_file = "multi_" + to_string(N) + "_" + to_string(M1) + "_" + to_string(M2) + "_" + to_string(M3) + "_" + to_string(T) + "_" + to_string(A) + ".sv";


        os.open(out_file);
        if (os.is_open() != true) {
            cout << "ERROR opening " << out_file << " for write." << endl;
            return 1;
        }
        // -------------------------------------------------------------

        string mod_name = "multi_" + to_string(N) + "_" + to_string(M1) + "_" + to_string(M2) + "_" + to_string(M3) + "_" + to_string(T) + "_" + to_string(A);

        // call the genAllLayers function
        genAllLayers(N, M1, M2, M3, T, A, constVector, mod_name, os);

    }
    //-------------------------------------------------------

    else {
        printUsage();
        return 1;
    }

    // close the output stream
    os.close();

}

// Read values from the constant file into the vector
void readConstants(ifstream &constStream, vector<int>& constvector) {
    string constLineString;
    while(getline(constStream, constLineString)) {
        int val = atoi(constLineString.c_str());
        constvector.push_back(val);
    }
}

// Generate a ROM based on values constVector.
// Values should each be "bits" number of bits.
void genROM(vector<int>& constVector, int bits, string modName, ofstream &os) {

        int numWords = constVector.size();
        int addrBits = ceil(log2(numWords));

        os << "module " << modName << "(clk, addr, z);" << endl;
        os << "   input clk;" << endl;
        os << "   input [" << addrBits-1 << ":0] addr;" << endl;
        os << "   output logic signed [" << bits-1 << ":0] z;" << endl;
        os << "   always_ff @(posedge clk) begin" << endl;
        os << "      case(addr)" << endl;
        int i=0;
        for (vector<int>::iterator it = constVector.begin(); it < constVector.end(); it++, i++) {
            if (*it < 0)
                os << "        " << i << ": z <= -" << bits << "'d" << abs(*it) << ";" << endl;
            else
                os << "        " << i << ": z <= "  << bits << "'d" << *it      << ";" << endl;
        }
        os << "      endcase" << endl << "   end" << endl << "endmodule" << endl << endl;
}

// Parts 1 and 2
// Here is where you add your code to produce a neural network layer.
void genLayer(int N, int M, int T, int P, vector<int>& constVector, string modName, ofstream &os) {

	string s_input = "";
	string s_input1 = "";
	if (modName.at(5) >= '1' && modName.at(5) <= '3') {
	    s_input1 = modName[5];
	}
    os << "module " << modName << "(clk, reset, s_data_in_x, s_valid_x, s_ready_x, m_data_out_y, m_valid_y, m_ready_y);"<<endl;
    os << "    parameter                      T = " << T << ", " <<  "X_COUNT = " << N <<", " << "F_COUNT = "<< M << ", ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT);" << endl;
    os << "    input                          clk, reset, s_valid_x, m_ready_y;"<<endl;
    os << "    input signed [T-1:0]           s_data_in_x;"<<endl;
    os << "    output logic                   s_ready_x, m_valid_y;"<<endl;
    os << "    output logic signed [T-1:0]    m_data_out_y;"<<endl;
    os << "    logic [ADDR_X-1:0]             ";
	for(int i = 1; i <= P; i++){
		if(i < P){
			s_input = "addr_x" + to_string(i) + ", ";
			os << s_input;
		}
		else if(i == P){
			s_input = "addr_x" + to_string(i) + ";";
			os << s_input << endl;
		}
	}
    os << "    logic [ADDR_F-1:0]             addr_f;"<<endl;
    os << "    logic                          wr_en_x, clear_acc, en_acc, op_done;"<<endl;
    os << "    datapath" << s_input1 <<" d(.clk(clk), .reset(reset), .s_data_in_x(s_data_in_x), .wr_en_x(wr_en_x), .clear_acc(clear_acc), .en_acc(en_acc),"<<endl;
    os << "               .m_data_out_y(m_data_out_y), .m_valid_y(m_valid_y), .m_ready_y(m_ready_y), .op_done(op_done), .addr_f(addr_f),"<<endl<<"               ";
    for(int i = 1; i <= P; i++){
    	if(i < P){
    		s_input = ".addr_x" + to_string(i) + "(addr_x" + to_string(i) + "), ";
    		os << s_input;
    	}
    	else if(i == P){
    		s_input = ".addr_x" + to_string(i) + "(addr_x" + to_string(i) + "));";
    		os << s_input << endl;
    	}
    }
    os << "    ctrlpath" << s_input1 <<" c(.clk(clk), .reset(reset), .s_valid_x(s_valid_x), .m_ready_y(m_ready_y), .wr_en_x(wr_en_x), .clear_acc(clear_acc),"<<endl;
    os << "               .en_acc(en_acc), .s_ready_x(s_ready_x), .m_valid_y(m_valid_y), .op_done(op_done), .addr_f(addr_f),"<<endl<<"               ";
    for(int i = 1; i <= P; i++){
    	if(i < P){
    		s_input = ".addr_x" + to_string(i) + "(addr_x" + to_string(i) + "), ";
    		os << s_input;
    	}
    	else if(i == P){
    		s_input = ".addr_x" + to_string(i) + "(addr_x" + to_string(i) + "));";
    		os << s_input << endl;
    	}
    }
    os << "endmodule"<<endl;
    os << ""<<endl;
    os << "module datapath" << s_input1 <<" (clk, reset, s_data_in_x, wr_en_x, clear_acc, en_acc, m_data_out_y, m_valid_y, m_ready_y, op_done, addr_f,"<<endl<<"                 ";
    for(int i = 1; i <= P; i++){
    	if(i < P){
    		s_input = "addr_x" + to_string(i) + ", ";
    		os << s_input;
    	}
    	else if(i == P){
    		s_input = "addr_x" + to_string(i) + ");";
    		os << s_input << endl;
    	}
    }
    os << "    parameter                      T = " << T << ", " << "P = " << P << ", "<<  "X_COUNT = " << N <<", " << "F_COUNT = "<< M << ", ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT);" << endl;
    os << "    input                          clk, reset, wr_en_x, clear_acc, en_acc;"<<endl;
    os << "    input signed [T-1:0]           s_data_in_x;"<<endl;
    os << "    input [ADDR_X-1:0]             ";
	for(int i = 1; i <= P; i++){
		if(i < P){
			s_input = "addr_x" + to_string(i) + ", ";
			os << s_input;
		}
		else if(i == P){
			s_input = "addr_x" + to_string(i) + ";";
			os << s_input << endl;
		}
	}
    os << "    input [ADDR_F-1:0]             addr_f;"<<endl;
    os << "    logic signed [T-1:0]           ";
	for(int i = 1; i <= P; i++){
		if(i < P){
			s_input = "m_data_out_y" + to_string(i) + ", ";
			os << s_input;
		}
		else if(i == P){
			s_input = "m_data_out_y" + to_string(i) + ";";
			os << s_input << endl;
		}
	}
    os << "    logic signed [T-1:0]           s_data_out_f, ";
	for(int i = 1; i <= P; i++){
		if(i < P){
			s_input = "s_data_out_x" + to_string(i) + ", ";
			os << s_input;
		}
		else if(i == P){
			s_input = "s_data_out_x" + to_string(i) + ";";
			os << s_input << endl;
		}
	}
    os << "    output logic signed [T-1:0]    m_data_out_y;" << endl;
    os << "    input logic                    m_valid_y, m_ready_y;" << endl;
    os << "    logic [P:0]                    counter2;" << endl;
    os << "    output logic                   op_done;" << endl;
    os << "    "<<modName<<"_f_rom rom(.clk(clk), .addr(addr_f), .z(s_data_out_f));"<<endl;
    for(int i = 1; i <= P; i++){
    	os << "    memory" << s_input1 <<" #(T, X_COUNT, ADDR_X) x_mem" << i <<"(.clk(clk), .data_in(s_data_in_x), .data_out(s_data_out_x" << i <<"), .addr(addr_x" <<i <<"), .wr_en(wr_en_x));"<<endl;
    }
    for(int i = 1; i <= P; i++){
    	os << "    mac" << s_input1 <<" m" << i <<" (.clk(clk), .en_acc(en_acc), .reset(reset), .clear_acc(clear_acc), .inx(s_data_out_x" << i << "), .inf(s_data_out_f), .out(m_data_out_y" << i <<")," << endl <<"        	.m_valid_y(m_valid_y));" << endl;
    }
    os << endl;
    os << "    always_comb begin" << endl;
    os << "        if((m_valid_y == 1) & (m_ready_y == 1)) begin" << endl;
    os << "            if(counter2 == 0) begin" << endl;
    os << "                m_data_out_y = m_data_out_y1;" <<  endl;
    os << "            end" << endl;
    for(int i = 1; i <= P-1; i++){
    	os << "            else if(counter2 ==" << i <<") begin" << endl;
    	os << "                m_data_out_y = m_data_out_y"<< i+1 <<";" << endl;
    	os << "            end" << endl;
    }
    os << "            else begin" << endl;;
    os << "                m_data_out_y = 0;" << endl;
    os << "            end" << endl;
    os << "        end" << endl;
    os << "        else begin" << endl;
    os << "            m_data_out_y = 0;" << endl;
    os << "        end" << endl;
    os << "    end" << endl;
    os << "    assign op_done = (m_valid_y == 1) & (m_ready_y == 1) & (counter2 == P-1); " << endl;
    os << "    always_ff @(posedge clk) begin" << endl;
    os << "        if (reset == 1) begin" << endl;
    os << "            counter2 <= 0;" << endl;
    os << "        end" << endl;
    os << "        if((m_valid_y == 1) & (m_ready_y == 1)) begin" << endl;
    os << "            counter2 <= counter2 + 1;" << endl;
    os << "        end" << endl;
    os << "        else if((m_valid_y == 0) & (m_ready_y == 1)) begin" << endl;
    os << "            counter2 <= 0;" << endl;
    os << "        end" << endl;
    os << "        else if((m_valid_y == 0) & (m_ready_y == 0)) begin" << endl;
    os << "            counter2 <= 0;" << endl;
    os << "        end" << endl;
    os << "    end" << endl;
    os << "endmodule"<<endl;
    os << ""<<endl;
    os << "module ctrlpath" << s_input1 <<" (clk, reset, s_valid_x, m_ready_y, wr_en_x, clear_acc, en_acc, s_ready_x, m_valid_y, op_done, addr_f,\n                 ";
	for(int i = 1; i <= P; i++){
		if(i < P){
			s_input = "addr_x" + to_string(i) + ", ";
			os << s_input;
		}
		else if(i == P){
			s_input = "addr_x" + to_string(i) + ");";
			os << s_input << endl;
		}
	}
    os << "    parameter                      T = " << T << ", " << "P = " << P << ", "<<  "X_COUNT = " << N <<", " << "F_COUNT = "<< M << ", ADDR_X = $clog2(X_COUNT), ADDR_F = $clog2(F_COUNT)," << endl;
    os << "	                               OP_COUNT = X_COUNT-F_COUNT+1, COUNTER_V = $clog2(OP_COUNT);" << endl;
    os << "    input logic                    clk, reset, s_valid_x, m_ready_y;"<<endl;
    os << "    output logic                   s_ready_x, m_valid_y;"<<endl;
    os << "    output logic [ADDR_X-1:0]             ";
	for(int i = 1; i <= P; i++){
		if(i < P){
			s_input = "addr_x" + to_string(i) + ", ";
			os << s_input;
		}
		else if(i == P){
			s_input = "addr_x" + to_string(i) + ";";
			os << s_input << endl;
		}
	}
    os << "    output logic [ADDR_F-1:0]      addr_f;"<<endl;
    os << "    output logic                   wr_en_x, clear_acc, en_acc;"<<endl;
    os << "    logic                          wr_done_x, loaded_x; "<<endl;
    os << "    logic [COUNTER_V + 1:0]        counter;"<<endl;
    os << "    logic [ADDR_F:0]               counter1;"<<endl;
    os << "    input logic                    op_done;";
    os << ""<<endl;
    os << "    always_ff @(posedge clk) begin"<<endl;
    os << "        if (reset == 1) begin"<<endl;
    os << "            s_ready_x <= 1;"<<endl;
    for (int i = 1; i <= P; i++){
    	os << "            addr_x" << i << "<= 0;" << endl;
    }
    os << "            addr_f <= 0;"<<endl;
    os << "            counter1 <= 0;"<<endl;
    os << "            en_acc <= 0;"<<endl;
    os << "            counter <= P;"<<endl;
    os << "            wr_done_x <= 0;"<<endl;
    os << "            m_valid_y <= 0;"<<endl;
    os << "        end"<<endl;
    os << "        if (wr_en_x == 1) begin"<<endl;
    for(int i = 1; i <= P; i++){
    	os << "            addr_x" << i << " <= addr_x" << i << " + 1;"<<endl;
    }
    os << "        end"<<endl;
    os << "        if (loaded_x == 1) begin"<<endl;
    for(int i = 1; i <= P; i++){
    	os << "            addr_x" << i << " <= " << i -1 <<";"<<endl;
    }
    os << "            addr_f <= 0;"<<endl;
	os << "            counter1 <= 0;"<<endl;
    os << "            s_ready_x <= 0;"<<endl;
    os << "        end"<<endl;
    os << "        if ((s_ready_x == 0) & (m_valid_y == 0)) begin"<<endl;
    os << "            if (counter < OP_COUNT+1) begin"<<endl;
    os << "                if (counter1 == 1) begin"<<endl;
    os << "                    en_acc <= 1;"<<endl;
    os << "                end"<<endl;
    os << "                else if (counter1 == F_COUNT+1) begin"<<endl;
    os << "                    en_acc <= 0;"<<endl;
    os << "                end"<<endl;
    os << "                if (counter1 < F_COUNT+1) begin"<<endl;
    for(int i = 1; i <= P; i++){
    	os << "                    addr_x" << i << " <= addr_x" << i << " + 1;"<<endl;
    }
    os << "                    addr_f <=  addr_f + 1;"<<endl;
    os << "                    counter1 <= counter1 + 1;"<<endl;
    os << "                end"<<endl;
    os << "                else begin"<<endl;
    os << "                    m_valid_y <= 1;"<<endl;
    os << "                    counter <= counter + P;"<<endl;
    for(int i = 1; i <= P; i++){
    	os << "                    addr_x" << i << " <= counter" << " + " << i-1 << ";"<<endl;
    }
    os << "                    addr_f <= 0;"<<endl;
	os << "                    counter1 <= 0;"<<endl;
    os << "                end"<<endl;
    os << "            end"<<endl;
    os << "            else begin"<<endl;
    for (int i = 1; i <= P; i++){
    	os << "                addr_x" << i << "<= 0;" << endl;
    }
    os << "                addr_f <= 0;"<<endl;
	os << "                counter1 <= 0;"<<endl;
    os << "                s_ready_x <= 1;"<<endl;
    os << "                counter <= P;"<<endl;
    os << "            end"<<endl;
    os << "        end"<<endl;
    os << "        if (clear_acc == 1) begin"<<endl;
    os << "            m_valid_y <= 0;"<<endl;
    os << "        end"<<endl;
    os << "    end"<<endl;
    os << "    assign wr_en_x = (s_ready_x == 1) & (s_valid_x == 1);"<<endl;
    os << "    assign loaded_x = (addr_x1 == X_COUNT-1) & (wr_en_x == 1);"<<endl;
    os << "    assign clear_acc = (m_valid_y == 1) & (m_ready_y == 1) & (op_done == 1);"<<endl;
    os << ""<<endl;
    os << "endmodule"<<endl;
    os << ""<<endl;
    os << "module mac" << s_input1 <<"(clk, en_acc, reset, clear_acc, inx, inf, out, m_valid_y);"<<endl;
    os << "    parameter                    T = " << T << ", MAX_VAL = ((1<<(T-1))-1), MIN_VAL = (-1*(1<<(T-1)));" << endl;
    os << "    input                        clk, clear_acc, reset;"<<endl;
    os << "    input signed [T-1:0]         inx, inf;"<<endl;
    os << "    output logic signed[T-1:0]   out;"<<endl;
    os << "    logic signed[T:0]            out_temp;"<<endl;
    os << "    logic signed[T-1:0]          mul;" <<endl;
    os << "    logic signed[2*T-1:0]        mul_temp;"<<endl;
    os << "    input                        en_acc;"<<endl;
    os << "    input logic                  m_valid_y;"<<endl;
    os << ""<<endl;
    os << "    always_ff @(posedge clk)"<<endl;
    os << "    begin"<<endl;
    os << "        mul_temp <= inx * inf;"<<endl;
    os << "    end"<<endl;
    os << ""<<endl;
    os << "    always_ff @(posedge clk) begin"<<endl;
    os << "        if (reset == 1) begin"<<endl;
    os << "           out_temp <= 0;"<<endl;
    os << "        end"<<endl;
    os << "        else if (clear_acc == 1) begin"<<endl;
    os << "           out_temp <= 0;"<<endl;
    os << "        end"<<endl;
    os << "         else if(en_acc == 1) begin"<<endl;
    os << "           out_temp <= mul + out;"<<endl;
    os << "        end"<<endl;
    os << "    end"<<endl;
    os << ""<<endl;
    os << "    always_comb begin"<<endl;
    os << "        if(mul_temp>MAX_VAL) begin"<<endl;
    os << "            mul = MAX_VAL;"<<endl;
    os << "        end"<<endl;
    os << "        else if(mul_temp<MIN_VAL) begin"<<endl;
    os << "            mul = MIN_VAL;"<<endl;
    os << "        end"<<endl;
    os << "        else begin"<<endl;
    os << "            mul = mul_temp;"<<endl;
    os << "        end"<<endl;
    os << ""<<endl;
    os << "        if(m_valid_y == 1) begin"<<endl;
    os << "            if(out_temp < 0) begin"<<endl;
    os << "                out = 0;"<<endl;
    os << "            end"<<endl;
    os << "            else if(out_temp>MAX_VAL) begin"<<endl;
    os << "                out = MAX_VAL;"<<endl;
    os << "            end"<<endl;
    os << "            else begin"<<endl;
    os << "                out = out_temp;"<<endl;
    os << "            end"<<endl;
    os << "        end"<<endl;
    os << "        else if(out_temp>MAX_VAL) begin"<<endl;
    os << "            out = MAX_VAL;"<<endl;
    os << "        end"<<endl;
    os << "        else if(out_temp<MIN_VAL)begin "<<endl;
    os << "            out = MIN_VAL;"<<endl;
    os << "        end"<<endl;
    os << "        else begin"<<endl;
    os << "            out = out_temp;"<<endl;
    os << "        end"<<endl;
    os << "    end"<<endl;
    os << "endmodule"<<endl;
    os << ""<<endl;
    os << "module memory" << s_input1 <<"(clk, data_in, data_out, addr, wr_en);"<<endl;
    os << "    parameter                   WIDTH=16, SIZE=64, LOGSIZE=6;"<<endl;
    os << "    input [WIDTH-1:0]           data_in;"<<endl;
    os << "    output logic [WIDTH-1:0]    data_out;"<<endl;
    os << "    input [LOGSIZE-1:0]         addr;"<<endl;
    os << "    input                       clk, wr_en;"<<endl;
    os << ""<<endl;
    os << "    logic [SIZE-1:0][WIDTH-1:0] mem;"<<endl;
    os << ""<<endl;
    os << "    always_ff @(posedge clk) begin"<<endl;
    os << "        data_out <= mem[addr];"<<endl;
    os << "        if (wr_en)"<<endl;
    os << "            mem[addr] <= data_in;"<<endl;
    os << "    end"<<endl;
    os << "endmodule"<<endl;
    os << ""<<endl;
    // At some point you will want to generate a ROM with values from the pre-stored constant values.
    // Here is code that demonstrates how to do this for the simple case where you want to put all of
    // the matrix values W in one ROM, and all of the bias values B into another ROM. (This is probably)
    // all that you will need for the ROMs.

    // Check there are enough values in the constant file.
    if (M > constVector.size()) {
        cout << "ERROR: constVector does not contain enough data for the requested design" << endl;
        cout << "The design parameters requested require " << M << " numbers, but the provided data only have " << constVector.size() << " constants" << endl;
        assert(false);
    }

    // Generate a ROM for f with constants in constVector, T bits, and the given name
    string romModName = modName + "_f_rom";
    genROM(constVector, T, romModName, os);

}

bool sortLayer(const pair<string,int> &a, const pair<string,int> &b) {
       return a.second<b.second;
}

// Part 3: Generate a hardware system with three layers interconnected.
// Layer 1: Input length: N, filter length: M1, output length: L1 = N-M1+1
// Layer 2: Input length: L1, filter length: M2, output length: L2 = L1-M2+1
// Layer 3: Input length: M2, filter length: M3, output length: L3 = L2-M3+1
// T is the number of bits
// A is the number of multipliers your overall design may use.
// Your goal is to build the highest-throughput design that uses A or fewer multipliers
// constVector holds all the constants for your system (all three layers, in order)
void genAllLayers(int N, int M1, int M2, int M3, int T, int A, vector<int>& constVector, string modName, ofstream &os) {

    // Here you will write code to figure out the best values to use for P1, P2, and P3, given
    // mult_budget.
    int P1 = 1;
    int P2 = 1;
    int P3 = 1;
	int l1, l2, l3;
	l1 = N - M1 + 1;
	l2 = N - M1 - M2 + 2;
	l3 = N - M1 - M2 - M3 + 3;
	for(int k = A-2; k > 0; k--){
		if(l1 % k == 0){
			P1 = k;
			break;
		}
	}

	for(int k = A-P1-1; k > 0; k--){
		if(l2 % k == 0){
			P2 = k;
			break;
		}
	}

	for(int k = A-P1-P2; k > 0; k--){
		if(l3 % k == 0){
			P3 = k;
			break;
		}
	}

    cout<<"P1=" << P1 << "  P2=" << P2 << "  P3=" << P3;

    // output top-level module


    os << "module " << modName << "(clk, reset, s_data_in_x, s_valid_x, s_ready_x, m_data_out_y, m_valid_y, m_ready_y);" << endl;
    os << "    parameter                      T = "<< T << ";" << endl;
    os << "    input                          clk, reset, s_valid_x, m_ready_y;" << endl;
    os << "    input signed [T-1:0]           s_data_in_x;" << endl;
    os << "    output logic                   s_ready_x, m_valid_y;" << endl;
    os << "    output logic signed [T-1:0]    m_data_out_y;" << endl;
    os << "    logic                          m_ready_y1, m_ready_y2;" << endl;
    os << "    logic                          m_valid_y1, m_valid_y2;" << endl;
    os << "    logic signed [T-1:0]           m_data_out_y1, m_data_out_y2;" << endl;
    os << "    layer1_" << N << "_" << M1 << "_" << T <<"_" << P1 << " l1(.clk(clk), .reset(reset), .s_data_in_x(s_data_in_x), .s_valid_x(s_valid_x), .s_ready_x(s_ready_x)," << endl;
    os << "                       .m_data_out_y(m_data_out_y1), .m_valid_y(m_valid_y1), .m_ready_y(m_ready_y1));" << endl;
    os << "    layer2_" << N-M1+1 << "_" << M2 << "_" << T <<"_" << P2 << " l2(.clk(clk), .reset(reset), .s_data_in_x(m_data_out_y1), .s_valid_x(m_valid_y1), .s_ready_x(m_ready_y1)," << endl;
    os << "                       .m_data_out_y(m_data_out_y2), .m_valid_y(m_valid_y2), .m_ready_y(m_ready_y2));" << endl;
    os << "    layer3_" << N-M1-M2+2 << "_" << M3 << "_" << T <<"_" << P3 << " l3(.clk(clk), .reset(reset), .s_data_in_x(m_data_out_y2), .s_valid_x(m_valid_y2), .s_ready_x(m_ready_y2),"<< endl;
    os << "                      .m_data_out_y(m_data_out_y), .m_valid_y(m_valid_y), .m_ready_y(m_ready_y));" << endl;
    os << "endmodule" << endl;





    // -------------------------------------------------------------------------
    // Split up constVector for the three layers
    int start = 0;
    int stop = M1;
    vector<int> constVector1(&constVector[start], &constVector[stop]);

    // layer 2's W matrix is M2 x M1 and its B vector has size M2
    start = stop;
    stop = start+M2;
    vector<int> constVector2(&constVector[start], &constVector[stop]);

    // layer 3's W matrix is M3 x M2 and its B vector has size M3
    start = stop;
    stop = start+M3;
    vector<int> constVector3(&constVector[start], &constVector[stop]);

    if (stop > constVector.size()) {
        cout << "ERROR: constVector does not contain enough data for the requested design" << endl;
        cout << "The design parameters requested require " << stop << " numbers, but the provided data only have " << constVector.size() << " constants" << endl;
        assert(false);
    }
    // --------------------------------------------------------------------------


    // generate the three layer modules
    string subModName1 = "layer1_" + to_string(N) + "_" + to_string(M1) + "_" + to_string(T) + "_" + to_string(P1);
    genLayer(N, M1, T, P1, constVector1, subModName1, os);
    int L1 = N-M1+1;

    string subModName2 = "layer2_" + to_string(L1) + "_" + to_string(M2) + "_" + to_string(T) + "_" + to_string(P2);
    genLayer(L1, M2, T, P2, constVector2, subModName2, os);

    int L2 = L1-M2+1;
    string subModName3 = "layer3_" + to_string(L2) + "_" + to_string(M3) + "_" + to_string(T) + "_" + to_string(P3);
    genLayer(L2, M3, T, P3, constVector3, subModName3, os);

    // You will need to add code in the module at the top of this function to stitch together insantiations of these three modules

}

void printUsage() {
    cout << "Usage: ./gen MODE ARGS" << endl << endl;

    cout << "   Mode 1: Produce one convolution module (Part 1 and Part 2)" << endl;
    cout << "      ./gen 1 N M T P const_file" << endl;
    cout << "      See project description for explanation of parameters." << endl;
    cout << "      Example: produce a convolution with input vector of length 16, filter of length 4, parallelism 1" << endl;
    cout << "               and 16 bit words, with constants stored in file const.txt" << endl;
    cout << "                   ./gen 1 16 4 16 1 const.txt" << endl << endl;

    cout << "   Mode 2: Produce a system with three interconnected convolution module (Part 3)" << endl;
    cout << "      Arguments: N, M1, M2, M3, T, A, const_file" << endl;
    cout << "      See project description for explanation of parameters." << endl;
    cout << "              e.g.: ./gen 2 16 4 5 6 15 16 const.txt" << endl << endl;
}
