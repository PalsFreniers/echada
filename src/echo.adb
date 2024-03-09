pragma Extensions_Allowed(all);
with Ada.Text_IO;
with Ada.Command_Line;
with echoflagsp;


procedure echo is
        package IO renames Ada.Text_IO;
        package CLI renames Ada.Command_Line;
        flags: echoflagsp.echoFlags;
        canPrint: Boolean := False;
        i: Integer;
begin
        for j in 1 .. CLI.Argument_Count loop
                arg: constant String := CLI.Argument(i);
                canPrint := flags.setFlags(arg);
                exit when canPrint;
                i := j;
        end loop;
        flags.printFrom(i, CLI.Argument'Access, CLI.Argument_Count);
        if flags.lineFeed then
                IO.Put_Line("");
        end if;
        IO.Put_Line("---");
end echo;
