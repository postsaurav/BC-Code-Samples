pageextension 50001 "SDH Item List" extends "Item List"
{
    actions
    {
        addlast(Reports)
        {
            action(ExportAsCSV)
            {
                Caption = 'Export as CSV';
                Image = Export;
                ApplicationArea = All;
                ToolTip = 'Export the item list as a CSV file.';
                trigger OnAction()
                var
                    SDHItemCSVManagement: Codeunit "SDH Item CSV Management";
                begin
                    SDHItemCSVManagement.ExportItemRecordAsCSV();
                end;
            }
        }
        addlast(Category_Report)
        {
            actionref(ExportAsCSV_Promoted; ExportAsCSV) { }
        }
    }
}
