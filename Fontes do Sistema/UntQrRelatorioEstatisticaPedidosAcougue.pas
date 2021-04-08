unit UntQrRelatorioEstatisticaPedidosAcougue;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls;

type
  TFrmQrRelatorioEstatisticaPedidosAcougue = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRShape1: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQrRelatorioEstatisticaPedidosAcougue: TFrmQrRelatorioEstatisticaPedidosAcougue;

implementation

uses UntRelatorioEstatisticaPedidosAcougue;

{$R *.DFM}

end.
