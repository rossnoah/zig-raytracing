const hello = @import("hello.zig");
const std = @import("std");

pub fn main() !void {
    hello.helloWorld();

    const height = 256;
    const width = 256;

    const alc = std.heap.page_allocator;

    const file = try std.fs.cwd().createFile(
        "image.ppm",
        .{
            .read = true,
        },
    );
    defer file.close();

    // std.debug.print("P3\n{} {}\n", .{ height, width });
    try file.writeAll(try std.fmt.allocPrint(alc, "P3\n{} {}\n255\n", .{ height, width }));

    for (0..height) |i| {
        for (0..width) |j| {
            const r = @as(f16, @floatFromInt(i)) / width;
            const g = @as(f16, @floatFromInt(j)) / height;
            const b = @as(f16, @floatFromInt(0));

            const ir = @as(u16, @intFromFloat(256 * r));
            const ig = @as(u16, @intFromFloat(256 * g));
            const ib = @as(u16, @intFromFloat(256 * b));

            // std.debug.print("{} {} {}\n", .{ ir, ig, ib });
            try file.writeAll(try std.fmt.allocPrint(alc, "{} {} {}\n", .{ ir, ig, ib }));
        }
    }
}
