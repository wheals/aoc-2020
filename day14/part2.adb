with Ada.Text_IO; use Ada.Text_IO;
with Interfaces; use Interfaces;
with Ada.Containers.Indefinite_Ordered_Maps;
with Ada.Containers.Vectors;
use Ada.Containers;

procedure Part2 is
    F         : File_Type;
    File_Name : constant String := "input.txt";

    LinePrefix : String (1 .. 4);
    LinePostfix : String (1 .. 3);
    Bracket: Character;

    type ThirtySix is mod 2 ** 36;
    MaskString : String (1 .. 36);
    OrMask : ThirtySix;
    Location : ThirtySix;
    Value : ThirtySix;
    package IO is new Ada.Text_IO.Modular_IO (Num => ThirtySix);
    package ThirtySix_Map is new Ada.Containers.Indefinite_Ordered_Maps
        (Key_Type        => ThirtySix,
         Element_Type    => ThirtySix);
    Memory : ThirtySix_Map.Map;

    package Index_Vectors is new Ada.Containers.Vectors
        (Index_Type => Natural,
         Element_Type => Integer);
    Xs : Index_Vectors.Vector;
    procedure Update_Memory (Index: Integer; Updated_Location: ThirtySix) is
    begin
        if (Index < Integer(Xs.Length - 1)) then
            Update_Memory(Index + 1, Updated_Location or ThirtySix(Shift_Left(Unsigned_64(1), 35-Xs(Index))));
            Update_Memory(Index + 1, Updated_Location and not ThirtySix(Shift_Left(Unsigned_64(1), 35-Xs(Index))));
        else
            Put_Line(ThirtySix'Image(Updated_Location or ThirtySix(Shift_Left(Unsigned_64(1), 35-Xs(Index)))));
            Put_Line(ThirtySix'Image(Updated_Location and not ThirtySix(Shift_Left(Unsigned_64(1), 35-Xs(Index)))));
            Memory.Include(Updated_Location or ThirtySix(Shift_Left(Unsigned_64(1), 35-Xs(Index))), Value);
            Memory.Include(Updated_Location and not ThirtySix(Shift_Left(Unsigned_64(1), 35-Xs(Index))), Value);
        end if;
    end Update_Memory;

    Sum: Unsigned_64 := 0;
begin
    Open (F, In_File, File_Name);
    while not End_Of_File (F) loop
        Get(F, LinePrefix);
        if (LinePrefix = "mask") then
            Get(F, LinePostfix);
            Get(F, MaskString);
            OrMask := 0;
            Index_Vectors.Clear(Xs);
            for I in 0..35 loop
                if (MaskString(I + 1) = '1') then
                    OrMask := OrMask + ThirtySix(Shift_Left(Unsigned_64(1), 35-I));
                elsif (MaskString(I + 1) = 'X') then
                   Xs.Append(I);
                end if;
            end loop;
        else
            IO.Get(F, Location);
            Get(F, Bracket);
            Get(F, LinePostfix);
            IO.Get(F, Value);

            Location := Location or OrMask;
            Update_Memory(0, Location);
        end if;
    end loop;
    for C in Memory.Iterate loop
      Put_Line (ThirtySix'Image (Memory (C)));
      Sum := Sum + Unsigned_64(ThirtySix'(Memory(C)));
    end loop;
    Put_Line(Unsigned_64'Image(Sum));
    Close (F);
end Part2;