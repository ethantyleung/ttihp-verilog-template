/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_programmable_counter (
    input wire clk,          // Clock input
    input wire reset,        // Active-high reset
    input wire load,         // Load control signal
    input wire oe,           // Output enable (active-high for tri-state)
    input wire [7:0] data_in, // 8-bit input data for loading
    output wire [7:0] count  // 8-bit counter output (tri-state)
);

    // Internal counter register
    reg [7:0] counter_reg;

    // Counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Asynchronous reset (clears the counter)
            counter_reg <= 8'b0;
        end else if (load) begin
            // Synchronous load (loads data_in into the counter)
            counter_reg <= data_in;
        end else begin
            // Normal counting operation (increment by 1)
            counter_reg <= counter_reg + 1;
        end
    end

    // Tri-state output control
    assign count = oe ? counter_reg : 8'bz;

endmodule