unit UntQRRelatorioSinteseDevolucaoAvicola;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls;

type
  TFrmQRRelatorioSinteseDevolucaoAvicola = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRBand2: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRBand3: TQRBand;
    QRLabel13: TQRLabel;
    QRLabel15: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel14: TQRLabel;
    QRDBText5: TQRDBText;
    QRShape1: TQRShape;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQRRelatorioSinteseDevolucaoAvicola: TFrmQRRelatorioSinteseDevolucaoAvicola;

implementation

uses UntDataModulo, UntRelatorioSinteseDevolucaoAvicola;

{$R *.DFM}

end.
