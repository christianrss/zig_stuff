const Builder = @import("std").Build;

pub fn buildExample(b: *Builder, comptime path:[] const u8, comptime name: []const u8) void {
    const exe = b.addExecutable(.{ 
        .name = name, 
        .root_source_file =  b.path(path ++ "/" ++ name ++ ".zig"),
        .target = b.host
    });
    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step(name, "Run the algorithm");
    run_step.dependOn(&run_cmd.step);
}

pub fn build(b: *Builder) void {
    buildExample(b, "algorithms", "bubble_sort");
}