unit UnrConfirmaDevolucaoAvicola;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons;

type
  TFrmConfirmaDevolucaoAvicola = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label3: TLabel;
    Label10: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Impressao_Vale;
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConfirmaDevolucaoAvicola: TFrmConfirmaDevolucaoAvicola;

implementation

uses UntDataModulo, UntDevolucaoAvicola, UntConf_Venda_Fra;

{$R *.DFM}


procedure TFrmConfirmaDevolucaoAvicola.FormShow(Sender: TObject);
begin
  Edit3.Text := DmPrincipal.TbClientes.FieldByName('Endereco').AsString;
  Edit4.Text := DmPrincipal.TbClientes.FieldByName('Bairro').AsString;
  Edit5.Text := DmPrincipal.TbClientes.FieldByName('Cidade').AsString;
end;

procedure TFrmConfirmaDevolucaoAvicola.BitBtn3Click(Sender: TObject);
Var nValor: Currency;
begin
  nValor := StrToCurr(FrmConf_Venda_Fra.TiraVirgula(FrmDevolucaoAvicola.Edit2.Text));
  DmPrincipal.TbDevolucaoFra.Edit;
  DmPrincipal.TbDevolucaoFra.FieldByName('Total').AsCurrency  := nValor;
  DmPrincipal.TbDevolucaoFra.Post;
  DmPrincipal.TbReceberFra.Insert;
  DmPrincipal.TbReceberFra.FieldByName('D_C').AsString        := 'D'; // (D) Devolucao de mercadorias
  DmPrincipal.TbReceberFra.FieldByName('Codigo').AsInteger    := DmPrincipal.TbDevolucaoFra.FieldByName('Codigo').AsInteger;
  DmPrincipal.TbReceberFra.FieldByName('Venda_nr').AsInteger  := DmPrincipal.TbDevolucaoFra.FieldByName('Dev_Nr').AsInteger;
  DmPrincipal.TbReceberFra.FieldByName('Data').AsDateTime     := DmPrincipal.TbDevolucaoFra.FieldByName('Data').AsDateTime;
  DmPrincipal.TbReceberFra.FieldByName('Total').AsCurrency    := (nValor * -1); // Devera ficar negativo pois como eh devolucao, devera diminur no Contas a Receber
  DmPrincipal.TbReceberFra.Post;
  BitBtn3.Enabled := False;
  FrmDevolucaoAvicola.Gera_Novo_Mov;
  FrmDevolucaoAvicola.DBRichEdit1.Visible := False;
end;

procedure TFrmConfirmaDevolucaoAvicola.BitBtn1Click(Sender: TObject);
begin
  Impressao_Vale();
end;

procedure TFrmConfirmaDevolucaoAvicola.Impressao_Vale;
Var Arquivo: TextFile;
    cCab   : String;
    nI     : Word;
begin
  Screen.Cursor := crHourGlass;
  AssignFile(Arquivo,'\LPT1');
  Rewrite(Arquivo);
  For nI := 1 to 3 do
  Begin
    WriteLn(Arquivo,'+=============================================================+');
            cCab := '|       D E V O L U C A O    D E    M E R C A D O R I A S       |';
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+=============================================================+');
    cCab := 'Devolucao .: '+frmConf_Venda_Fra.FormatarNumero(FormatFloat('###,###,###',DmPrincipal.TbDevolucaoFra.FieldByName('Dev_Nr').AsFloat),11);
    cCab := cCab+'               Data ..: '+frmConf_Venda_Fra.FormatarString(DmPrincipal.TbDevolucaoFra.FieldByName('Data').AsString,10);
    WriteLn(Arquivo,cCab);
    cCab := 'Nome ......: '+DmPrincipal.TbClientes.FieldByName('Fantasia').AsString;
    WriteLn(Arquivo,cCab);
    cCab := 'Endereco ..: '+FrmConfirmaDevolucaoAvicola.Edit3.Text;
    WriteLn(Arquivo,cCab);
    cCab := 'Bairro ....: '+frmConf_Venda_Fra.FormatarString(FrmConfirmaDevolucaoAvicola.Edit4.Text,25);
    cCab := cCab + ' Cidade : '+frmConf_Venda_Fra.FormatarString(FrmConfirmaDevolucaoAvicola.Edit5.Text,25);
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+-------+--+-------------------------+----------+-------------+');
            cCab := '| Qtde. |Un|           Especie       |Preco Unt.|    Total     |';
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+-------+--+-------------------------+----------+-------------+');

    DmPrincipal.TbMov_DevFra.First;
    While not DmPrincipal.TbMov_DevFra.EOF do
    begin
      cCab   := '';
      cCab   := frmConf_Venda_Fra.FormatarNumero(FormatFloat('###0.000',DmPrincipal.TbMov_DevFra.FieldByName('Qtde').AsFloat),8);
      cCab   := cCab + ' ';
      cCab   := cCab + frmConf_Venda_Fra.FormatarString(DmPrincipal.TbMov_DevFra.FieldByName('Unidade').AsString,2);
      cCab   := cCab + ' ';
      cCab   := cCab + frmConf_Venda_Fra.FormatarString(Copy(DmPrincipal.TbMov_DevFra.FieldByName('Descricao').AsString,1,25),25);
      cCab   := cCab + ' ';
      cCab   := cCab + frmConf_Venda_Fra.FormatarNumero(FormatFloat('###,##0.00',DmPrincipal.TbMov_DevFra.FieldByName('Unitario').AsFloat),10);
      cCab   := cCab + ' ';
      cCab   := cCab + frmConf_Venda_Fra.FormatarNumero(FormatFloat('###,###,##0.00',DmPrincipal.TbMov_DevFra.FieldByName('Total').AsFloat),14);
      cCab   := cCab + ' ';
      WriteLn(Arquivo,cCab);
      DmPrincipal.TbMov_DevFra.Next;
    End;
    WriteLn(Arquivo,'--------------------------------------------------------------');
    cCab :=  '                                    Total ..: '+frmConf_Venda_Fra.FormatarNumero(FormatCurr('##,###,###,##0.00',STrToCurr(FrmConf_Venda_Fra.TiraVirgula(FrmDevolucaoAvicola.Edit2.Text))),17);
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'-------------------------        -----------------------------');
           cCab :=  '    - MOTORISTA -                         - ASSINATURA -        ';
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
  End;
  CloseFile(Arquivo);
  Screen.Cursor := crDefault;
End;

procedure TFrmConfirmaDevolucaoAvicola.BitBtn2Click(Sender: TObject);
begin
  BitBtn3.Enabled := True;
  FrmConfirmaDevolucaoAvicola.Close;
end;

procedure TFrmConfirmaDevolucaoAvicola.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #27 then
    close;
end;

end.
