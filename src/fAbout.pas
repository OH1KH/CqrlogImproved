unit fAbout;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, lclintf, ComCtrls, Grids;

type

  { TfrmAbout }

  TfrmAbout = class(TForm)
    Bevel1 : TBevel;
    BevelUp: TBevel;
    BevelAb: TBevel;
    btnChangelog: TButton;
    btnClose : TButton;
    btnUpClose: TButton;
    btnAbClose: TButton;
    Image1 : TImage;
    imgUp: TImage;
    imgAb: TImage;
    Label1 : TLabel;
    lblAbExe: TLabel;
    lblAbBy: TLabel;
    lblAbName: TLabel;
    lblAbExt: TLabel;
    Label14: TLabel;
    lblUpExe: TLabel;
    lblUPSrc: TLabel;
    lblAbState: TLabel;
    Label2 : TLabel;
    Label3 : TLabel;
    Label4: TLabel;
    Label5 : TLabel;
    lblUpName: TLabel;
    lblUpExt: TLabel;
    lblUpBy: TLabel;
    lblAbSrc: TLabel;
    lblLink : TLabel;
    lblLink1: TLabel;
    lblAbLinkSrc: TLabel;
    lblAbLinkExe: TLabel;
    lbUPLinkSrc: TLabel;
    lblUpLinkExe: TLabel;
    lblUpVer: TLabel;
    lblVerze: TLabel;
    lblAbVer: TLabel;
    PageControl1 : TPageControl;
    sgContributors: TStringGrid;
    tabOrigin : TTabSheet;
    tabContributors : TTabSheet;
    TabAbout: TTabSheet;
    tabUpgrade: TTabSheet;
    procedure btnChangelogClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblLinkClick(Sender: TObject);
    procedure lblLinkMouseEnter(Sender: TObject);
  private
    { private declarations }
    Procedure showChangelog;
    Procedure showNewChangelog;
  public
    { public declarations }
    IsNewVersion : boolean;
  end; 

var
  frmAbout: TfrmAbout;

implementation

{$R *.lfm}

{ TfrmAbout }
uses fChangelog, uVersion, dUtils, fNewQSO;

procedure TfrmAbout.lblLinkMouseEnter(Sender: TObject);
begin
  (Sender as TLabel).Cursor:= crHandPoint
end;

procedure TfrmAbout.lblLinkClick(Sender: TObject);
begin
  dmUtils.OpenInApp((Sender as TLabel).Caption);
end;

procedure TfrmAbout.btnChangelogClick(Sender: TObject);
begin
   if IsNewVersion then
   showNewChangelog
  else
   showChangelog;
end;

Procedure TfrmAbout.showChangelog;
Begin
  with TfrmChangelog.Create(Application) do
  try
     ViewChangelog;
     ShowModal
  finally
     Free
  end
end;
Procedure TfrmAbout.showNewChangelog;
Begin
  with TfrmChangelog.Create(Application) do
  try
     ViewNewChangelog;
     ShowModal
  finally
     Free
  end
end;
procedure TfrmAbout.FormCreate(Sender: TObject);
begin
  IsNewVersion:=false;
end;

procedure TfrmAbout.FormShow(Sender: TObject);
begin
  lblUpVer.Caption := cVERSION +'  '+ cBUILD_DATE;
  lblAbVer.Caption := cVERSION +'  '+ cBUILD_DATE;
  Case frmNewQso.ImprovedVer of
       0:   lblAbState.Caption:='Version state:  Unknown';
       1:   lblAbState.Caption:='Version state:  Latest';
       2:   lblAbState.Caption:='Version state:  Update!';
       3:   lblAbState.Caption:='Version state:  Eh? Over release, Devel?';
   end;
end;

end.

