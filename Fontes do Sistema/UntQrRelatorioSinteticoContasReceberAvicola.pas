unit UntQrRelatorioSinteticoContasReceberAvicola;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls;

type
  TFrmQrRelatorioSinteticoContasReceberAvicola = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRShape1: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel4: TQRLabel;
    QRSysData2: TQRSysData;
    QRSysData1: TQRSysData;
    QRLabel3: TQRLabel;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRBand3: TQRBand;
    QRLabel8: TQRLabel;
    QRShape2: TQRShape;
    QRLabel9: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQrRelatorioSinteticoContasReceberAvicola: TFrmQrRelatorioSinteticoContasReceberAvicola;

implementation

uses UntRelatorioSinteticoContasReceberAvicola;

{$R *.DFM}



end.
