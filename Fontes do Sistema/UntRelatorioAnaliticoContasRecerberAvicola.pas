unit UntRelatorioAnaliticoContasRecerberAvicola;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons, ExtCtrls;

type
  TFrmRelatorioAnaliticoContasRecerberAvicola = class(TForm)
    RadioGroup1: TRadioGroup;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DsReceber: TDataSource;
    TbReceber: TTable;
    DsClientes: TDataSource;
    TbClientes: TTable;
    TbReceberCodigo: TIntegerField;
    TbReceberVenda_Nr: TIntegerField;
    TbReceberD_C: TStringField;
    TbReceberData: TDateField;
    TbReceberTotal: TCurrencyField;
    TbReceberData_Pgto: TDateField;
    TbReceberVendas_Devolucao: TStringField;
    TbReceberPago: TStringField;
    procedure TbReceberCalcFields(DataSet: TDataSet);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelatorioAnaliticoContasRecerberAvicola: TFrmRelatorioAnaliticoContasRecerberAvicola;

implementation

uses UntQrListaContasReceberAnalitico;

{$R *.DFM}


procedure TFrmRelatorioAnaliticoContasRecerberAvicola.TbReceberCalcFields(
  DataSet: TDataSet);

begin
  If TbReceberD_C.Value = 'D' Then
    TbReceberVendas_Devolucao.Value := 'Devolução'
  Else
    TbReceberVendas_Devolucao.Value := 'Venda';
end;

procedure TFrmRelatorioAnaliticoContasRecerberAvicola.BitBtn2Click(Sender: TObject);
begin
  FrmQrListaContasReceberAnalitico.Quickrep1.Preview;
end;

procedure TFrmRelatorioAnaliticoContasRecerberAvicola.FormShow(Sender: TObject);
begin
  TbClientes.Active := True;
  TbReceber.Active  := True;
end;

procedure TFrmRelatorioAnaliticoContasRecerberAvicola.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  TbClientes.Active := False;
  TbReceber.Active  := False;
end;

procedure TFrmRelatorioAnaliticoContasRecerberAvicola.BitBtn3Click(Sender: TObject);
begin
  Close;
end;

end.
