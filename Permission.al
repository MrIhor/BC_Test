permissionset 50100 "Headcount"
{
    Caption = 'Headcount permissions';
    Assignable = true;
    Access = Public;
    Permissions = tabledata Headcount = RIMD,
                  page Headcount = X;
}

permissionset 50101 "Location Read Only"
{
    Caption = 'Read location';
    Access = Public;
    Permissions = tabledata Location = RI;
}

permissionset 50103 "Employee Location"
{
    Caption = 'Read/insert location';
    Access = Public;
    Assignable = true;
    IncludedPermissionSets = "Location Read Only";
    Permissions =
        page "Employee Card" = X;
}

permissionset 50102 "Office Allocation"
{
    Caption = 'Office Allocation permissions';
    Assignable = true;
    Access = Public;
    Permissions =
        tabledata "Office Allocation Temporary" = RD;
}