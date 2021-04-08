unit UntQRRelatorioSintesePedidosAcougue;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, Qrctrls;

type
  TFrmQRRelatorioSintesePedidosAcougue = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRShape1: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRDBText1: TQRDBText;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQRRelatorioSintesePedidosAcougue: TFrmQRRelatorioSintesePedidosAcougue;

implementation

uses UntRelatorioSintesePedidosAcougue, UntDataModulo;

{$R *.DFM}

end.
