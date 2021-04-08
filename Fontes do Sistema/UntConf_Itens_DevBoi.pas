unit UntConf_Itens_DevBoi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  TFrmConf_Itens_DevBoi = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    RadioGroup1: TRadioGroup;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit4: TDBEdit;
    Edit1: TEdit;
    Bevel1: TBevel;
    Edit2: TEdit;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RadioGroup1Click(Sender: TObject);
    procedure DBEdit4Exit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConf_Itens_DevBoi: TFrmConf_Itens_DevBoi;

implementation

uses UntDataModulo, UntDevolucaoAcougue;

{$R *.DFM}

procedure TFrmConf_Itens_DevBoi.FormShow(Sender: TObject);
begin
  Edit2.Text := '0';
  DbEdit4.Field.Value := 0;
  Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_BA').AsString;
end;

procedure TFrmConf_Itens_DevBoi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Close;
  FrmDevolucaoAcougue.CompletingComboBox1.DroppedDown := True;
end;

procedure TFrmConf_Itens_DevBoi.RadioGroup1Click(Sender: TObject);
begin
  Case RadioGroup1.ItemIndex of
    0: Edit1.Text := DmPrincipal.TbProdutosboi.FieldByName('Valor_BA').AsString;
    1: Edit1.Text := DmPrincipal.TbProdutosboi.FieldByName('Valor_AP').AsString;
    2: Edit1.Text := DmPrincipal.TbProdutosboi.FieldByName('Valor_AV').AsString;
    3: Edit1.Text := DmPrincipal.TbProdutosboi.FieldByName('Valor_TR').AsString;
  end;
end;

procedure TFrmConf_Itens_DevBoi.DBEdit4Exit(Sender: TObject);
begin
  Edit2.Text := FormatCurr('###,###,##0.00',StrToCurr(StrToFloat(Edit1.Text) * DbEdit4.Field.Value));
end;

procedure TFrmConf_Itens_DevBoi.BitBtn1Click(Sender: TObject);
Var nTotal: Currency;
begin
  DmPrincipal.TbMov_DevBoi.FieldByName('Unitario').AsFloat := StrToFloat(Edit1.Text);
  DmPrincipal.TbMov_DevBoi.Post;
  DmPrincipal.TbMov_DevBoi.First;
  nTotal := 0;
  While Not DmPrincipal.TbMov_DevBoi.EOF do
  Begin
    nTotal := nTotal + (DmPrincipal.TbMov_DevBoi.FieldByName('Qtde').AsCurrency * DmPrincipal.TbMov_DevBoi.FieldByName('Unitario').AsCurrency);
    DmPrincipal.TbMov_DevBoi.Next;
  End;
  FrmDevolucaoAcougue.Edit2.Text := FormatCurr('###,###,###,##0.00',nTotal);
end;

procedure TFrmConf_Itens_DevBoi.BitBtn2Click(Sender: TObject);
begin
  DmPrincipal.TbMov_DevBoi.Cancel;
end;

end.
