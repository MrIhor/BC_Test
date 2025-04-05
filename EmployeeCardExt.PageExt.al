pageextension 5200 EmployeeCardExt extends "Employee Card"
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