unit UntAlteraDevolucaoFra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls, Buttons, Mask;

type
  TFrmAlteraDevolucaoFra = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    BtnConfirmar: TBitBtn;
    BtnCancelar: TBitBtn;
    BtnImprimir: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    procedure FormShow(Sender: TObject);
    procedure BtnConfirmarClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    function TiraVirgula(cValue: String):String;
    procedure Impressao_Vale;
    procedure BtnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAlteraDevolucaoFra: TFrmAlteraDevolucaoFra;

implementation

uses UntDataModulo, UntAlteraDevolucaoAvicola, UntAlteraPedidoAvicola,
  UntConf_Venda_Fra, UntAlteraPedidoVendaFra;

{$R *.DFM}

procedure TFrmAlteraDevolucaoFra.FormShow(Sender: TObject);
begin
  Edit1.Text := DmPrincipal.TbClientes.FieldByName('Endereco').AsString;
  Edit2.Text := DmPrincipal.TbClientes.FieldByName('Bairro').AsString;
  Edit3.Text := DmPrincipal.TbClientes.FieldByName('Cidade').AsString;
end;

procedure TFrmAlteraDevolucaoFra.BtnConfirmarClick(Sender: TObject);
begin
  FrmAlteraDevolucaoFra.Close;
end;

procedure TFrmAlteraDevolucaoFra.BtnImprimirClick(Sender: TObject);
begin
  BtnConfirmar.Enabled := True;  // Botao de OK (Descongelado)
  Impressao_Vale();
end;

procedure TFrmAlteraDevolucaoFra.Impressao_Vale;
Var Arquivo: TextFile;
    cCab   : String;
    nI     : Word;
begin
  Screen.Cursor := crHourGlass;
  AssignFile(Arquivo,'\LPT1');
  Rewrite(Arquivo);
  For nI := 1 to 3 do
  Begin
    WriteLn(Arquivo,'+==============================================================+');
            cCab := '|           D E V O L U C A O   D A   A V I C O L A            |';
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+==============================================================+');
    cCab :=         'Devol. Nr.: '+FrmConf_Venda_fra.FormatarNumero(FormatFloat('###,###,###',FrmAlteraDevolucaoAvicola.TbAuxDevolucaoFra.FieldByName('Dev_Nr').AsFloat),11);
    cCab := cCab+'                     Data ..: '+FrmConf_Venda_Fra.FormatarString(FrmAlteraDevolucaoAvicola.TbAuxDevolucaoFra.FieldByName('Data').AsString,10);
    WriteLn(Arquivo,cCab);
    cCab :=         'Nome .....: '+DmPrincipal.TbClientes.FieldByName('Fantasia').AsString;
    WriteLn(Arquivo,cCab);
    cCab :=         'Endereco .: '+FrmAlteraDevolucaoFra.Edit1.Text;
    WriteLn(Arquivo,cCab);
    cCab :=         'Bairro ...: '+FrmAlteraDevolucaoFra.Edit2.Text;
    WriteLn(Arquivo,cCab);
    cCab :=         ' Cidade ..: '+FrmAlteraDevolucaoFra.Edit3.Text;
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+--------+--+------------------------------+---------+---------+');
            cCab := '|  Qtde. |Un|           Especie            |Pre. Unt.|  Total  |';
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+--------+--+------------------------------+---------+---------+');
    FrmAlteraDevolucaoAvicola.TbAuxDev_MovFra.First;
    While not FrmAlteraDevolucaoAvicola.TbAuxDev_MovFra.EOF do
    begin
      cCab   := '';
      cCab   := FrmConf_Venda_Fra.FormatarNumero(FormatFloat('###0.000',FrmAlteraDevolucaoAvicola.TbAuxDev_MovFraQtde.AsFloat),8);
      cCab   := cCab + ' ';
      cCab   := cCab + FrmConf_Venda_Fra.FormatarString(FrmAlteraDevolucaoAvicola.TbAuxDev_MovFraUnidade.AsString,2);
      cCab   := cCab + ' ';
      cCab   := cCab + FrmConf_Venda_Fra.FormatarString(Copy(FrmAlteraDevolucaoAvicola.TbAuxDev_MovFraDescrio.AsString,1,25),25);
      cCab   := cCab + ' ';
      cCab   := cCab + FrmConf_Venda_Fra.FormatarNumero(FormatFloat('###,##0.00',FrmAlteraDevolucaoAvicola.TbAuxDev_MovFraUnitario.AsFloat),10);
      cCab   := cCab + ' ';
      cCab   := cCab + FrmConf_Venda_Fra.FormatarNumero(FormatFloat('###,###,##0.00',FrmAlteraDevolucaoAvicola.TbAuxDev_MovFraTotal.AsFloat),14);
      cCab   := cCab + ' ';
      WriteLn(Arquivo,cCab);
      FrmAlteraDevolucaoAvicola.TbAuxDev_MovFra.Next;
    End;
    WriteLn(Arquivo,'----------------------------------------------------------------');
    cCab :=  '                                    Total ..: '+FrmConf_Venda_fra.FormatarNumero(FormatCurr('##,###,###,##0.00',STrToCurr(FrmConf_Venda_Fra.TiraVirgula(FrmAlteraDevolucaoAvicola.TbAuxDevolucaoFra.FIeldByName('Total').asString))),17);
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');

    WriteLn(Arquivo,'-------------------------        -------------------------------');
           cCab :=  '    - MOTORISTA -                         - ASSINATURA -        ';
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
  End;
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  CloseFile(Arquivo);
  Screen.Cursor := crDefault;
End;

function TFrmAlteraDevolucaoFra.TiraVirgula(cValue: String):String;
Var cValor: String;
    nI: Integer;
begin
  cValor := '';
  For nI := 1 to Length(cValue) do
  Begin
    If Copy(cValue,nI,1) <> '.' Then
      cValor := cValor + Copy(cValue,nI,1);
  End;
  Result := cValor;
End;

procedure TFrmAlteraDevolucaoFra.BtnCancelarClick(Sender: TObject);
begin
   FrmAlteraDevolucaoAvicola.TbAuxDevolucaoFra.Cancel;
end;

end.
