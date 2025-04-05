tableextension 5200 EmployeeLocationExt extends Employee
{
    fields
    {
        field(141; "Location"; Text[200])
        {
            Caption = 'Location';
            TableRelation = Location.Name;

            ValidateTableRelation = true;

            trigger OnLookup()
            begin
                if RecLocation.FindSet() then
                    if Page.RunModal(0, RecLocation) = Action::LookupOK then
                        "Location" := RecLocation.Name;
            end;

            trigger OnValidate();
            begin
                if Rec.Location <> '' then begin
                    if not RecLocation.Get(Rec.Location) then
                        Error('Міста з назвою %1 не існує в таблиці Location', Rec.Location);
                end;
            end;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        RecLocation: Record Location;
}