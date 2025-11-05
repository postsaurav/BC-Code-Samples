codeunit 50000 "SDH Item CSV Management"
{
    procedure ExportItemRecordAsCSV()
    var
        CSVBuffer: Record "CSV Buffer" temporary;
    begin
        If Item.IsEmpty() then
            exit;
        AddItemCSVHeader(CSVBuffer);
        AddItemCSVData(CSVBuffer);
        DownloadItemCSV(CSVBuffer);
    end;

    local procedure AddItemCSVData(var CSVBuffer: Record "CSV Buffer" temporary)
    begin
        Item.SetLoadFields("No.", Description, Inventory, "Base Unit of Measure", "Vendor No.");
        Item.SetAutoCalcFields(Inventory);
        if Item.FindSet() then
            repeat
                IncreaseIndex();
                CSVBuffer.InsertEntry(Index, 1, RemoveComma(Item."No."));
                CSVBuffer.InsertEntry(Index, 2, RemoveComma(Item.Description));
                CSVBuffer.InsertEntry(Index, 3, RemoveComma(Format(Item."Inventory")));
                CSVBuffer.InsertEntry(Index, 4, RemoveComma(Item."Base Unit of Measure"));
                CSVBuffer.InsertEntry(Index, 5, RemoveComma(Item."Vendor No."));
            until Item.Next() = 0;
    end;

    local procedure AddItemCSVHeader(var CSVBuffer: Record "CSV Buffer" temporary)
    begin
        IncreaseIndex();
        CSVBuffer.InsertEntry(Index, 1, RemoveComma(Item.FieldCaption("No.")));
        CSVBuffer.InsertEntry(Index, 2, RemoveComma(Item.FieldCaption(Description)));
        CSVBuffer.InsertEntry(Index, 3, RemoveComma(Item.FieldCaption("Inventory")));
        CSVBuffer.InsertEntry(Index, 4, RemoveComma(Item.FieldCaption("Base Unit of Measure")));
        CSVBuffer.InsertEntry(Index, 5, RemoveComma(Item.FieldCaption("Vendor No.")));
    end;

    local procedure DownloadItemCSV(var CSVBuffer: Record "CSV Buffer" temporary)
    var
        TempBlob: Codeunit "Temp Blob";
        InStream: InStream;
        FileName: Text;
    begin
        FileName := 'ItemExport_' + Format(CurrentDateTime(), 0, '<Year4><Month,2><Day,2>_<Hour,2><Minute,2><Second,2>') + '.csv';
        CSVBuffer.SaveDataToBlob(TempBlob, ',');
        DownloadFromStream(TempBlob.CreateInStream(), 'Exporting Items', '', '', FileName);
    end;

    local procedure IncreaseIndex()
    begin
        Index := Index + 1;
    end;

    local procedure RemoveComma(inputText: Text) returntext: Text
    begin
        returntext := DelChr(inputText, '=', ',');
    end;

    var
        Item: Record Item;
        Index: Integer;
}