# Preview Report Action

## Overview
This object adds an action to preview a report output in the application. It allows users to view the generated reports before finalizing or printing them, ensuring that all necessary information is accurate and complete.

## Features
- **Preview Functionality**: Users can preview the report output directly within the application.
- **User-Friendly Interface**: The action is designed to be intuitive and easy to use.
- **Customization Options**: Users can customize the preview settings to fit their needs.

## Installation
To install this object, follow these steps:
1. Download the object file.
2. Place it in the appropriate directory within your application.
3. Ensure that all dependencies are met.

## Usage
To use the preview report action, follow these steps:
1. Navigate to the posted sales invoice.
2. Select the record you wish to preview.
3. Click on the "Preview" button to view the report output.

## File.ViewFromStream Method

### Overview
The `File.ViewFromStream` method opens a file from the server on the client computer in preview mode. The client computer is defined as the machine running the browser accessing the web client.

### Syntax
```al
[Ok := ] File.ViewFromStream(InStream: InStream, FileName: Text [, AllowDownloadAndPrint: Boolean])
```

### Parameters
- **InStream**  
  Type: `InStream`  
  An InStream that you want to use to send the data in a file on the Business Central server to be previewed on the client computer.

- **FileName**  
  Type: `Text`  
  The name of the file that will be viewed in the client.

- **[Optional] AllowDownloadAndPrint**  
  Type: `Boolean`  
  Whether to allow the user to download or print the file from the client or not.

### Return Value
- **[Optional] Ok**  
  Type: `Boolean`  
  Returns `true` if the viewer was opened on the client; otherwise `false`. If you omit this optional return value and the operation does not execute successfully, a runtime error will occur.

### Remarks
This method works only in Business Central online environments and supports PDF files. For on-premise environments, you can use `File.View` but don't use it.


## Contributing
If you would like to contribute to this project, please fork the repository and submit a pull request. We welcome contributions that improve the functionality and usability of the preview report action.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.

## Contact
For any inquiries or support, please contact the project maintainer at [info@edhateconsulting.com].
For any inquiries or support, please contact the [Project Maintainer](mailto:info@edhateconsulting.com?subject=Preview%Report&body=Hi%20Saurav,%0ARequire%20Support%20for%20following%20issues:%0A)