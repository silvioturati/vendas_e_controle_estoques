unit UntConf_Itens_DevFra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  TFrmConf_Itens_DevFra = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    RadioGroup1: TRadioGroup;
    DBEdit4: TDBEdit;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    Edit1: TEdit;
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBEdit4Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConf_Itens_DevFra: TFrmConf_Itens_DevFra;

implementation

uses UntDataModulo, UntConfirmaDevolucaoAvicola, UntDevolucaoAvicola;

{$R *.DFM}


procedure TFrmConf_Itens_DevFra.RadioGroup1Click(Sender: TObject);
begin
  Case RadioGroup1.ItemIndex of
    0: Edit1.Text := DmPrincipal.TbProdutosFra.FieldByName('Valor_BA').AsString;
    1: Edit1.Text := DmPrincipal.TbProdutosFra.FieldByName('Valor_AP').AsString;
    2: Edit1.Text := DmPrincipal.TbProdutosFra.FieldByName('Valor_AV').AsString;
    3: Edit1.Text := DmPrincipal.TbProdutosFra.FieldByName('Valor_TR').AsString;
  end;
end;

procedure TFrmConf_Itens_DevFra.BitBtn1Click(Sender: TObject);
Var nTotal: Currency;
begin
  DmPrincipal.TbMov_DevFra.FieldByName('Unitario').AsFloat := StrToFloat(Edit1.Text);
  DmPrincipal.TbMov_DevFra.Post;
  DmPrincipal.TbMov_DevFra.First;
  nTotal := 0;
  While Not DmPrincipal.TbMov_DevFra.EOF do
  Begin
    nTotal := nTotal + (DmPrincipal.TbMov_DevFra.FieldByName('Qtde').AsCurrency * DmPrincipal.TbMov_DevFra.FieldByName('Unitario').AsCurrency);
    DmPrincipal.TbMov_DevFra.Next;
  End;
  FrmDevolucaoAvicola.Edit2.Text := FormatCurr('###,###,###,##0.00',nTotal);
end;

procedure TFrmConf_Itens_DevFra.BitBtn2Click(Sender: TObject);
begin
  DmPrincipal.TbMov_DevFra.Cancel;
end;

procedure TFrmConf_Itens_DevFra.FormShow(Sender: TObject);
begin
  Edit2.Text := '0';
  DbEdit4.Field.Value := 0;
  Edit1.Text := DmPrincipal.TbProdutosFra.FieldByName('Valor_BA').AsString;
end;

procedure TFrmConf_Itens_DevFra.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Close;
  FrmDevolucaoAvicola.CompletingComboBox1.DroppedDown := True;
end;

procedure TFrmConf_Itens_DevFra.DBEdit4Exit(Sender: TObject);
begin
  Edit2.Text := FormatCurr('###,###,##0.00',StrToCurr(StrToFloat(Edit1.Text) * DbEdit4.Field.Value));
end;

end.
