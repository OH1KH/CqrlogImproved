unit fCustomMessage;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TfrmCustomMessage }

  TfrmCustomMessage = class(TForm)
    btnOk: TButton;
    chkCondx: TCheckBox;
    imgLogo: TImage;
    lblMessage: TLabel;
    tmrAutoClose: TTimer;
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrAutoCloseTimer(Sender: TObject);
  private
    timecount: integer;

  public
   Head       : String;
   Message    : String;
   CondxName  : String; //name to save chckebox value
   ShowCdx    : boolean;//show checkbox
   OpenTime   : integer;

  end;

var
  frmCustomMessage: TfrmCustomMessage;

implementation

{$R *.lfm}

{ TfrmCustomMessage }
uses uMyIni;

procedure TfrmCustomMessage.FormShow(Sender: TObject);
begin
   //Set these values in dUtils after ceration and before show form
  frmCustomMessage.Caption:= Head;
  lblMessage.Caption := Message;
  chkCondx.Visible   := ShowCdx;
  if not chkCondx.Visible then
          frmCustomMessage.Height:=frmCustomMessage.Height-25;
  if (CondxName<>'') and cqrini.ReadBool('CustomMessage', CondxName, False) then
                                                                     Self.Close;

  timecount          := 0;
  btnOK.Caption      :='('+IntToStr(OpenTime-timecount)+') OK';

end;


procedure TfrmCustomMessage.tmrAutoCloseTimer(Sender: TObject);
begin
   if OpenTime>0  then
                  begin
                   inc(timecount);
                   btnOK.Caption:='('+IntToStr(OpenTime-timecount)+') OK';
                  end;

   if (timecount>0)
      and (timecount>=OpenTime) then
                                 Self.Close;
end;

procedure TfrmCustomMessage.btnOkClick(Sender: TObject);
begin
   Self.Close;
end;

procedure TfrmCustomMessage.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
   if (CondxName<>'') and  chkCondx.Visible then
      begin
             cqrini.WriteBool('CustomMessage', CondxName, True);
      end;
end;

procedure TfrmCustomMessage.FormCreate(Sender: TObject);
begin
  showCdx:=False;
  CondxName:='';
  Message:='';
  OpenTime:=-1;   //set this from parent after creating form
end;



end.

