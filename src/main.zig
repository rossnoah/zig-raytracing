const hello = @import("hello.zig");

pub fn main() !void {
    hello.helloWorld();
}
