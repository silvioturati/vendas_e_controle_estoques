unit UntAlteraDevolucaoBoi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons;

type
  TFrmAlteraDevolucaoBoi = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    BtnImprimir: TBitBtn;
    BtnConfirmar: TBitBtn;
    BtnCancelar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure Impressao_Vale;
    procedure BtnConfirmarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAlteraDevolucaoBoi: TFrmAlteraDevolucaoBoi;

implementation

uses UntDataModulo, UntConf_Venda_Fra, UntAlteraDevolucaoAcougue;

{$R *.DFM}

//NÃO ALTERA NADA NESTE FORM, O MÁXIMO É O ENDEREÇO DE ENTREGA E REIMPRIME O VALE

procedure TFrmAlteraDevolucaoBoi.FormShow(Sender: TObject);
begin
  Edit1.Text := DmPrincipal.TbClientes.FieldByName('Endereco').AsString;
  Edit2.Text := DmPrincipal.TbClientes.FieldByName('Bairro').AsString;
  Edit3.Text := DmPrincipal.TbClientes.FieldByName('Cidade').AsString;
end;

procedure TFrmAlteraDevolucaoBoi.BtnImprimirClick(Sender: TObject);
begin
  BtnConfirmar.Enabled := True;  // Botao de OK (Descongelado)
  Impressao_Vale();
end;

procedure TFrmAlteraDevolucaoBoi.Impressao_Vale;
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
            cCab := '|           D E V O L U C A O   D O   A C O U G U E            |';
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+==============================================================+');
    cCab :=         'Devol. Nr.: '+FrmConf_Venda_fra.FormatarNumero(FormatFloat('###,###,###',FrmAlteraDevolucaoAcougue.TbAuxDevolucaoBoi.FieldByName('Dev_Nr').AsFloat),11);
    cCab := cCab+'                     Data ..: '+FrmConf_Venda_Fra.FormatarString(FrmAlteraDevolucaoAcougue.TbAuxDevolucaoBoi.FieldByName('Data').AsString,10);
    WriteLn(Arquivo,cCab);
    cCab :=         'Nome .....: '+DmPrincipal.TbClientes.FieldByName('Fantasia').AsString;
    WriteLn(Arquivo,cCab);
    cCab :=         'Endereco .: '+FrmAlteraDevolucaoBoi.Edit1.Text;
    WriteLn(Arquivo,cCab);
    cCab :=         'Bairro ...: '+FrmAlteraDevolucaoBoi.Edit2.Text;
    WriteLn(Arquivo,cCab);
    cCab :=         ' Cidade ..: '+FrmAlteraDevolucaoBoi.Edit3.Text;
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+--------+--+------------------------------+---------+---------+');
            cCab := '|  Qtde. |Un|           Especie            |Pre. Unt.|  Total  |';
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+--------+--+------------------------------+---------+---------+');
    FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoi.First;
    While not FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoi.EOF do
    begin
      cCab   := '';
      cCab   := FrmConf_Venda_Fra.FormatarNumero(FormatFloat('###0.000',FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoiQtde.AsFloat),8);
      cCab   := cCab + ' ';
      cCab   := cCab + FrmConf_Venda_Fra.FormatarString(FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoiUnidade.AsString,2);
      cCab   := cCab + ' ';
      cCab   := cCab + FrmConf_Venda_Fra.FormatarString(Copy(FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoiDescrio.AsString,1,25),25);
      cCab   := cCab + ' ';
      cCab   := cCab + FrmConf_Venda_Fra.FormatarNumero(FormatFloat('###,##0.00',FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoiUnitario.AsFloat),10);
      cCab   := cCab + ' ';
      cCab   := cCab + FrmConf_Venda_Fra.FormatarNumero(FormatFloat('###,###,##0.00',FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoiTotal.AsFloat),14);
      cCab   := cCab + ' ';
      WriteLn(Arquivo,cCab);
      FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoi.Next;
    End;
    WriteLn(Arquivo,'----------------------------------------------------------------');
    cCab :=  '                                    Total ..: '+FrmConf_Venda_fra.FormatarNumero(FormatCurr('##,###,###,##0.00',STrToCurr(FrmConf_Venda_Fra.TiraVirgula(FrmAlteraDevolucaoAcougue.TbAuxDevolucaoBoi.FIeldByName('Total').asString))),17);
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

procedure TFrmAlteraDevolucaoBoi.BtnConfirmarClick(Sender: TObject);
begin
  FrmAlteraDevolucaoBoi.Close;
end;

procedure TFrmAlteraDevolucaoBoi.BtnCancelarClick(Sender: TObject);
begin
   FrmAlteraDevolucaoAcougue.TbAuxDevolucaoBoi.Cancel;
end;
end.
