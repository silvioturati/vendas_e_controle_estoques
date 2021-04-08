unit UntQrRelatorioSinteticoContasReceberAcougue;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, Qrctrls;

type
  TFrmQrRelatorioSinteticoContasReceberAcougue = class(TForm)
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
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel8: TQRLabel;
    QRShape2: TQRShape;
    QRLabel9: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQrRelatorioSinteticoContasReceberAcougue: TFrmQrRelatorioSinteticoContasReceberAcougue;

implementation

uses UntRelatorioSinteticoContasReceberAcougue;

{$R *.DFM}


end.
