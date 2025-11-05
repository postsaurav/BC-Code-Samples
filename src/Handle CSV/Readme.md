# Handle CSV: Export Item List to CSV

This sample adds a one-click action to the standard Item List that exports core item fields to a comma-separated file (CSV). It demonstrates how to:

- Add a promoted action to a base page via a page extension
- Build CSV content efficiently using the CSV Buffer table
- Stream a file to the user with a timestamped filename

## Files

- `SDHItemList.Pageext.al` — Page extension that adds the action "Export as CSV" to the Item List (Reports group and promoted).
- `SDHItemCSVManagement.codeunit.al` — Codeunit that assembles the CSV (header + rows) and downloads the file.

## How it works

1. The page action `Export as CSV` calls `SDH Item CSV Management` → `ExportItemRecordAsCSV()`.
2. The codeunit:
   - Exits early if the Item table is empty.
   - Adds a header row via `AddItemCSVHeader()` using field captions.
   - Iterates items with `FindSet()` and `SetLoadFields()` for performance, and uses `SetAutoCalcFields(Inventory)` to compute inventory on read.
   - Appends values for these columns, removing any commas to keep CSV structure clean:
     - No.
     - Description
     - Inventory
     - Base Unit of Measure
     - Vendor No.
   - Saves the CSV content to a Temp Blob using `CSV Buffer.SaveDataToBlob(',',)`.
   - Downloads the file using `DownloadFromStream()` with a name like `ItemExport_YYYYMMDD_HHMMSS.csv`.

## Usage

1. Open the Item List in Business Central.
2. Choose Reports → "Export as CSV" (also available as a promoted action).
3. A CSV file will download to your machine.

## Notes

- The helper `RemoveComma()` strips commas from text fields to avoid breaking the CSV format.
- This sample exports all items. It does not inherit page filters; you can extend it to take a filtered record as input if needed.
- Uses only standard platform types: `CSV Buffer` record and `Temp Blob` codeunit.

## Possible extensions

- Respect the current page filters by passing a `Record Item` with filters to the codeunit.
- Add more columns (e.g., Item Category, Posting Group) or localize captions.
- Allow delimiter selection (e.g., semicolon) or export to TSV.

## Contributing
If you would like to contribute to this project, please fork the repository and submit a pull request. We welcome contributions that improve the functionality and usability of the preview report action.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.

## Contact
For any inquiries or support, please contact the [Project Maintainer](mailto:info@edhateconsulting.com?subject=Handle%CSV&body=Hi%20Saurav,%0ARequire%20Support%20for%20following%20issues:%0A)
