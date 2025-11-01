pageextension 50000 "SDH Posted Sales Invoice" extends "Posted Sales Invoice"
{

    actions
    {
        addafter(Print)
        {
            action(Preview)
            {
                ApplicationArea = All;
                Caption = 'Preview';
                Image = Report;
                ToolTip = 'Preview the posted sales invoice.';
                trigger OnAction()
                var
                    SalesInvHeaderRecord: Record "Sales Invoice Header";
                    DummyReportSelections: Record "Report Selections";
                    ReportOutStream: OutStream;
                    ReportInstream: InStream;
                    TempBlob: Codeunit "Temp Blob";
                begin
                    SalesInvHeaderRecord := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeaderRecord);

                    TempBlob.CreateInStream(ReportInstream);
                    TempBlob.CreateOutStream(ReportOutStream);

                    DummyReportSelections.SetRange(Usage, DummyReportSelections.Usage::"S.Invoice");
                    if DummyReportSelections.FindFirst() then
                        if Report.SaveAs(DummyReportSelections."Report ID", '', ReportFormat::Pdf, ReportOutStream, SalesInvHeaderRecord) then
                            if not File.ViewFromStream(ReportInstream, 'Posted Sales Invoice Preview.pdf', false) then
                                Error('Unable to open the preview on the client.');
                end;
            }
        }

        addafter(Print_Promoted)
        {
            actionref(Preview_Promoted; Preview) { }
        }
    }
}