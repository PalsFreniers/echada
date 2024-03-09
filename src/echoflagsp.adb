pragma Extensions_Allowed(all);
with Ada.Text_IO;
with Ada.Command_Line;

package body echoflagsp is
        function setFlags(self: in out echoFlags; arg: String) return Boolean is
                save: constant echoFlags := self;
        begin
                if arg'Length < 1 then
                        return True;
                end if;
                if arg'First /= Character'Pos('-') then
                        return True;
                end if;
                for i in 2 .. arg'Length loop
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

        procedure printFrom(self: echoFlags; index: Integer; argv: args; len: Positive) is
                package IO renames Ada.Text_IO;
        begin
                if index >= len then
                        return;
                end if;
                for i in index .. len loop
                        arg: constant String := argv(i);
                        IO.Put(arg & ' ');
                end loop;
        end printFrom;
end echoflagsp;
