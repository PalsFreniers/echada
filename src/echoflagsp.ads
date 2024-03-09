package echoflagsp is
        type echoFlags is tagged record
                lineFeed: Boolean := True;
                interpolate: Boolean := False;
        end record;

        function setFlags(self: in out echoFlags; arg: String) return Boolean;
        type args is access function(Number: Positive) return String;
        procedure printFrom(self: echoFlags; index: Integer; argv: args; len: Positive);
end echoflagsp;
