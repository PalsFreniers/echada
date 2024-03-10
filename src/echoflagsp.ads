package echoflagsp is
        type echoFlags is tagged record
                lineFeed: Boolean := True;
                interpolate: Boolean := False;
        end record;

        function setFlags(self: in out echoFlags; arg: String) return Boolean;
        procedure printStrEscape(arg: String);
        procedure printHelp(name: String);
        procedure printVersion;
private
        procedure printEscape(c: Character);
end echoflagsp;
