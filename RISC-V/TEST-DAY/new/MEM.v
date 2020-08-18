`timescale 1ns / 1ps

module MEM(
input clk,
input [63:0] addr,
input [63:0]W,
input mwr,
input type,
output [63:0] out
    );
    reg [63:0] data [9:0];
    integer file,i;
    initial begin
        file = $fopen("C:\\Users\\student\\Desktop\\111801001\\RISC-V\\memory.txt","r");
        $readmemb("C:\\Users\\student\\Desktop\\111801001\\RISC-V\\memory.txt",data);
        $fclose(file);
    end
    assign out = (type==1'b1)?data[addr/8] : {{34{data[addr/8][31]}},data[addr/8][30:0]};

    always@(posedge clk) begin
        if(mwr==1) begin
            data[addr/8] = W;
            file = $fopen("C:\\Users\\student\\Desktop\\111801001\\RISC-V\\memory.txt","w");
            for(i=0;i<10;i=i+1)
                $fwrite(file,"%b\n",data[i]);
            $fclose(file);
        end
    end
    
endmodule