pragma Extensions_Allowed(all);
with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Directories;
with echoflagsp;


procedure echo is
        package IO renames Ada.Text_IO;
        package CLI renames Ada.Command_Line;
        package DIR renames Ada.Directories;
        flags: echoflagsp.echoFlags;
        canPrint: Boolean := False;
        i: Integer := 0;
begin
        if CLI.Argument_Count = 1 then
                arg: constant String := CLI.Argument(1); 
                case arg is
                        when "--help" =>
                                echoflagsp.printHelp(CLI.Command_Name);
                                return;
                        when "--version" =>
                                echoflagsp.printVersion;
                                return;
                        when others => null;
                end case;
        end if;
        for j in 1 .. CLI.Argument_Count loop
                arg: constant String := CLI.Argument(j);
                canPrint := flags.setFlags(arg);
                exit when canPrint;
                i := j;
        end loop;
        for j in i + 1 .. CLI.Argument_Count loop
                arg: constant String := CLI.Argument(j);
                if flags.interpolate then
                        echoflagsp.printStrEscape(arg);
                else
                        IO.Put(arg);
                end if;
                if j /= CLI.Argument_Count then
                        IO.Put(" ");
                end if;
        end loop;
        if flags.lineFeed then
                IO.Put_Line("");
        end if;
end echo;
