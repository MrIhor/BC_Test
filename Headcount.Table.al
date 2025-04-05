table 50100 Headcount
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Period"; Date)
        {
            Caption = 'Period';
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Period" <> 0D then
                    "Period" := CalcDate('<-CM>', "Period");
            end;
        }

        field(2; "Office"; Code[20])
        {
            Caption = 'Office';
            TableRelation = Location.Code;
            ValidateTableRelation = true;

            trigger OnLookup()
            begin
                if RecLocation.FindSet() then
                    if Page.RunModal(0, RecLocation) = Action::LookupOK then
                        "Office" := RecLocation.Code;
            end;

            trigger OnValidate()
            begin
                if "Office" <> '' then
                    if not RecLocation.Get("Office") then
                        Error('Офіс з кодом %1 не існує.', "Office");
            end;
        }

        field(3; "Type"; Enum "Headcount Type")
        {
            Caption = 'Type';
        }

        field(4; "Count"; Integer)
        {
            Caption = 'Count';
            MinValue = 0;
        }
    }

    keys
    {
        key(PK; "Period", "Office", "Type")
        {
            Clustered = true;
        }
    }

    var
        RecLocation: Record Location;
}

enum 50100 "Headcount Type"
{
    Extensible = true;
    value(0; "Core")
    {
        Caption = 'Core';
    }
    value(1; "Remote")
    {
        Caption = 'Remote';
    }
}