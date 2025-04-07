table 50102 "Office Allocation Temporary"
{
    Caption = 'Office Allocataion';
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(1; "Office"; Code[20])
        {
            Caption = 'Office';
            TableRelation = Location.Code;
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                Location: Record Location;
            begin
                if "Office" <> '' then
                    if not Location.Get("Office") then
                        Error('Офіс з кодом %1 не існує.', "Office");
            end;
        }

        field(2; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DecimalPlaces = 2 : 2;
        }
    }

    keys
    {
        key(PK; "Office")
        {
            Clustered = true;
        }
    }
}