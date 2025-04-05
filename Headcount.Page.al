page 50100 Headcount
{
    Caption = 'Headcounts';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Headcount;

    layout
    {
        area(Content)
        {
            repeater(Headcounts)
            {
                field("Period"; Rec.Period)
                {
                    Caption = 'Period';
                    ApplicationArea = All;
                }

                field("Office"; Rec.Office)
                {
                    Caption = 'Office';
                    ApplicationArea = All;
                }

                field("Type"; Rec.Type)
                {
                    Caption = 'Type';
                    ApplicationArea = All;
                }

                field("Count"; Rec.Count)
                {
                    Caption = 'Count';
                    ApplicationArea = All;
                }
            }
        }
    }
}