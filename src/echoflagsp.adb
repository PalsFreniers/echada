pragma Extensions_Allowed(all);
with Ada.Text_IO;

package body echoflagsp is
        package IO renames Ada.Text_IO;

        function setFlags(self: in out echoFlags; arg: String) return Boolean is
                save: constant echoFlags := self;
        begin
                if arg'Length < 1 then
                        return True;
                end if;
                if arg(arg'First) /= '-' then
                        return True;
                end if;
                for i in arg'First + 1 .. arg'Length loop
                        if arg(i) not in 'e' | 'E' | 'n' then
                                self := save;
                                return True;
                        end if;
                        case arg(i) is
                                when 'e' => self.interpolate := True;
                                when 'E' => self.interpolate := False;
                                when 'n' => self.lineFeed := False;
                                when others => null;
                        end case;
                end loop;
                return False;
        end setFlags;

        procedure printStrEscape(arg: String) is
        begin
                print: Boolean := True;
                for k in arg'First .. arg'Length loop
                        if print then
                                case arg(k) is
                                        when '\' =>
                                                printEscape(arg(k + 1));
                                                print := False;
                                        when others => IO.Put(arg(k));
                                end case;
                        elsif not print then
                                print := True;
                        end if;
                end loop;
        end printStrEscape;

        procedure printEscape(c: Character) is
        begin
                case c is
                        when '\' => IO.Put('\');
                        when 'a' => IO.Put(Character'Val(7));
                        when 'b' => IO.Put(Character'Val(127));
                        when 'f' => IO.Put(Character'Val(12));
                        when 'n' => IO.Put(Character'Val(10));
                        when 'r' => IO.Put(Character'Val(13));
                        when 't' => IO.Put(Character'Val(9));
                        when 'v' => IO.Put(Character'Val(11));
                        when others => IO.Put('\' & c);
                end case;
        end printEscape;

        procedure printHelp(name: String) is
        begin
                IO.Put_Line("Usage: " & name & " [SHORT-OPTION]... [STRING]..." & ASCII.CR & ASCII.LF
                & "   or: " & name & " LONG-OPTION" & ASCII.CR & ASCII.LF
                & "print the STRING(s) to standard output." & ASCII.CR & ASCII.LF
                & "" & ASCII.CR & ASCII.LF
                & "  -n             do not output the trailing newline" & ASCII.CR & ASCII.LF
                & "  -e             enable interpretation of backslash escapes" & ASCII.CR & ASCII.LF
                & "  -E             disable interpretation of backslash escapes (default)" & ASCII.CR & ASCII.LF
                & "  --help         display this help and exit" & ASCII.CR & ASCII.LF
                & "  --version      output version information and exit" & ASCII.CR & ASCII.LF
                & "" & ASCII.CR & ASCII.LF
                & "If -e is in effect, the following sequences are recognized:" & ASCII.CR & ASCII.LF
                & "" & ASCII.CR & ASCII.LF
                & "  \\      backslash" & ASCII.CR & ASCII.LF
                & "  \a      alert (BEL)" & ASCII.CR & ASCII.LF
                & "  \b      backspace" & ASCII.CR & ASCII.LF
                & "  \f      form feed" & ASCII.CR & ASCII.LF
                & "  \n      new line" & ASCII.CR & ASCII.LF
                & "  \r      carriage return" & ASCII.CR & ASCII.LF
                & "  \t      horizontal tab" & ASCII.CR & ASCII.LF
                & "  \v      vertical tab" & ASCII.CR & ASCII.LF
                & "" & ASCII.CR & ASCII.LF
                & "NOTE: your shell may have its own version of echo, which usually supersedes" & ASCII.CR & ASCII.LF
                & "the version described here. Please refer to your shell's documentation" & ASCII.CR & ASCII.LF
                & "for details about the options it supports.");
        end printHelp;

        procedure printVersion is
        begin
                IO.Put_Line("echada (echo reproduction) 1.0" & ASCII.CR & ASCII.LF
                & "Copyright (C) 2020 Free Software Foundation, Inc." & ASCII.CR & ASCII.LF
                & "License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>." & ASCII.CR & ASCII.LF
                & "This is free software: you are free to change and redistribute it." & ASCII.CR & ASCII.LF
                & "There is NO WARRANTY, to the extent permitted by law." & ASCII.CR & ASCII.LF
                & "" & ASCII.CR & ASCII.LF
                & "Written in Ada by PalsFreniers.");
        end printVersion;
end echoflagsp;
