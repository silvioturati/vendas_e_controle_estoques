unit UntCalendario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Grids, Calendar, ExtCtrls, Spin;

type
  TFrmCalendario = class(TForm)
    Panel1: TPanel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    SpinEdit1: TSpinEdit;
    Calendar1: TCalendar;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCalendario: TFrmCalendario;

implementation

{$R *.DFM}


procedure TFrmCalendario.FormShow(Sender: TObject);
Var wDia, wMes, wAno: Word;
begin
  DecodeDate(Date, wAno, wMes, wDia);
  SpinEdit1.Value := wAno;
  ComboBox1.ItemIndex := wMes - 1;
end;

procedure TFrmCalendario.SpinEdit1Change(Sender: TObject);
begin
  Calendar1.Year := SpinEdit1.Value;
  Calendar1.UpdateCalendar;
end;

procedure TFrmCalendario.ComboBox1Change(Sender: TObject);
begin
  Calendar1.Month := ComboBox1.ItemIndex + 1;
  Calendar1.UpdateCalendar;
end;




end.
