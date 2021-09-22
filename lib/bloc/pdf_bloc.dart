import 'dart:convert';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_clients_by_anduril/helpers/utils.dart';
import 'package:my_clients_by_anduril/models/client_model.dart';
import 'package:my_clients_by_anduril/models/user_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfBloc extends BlocBase {

  Future<List<int>> _readData(String name) async {
    final ByteData data = await rootBundle.load('assets/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<void> conformancePDF({ClientModel clientModel, UserModel userModel}) async {
    PdfDocument document;
    document = PdfDocument(conformanceLevel: PdfConformanceLevel.a3b);
    String text =
        'Adventure Works Cycles, the fictitious company on';
    document.attachments.add(PdfAttachment(
        'AdventureCycle.txt', utf8.encode(text),
        description: 'Adventure Works Cycles', mimeType: 'application/txt'));
    final PdfPage page = document.pages.add();
    final Size pageSize = page.getClientSize();
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219, 255)));
    List<int> fontData = await _readData('Roboto-Regular.ttf');
    PdfFont contentFont = PdfTrueTypeFont(fontData, 9);
    PdfFont headerFont = PdfTrueTypeFont(fontData, 30);
    PdfFont footerFont = PdfTrueTypeFont(fontData, 18);

    final PdfGrid grid = _getGrid(contentFont, clientModel);
    //Draw the header section by creating text element
    final PdfLayoutResult result =
    _drawHeader(page, pageSize, grid, contentFont, headerFont, footerFont, clientModel);
    //Draw grid
    _drawGrid(page, grid, result, contentFont, clientModel);
    //Add invoice footer
    _drawFooter(page, pageSize, contentFont, userModel);
    //Save and dispose the document.
    final List<int> bytes = document.save();
    document.dispose();
    //Get external storage directory
    Directory directory = await getExternalStorageDirectory();
    //Get directory path
    String path = directory.path;
    //Create an empty file to write PDF data
    File file = File('$path/Output.pdf');
    //Write PDF data
    await file.writeAsBytes(bytes, flush: true);
    //Open the PDF document in mobile
    OpenFile.open('$path/Output.pdf');
  }

  PdfGrid _getGrid(PdfFont contentFont, ClientModel clientModel) {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 5);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'Visita';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Empresa';
    headerRow.cells[2].value = 'Responsável';
    headerRow.cells[3].value = 'Telefone';
    _addProducts(clientModel, grid);
    final PdfPen whitePen = PdfPen(PdfColor.empty, width: 0.5);
    PdfBorders borders = PdfBorders();
    borders.all = PdfPen(PdfColor(142, 179, 219), width: 0.5);
    grid.rows.applyStyle(PdfGridCellStyle(borders: borders));
    grid.columns[1].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      headerRow.cells[i].style.borders.all = whitePen;
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      if (i % 2 == 0) {
        row.style.backgroundBrush = PdfSolidBrush(PdfColor(217, 226, 243));
      }
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    //Set font
    grid.style.font = contentFont;
    return grid;
  }

  //Create and row for the grid.
  void _addProducts(ClientModel clientModel, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    String date = formattedDate(clientModel.createdTime);
    row.cells[0].value = date;
    row.cells[1].value = clientModel.company;
    row.cells[2].value = clientModel.name;
    row.cells[3].value = clientModel.phone;
  }

  //Draws the invoice header
  PdfLayoutResult _drawHeader(PdfPage page, Size pageSize, PdfGrid grid,
      PdfFont contentFont, PdfFont headerFont, PdfFont footerFont, ClientModel clientModel) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215, 255)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string
    page.graphics.drawString('Info Cliente', headerFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(65, 104, 205)));
    page.graphics.drawString(clientModel.document, contentFont,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));
    //Draw string
    page.graphics.drawString('CNPJ', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('pt-br');
    final String invoiceNumber = 'Chave da Empresa: ${clientModel.companyKey}\r\n\r\nVisita Agendada: ' +
        format.format(clientModel.nextVisit);
    final Size contentSize = contentFont.measureString(invoiceNumber);
    String address =
        'Responsável: ${clientModel.name}, \r\n\r\nEndereço: \r\n\r\nBrasil, ${clientModel.addressModel.city}, ${clientModel.addressModel.unit}, \r\n\r\n ${clientModel.addressModel.place} - ${clientModel.number}, ${clientModel.addressModel.district}, \r\n\r\n${clientModel.addressModel.postalCode}';
    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));
    return PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120));
  }

  void _drawGrid(
      PdfPage page, PdfGrid grid, PdfLayoutResult result, PdfFont contentFont, ClientModel clientModel) {
    Rect totalPriceCellBounds;
    Rect quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0));
    page.graphics.drawString('${clientModel.observations}', contentFont,
        bounds: Rect.fromLTWH(
            quantityCellBounds.left,
            result.bounds.bottom + 10,
            quantityCellBounds.width,
            quantityCellBounds.height));
  }

  void _drawFooter(PdfPage page, Size pageSize, PdfFont contentFont, UserModel userModel) {
    final PdfPen linePen =
    PdfPen(PdfColor(142, 170, 219, 255), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));
    String footerContent =
        'Funcionário Responsável: ${userModel.name}.\r\n\r\nContato: ${userModel.email}\r\n\r\nAny Questions? andurilsoftware@gmail.com';
    //Added 30 as a margin for the layout
    page.graphics.drawString(footerContent, contentFont,
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }
}