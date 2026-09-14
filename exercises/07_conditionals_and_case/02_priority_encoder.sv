// Imagine four devices that can each raise a request line, and you can
// only service one at a time. "request" has one bit per device (bit 3
// is the highest-priority device). This should report the index of the
// highest-priority device that's currently requesting - and if nobody
// is requesting anything, it should report 0.
//
// Because casez checks branches top to bottom and stops at the first
// match, listing the highest-priority pattern first is what makes this
// a *priority* encoder rather than just "the first bit that happens to
// be set."

module priority_encoder (
    input  logic [3:0] request,
    output logic [1:0] grant
);

    always_comb begin
        casez (request)
            4'b1???: grant = 2'd3;
            // TODO: add the remaining patterns:
            //   4'b01?? -> grant = 2'd2
            //   4'b001? -> grant = 2'd1
            //   4'b0001 -> grant = 2'd0
            default: grant = 2'd0;
        endcase
    end

endmodule
