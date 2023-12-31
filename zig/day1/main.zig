const std = @import("std");
const eql = std.mem.eql;
const ArrayList = std.ArrayList;

const test_allocator = std.testing.allocator;
const expect = std.testing.expect;

const File = std.fs.File;

fn nextLine(reader: anytype, buffer: []u8) !?[]const u8 {
    var line = (try reader.readUntilDelimiterOrEof(
        buffer,
        '\n',
    )) orelse return null;
    return line;
}

test "Part1" {
    const flags: File.OpenFlags = .{};
    const file = try std.fs.cwd().openFile("../../subjects/day1/input", flags);
    defer file.close();

    var buffer: [100]u8 = undefined;

    var list = ArrayList(u32).init(test_allocator);
    defer list.deinit();

    try list.append(0);

    while (true) {
        const input = (try nextLine(file.reader(), &buffer));
        if (input) |i| {
            if (i.len == 0) {
                try list.append(0);
            } else {
                const number = try std.fmt.parseInt(u32, i, 10);
                list.items[list.items.len - 1] += number;
            }
        } else {
            break;
        }
    }
    std.debug.print("Here {d} \n", .{std.mem.max(u32, list.items)});
}

test "Part2" {
    const flags: File.OpenFlags = .{};
    const file = try std.fs.cwd().openFile("./input", flags);
    defer file.close();

    var buffer: [100]u8 = undefined;

    var list = ArrayList(u32).init(test_allocator);
    defer list.deinit();

    try list.append(0);

    while (true) {
        const input = (try nextLine(file.reader(), &buffer));
        if (input) |i| {
            if (i.len == 0) {
                try list.append(0);
            } else {
                const number = try std.fmt.parseInt(u32, i, 10);
                list.items[list.items.len - 1] += number;
            }
        } else {
            break;
        }
    }
    std.sort.sort(u32, list.items, {}, comptime std.sort.desc(u32));
    std.debug.print("Here {d} \n", .{list.items[0] + list.items[1] + list.items[2]});
}
