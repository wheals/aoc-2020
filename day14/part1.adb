with Ada.Text_IO; use Ada.Text_IO;
with Interfaces; use Interfaces;
with Ada.Containers.Indefinite_Ordered_Maps;

procedure Part1 is
    F         : File_Type;
    File_Name : constant String := "input.txt";

    LinePrefix : String (1 .. 4);
    LinePostfix : String (1 .. 3);
    Bracket: Character;

    type ThirtySix is mod 2 ** 36;
    MaskString : String (1 .. 36);
    AndMask : ThirtySix;
    OrMask : ThirtySix;
    Location : ThirtySix;
    Value : ThirtySix;
    package IO is new Ada.Text_IO.Modular_IO (Num => ThirtySix);
    package ThirtySix_Map is new Ada.Containers.Indefinite_Ordered_Maps
        (Key_Type        => ThirtySix,
         Element_Type    => ThirtySix);
    Memory : ThirtySix_Map.Map;

    Sum: Unsigned_64 := 0;
begin
    Open (F, In_File, File_Name);
    while not End_Of_File (F) loop
        Get(F, LinePrefix);
        if (LinePrefix = "mask") then
            Put_Line (LinePrefix);
            Get(F, LinePostfix);
            Get(F, MaskString);
            AndMask := 0;
            for I in 0..35 loop
                if (MaskString(I + 1) = '1' or MaskString(I + 1) = 'X') then
                    AndMask := AndMask + ThirtySix(Shift_Left(Unsigned_64(1), 35-I));
                end if;
            end loop;
            OrMask := 0;
            for I in 0..35 loop
                if (MaskString(I + 1) = '1') then
                    OrMask := OrMask + ThirtySix(Shift_Left(Unsigned_64(1), 35-I));
                end if;
            end loop;
        else
            IO.Get(F, Location);
            Put_Line (ThirtySix'Image(Location));
            Get(F, Bracket);
            Get(F, LinePostfix);
            IO.Get(F, Value);

            Value := Value and AndMask;
            Value := Value or OrMask;

            Memory.Include(Location, Value);
        end if;
    end loop;
    for C in Memory.Iterate loop
      Put_Line (ThirtySix'Image (Memory (C)));
      Sum := Sum + Unsigned_64(ThirtySix'(Memory(C)));
    end loop;
    Put_Line(Unsigned_64'Image(Sum));
    Close (F);
end;