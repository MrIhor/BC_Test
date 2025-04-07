pageextension 50001 EmployeeCardExt extends "Employee Card"
{
    layout
    {
        addfirst("Address & Contact")
        {
            field(Location; Rec.Location)
            {
                Caption = 'Location';
                ApplicationArea = All;
            }
        }
    }
}