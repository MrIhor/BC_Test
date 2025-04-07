tableextension 50001 EmployeeLocationExt extends Employee
{
    fields
    {
        field(50141; "Location"; Text[200])
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
                    RecLocation.SetRange(Name, Rec.Location);
                    if not RecLocation.FindFirst() then
                        Error('Міста з назвою %1 не існує в таблиці Location', Rec.Location);
                end;
            end;
        }
    }

    var
        RecLocation: Record Location;
}