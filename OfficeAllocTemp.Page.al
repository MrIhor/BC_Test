page 50102 "Office Allocation Temporary"
{
    Caption = 'Office Allocation Temporary';
    PageType = List;
    SourceTable = "Office Allocation Temporary";
    SourceTableTemporary = true;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(Input)
            {
                Caption = 'Input Values';
                field("Period"; PeriodFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Period';

                    trigger OnValidate()
                    begin
                        if PeriodFilter <> 0D then
                            PeriodFilter := CalcDate('<-CM>', PeriodFilter);
                    end;
                }

                field("Expense"; Expense)
                {
                    ApplicationArea = All;
                    Caption = 'Expense';
                    DecimalPlaces = 2 : 2;
                }
            }

            repeater(OfficeAllocation)
            {
                field("Office"; Rec.Office)
                {
                    ApplicationArea = All;
                    ToolTip = 'Офіс із таблиці Location';
                }

                field("Amount"; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Розрахунок алокаційної бази';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Calculate")
            {
                ApplicationArea = All;
                Caption = 'Calculate';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Headcount: Record Headcount;
                    TotalCoreCount: Integer;
                    OfficeCount: Dictionary of [Code[20], Integer];
                    AllocationPercentage: Decimal;
                    OfficeCode: Code[20];
                begin
                    if PeriodFilter = 0D then
                        Error('Please select a period');
                    if Expense = 0 then
                        Error('Please enter an expense amount');

                    Rec.Reset();
                    Rec.DeleteAll();

                    Headcount.SetRange("Period", PeriodFilter);
                    Headcount.SetRange("Type", Headcount.Type::Core);

                    if Headcount.FindSet() then begin
                        TotalCoreCount := 0;

                        repeat
                            if OfficeCount.ContainsKey(Headcount.Office) then
                                OfficeCount.Set(Headcount.Office, OfficeCount.Get(Headcount.Office))
                            else
                                OfficeCount.Add(Headcount.Office, Headcount.Count);
                            TotalCoreCount += Headcount.Count;
                        until Headcount.Next() = 0;

                        if TotalCoreCount = 0 then
                            Error('No Core employees found for the selected period');

                        foreach OfficeCode in OfficeCount.Keys do begin
                            TempOfficeAllocation.Init();
                            TempOfficeAllocation."Office" := OfficeCode;
                            AllocationPercentage := (OfficeCount.Get(OfficeCode) / TotalCoreCount) * 100;
                            TempOfficeAllocation."Amount" := (Expense * AllocationPercentage) / 100;
                            TempOfficeAllocation.Insert();
                        end;
                    end else
                        Message('No data found for the selected period and Core type');

                    if TempOfficeAllocation.FindSet() then
                        repeat
                            Rec.Init();
                            Rec.Office := TempOfficeAllocation.Office;
                            Rec.Amount := TempOfficeAllocation.Amount;
                            Rec.Insert();
                        until TempOfficeAllocation.Next() = 0;

                    CurrPage.Update(false);
                end;
            }
        }
    }

    var
        PeriodFilter: Date;
        Expense: Decimal;
        TempOfficeAllocation: Record "Office Allocation Temporary" temporary;
}