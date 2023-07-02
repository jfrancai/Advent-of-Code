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

//   A B C
// X 3 0 6
// Y 6 3 0
// Z 0 6 3
const hashTable: [3][3]u8 = [3][3]u8{ [3]u8{ 3, 0, 6 }, [3]u8{ 6, 3, 0 }, [3]u8{ 0, 6, 3 } };

test "Part1" {
    const flags: File.OpenFlags = .{};
    const file = try std.fs.cwd().openFile("./input", flags);
    defer file.close();

    var buffer: [10]u8 = undefined;

    var list = ArrayList(u32).init(test_allocator);
    defer list.deinit();

    try list.append(0);

    var finalScore: u32 = 0;

    while (true) {
        const input = (try nextLine(file.reader(), &buffer));
        if (input) |i| {
            const oponent: u8 = (i[0] + 1) % 3;
            const me: u8 = (i[2] - 1) % 3;
            finalScore += hashTable[me][oponent] + me + 1;
        } else {
            break;
        }
    }
    std.debug.print("\nHere is the result : {d}\n", .{finalScore});
}

//   X Y Z
// A 2 0 1
// B 0 1 2
// C 1 2 0
const hashTable2: [3][3]u8 = [3][3]u8{ [3]u8{ 2, 0, 1 }, [3]u8{ 0, 1, 2 }, [3]u8{ 1, 2, 0 } };

test "Part2" {
    const flags: File.OpenFlags = .{};
    const file = try std.fs.cwd().openFile("./input", flags);
    defer file.close();

    var buffer: [10]u8 = undefined;

    var list = ArrayList(u32).init(test_allocator);
    defer list.deinit();

    try list.append(0);

    var finalScore: u32 = 0;

    while (true) {
        const input = (try nextLine(file.reader(), &buffer));
        if (input) |i| {
            const oponent: u8 = (i[0] + 1) % 3;
            const me: u8 = hashTable2[oponent][(i[2] - 1) % 3];
            finalScore += hashTable[me][oponent] + me + 1;
        } else {
            break;
        }
    }
    std.debug.print("\nHere is the result : {d}\n", .{finalScore});
}
