unit aboutunit;

{$MODE Delphi}

interface

uses
  {$ifdef darwin}
  macport,
  {$endif}
  {$ifdef windows}
  windows,shellapi,
  {$endif}LCLIntf, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, LResources, vmxfunctions, NewKernelHandler, betterControls;

type

  { TAbout }

  TAbout = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Image1: TImage;
    Button1: TButton;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    Label10: TLabel;
    lblDBVM: TLabel;
    Panel3: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure FormShow(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblDBVMClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateDBVMStatus;
  end;

var
  About: TAbout;

implementation

uses tlgUnit,MainUnit2, MainUnit, dbvmLoadManual;


resourcestring
  rsYourSystemDOESNOTSupportDBVM = 'Your system does not support DBVM. Perhaps it is already inside a VM';
  rsThisMeansThatYouWillNeedANewCpuIntelToBeAbleToUseT = 'This means that you will need a new cpu (intel) to be able to use the advanced dbvm options';
  rsYourSystemIsRunningDBVMVersion = 'Your system is running DBVM version %s (%.0n bytes free (%d pages))';
  rsThisMeansThatYourSystemIsRunningDbvm = 'This means that your system is running dbvm. This means ce will make use of some advanced tools that are otherwise unavailable';
  rsYourSystemSupportsDBVM = 'Your system supports DBVM';
  rsThisMeansThatYouReCurrentlyNotRunningDbvm = 'This means that you''re currently not running dbvm, but that your system is capable of running it';
  rsDidYouReallyThinkYouDFindAnEasterEggByDoingThisWel = 'Did you really think you''d find an easter egg by doing this? Well, you know what? You where right!';
  rsAreYouSureYouWantToLaunchDBVM = 'Are you sure you want to launch DBVM? You seem to be running in 32-bit, so don''t really need it that badly (Except for ultimap and cloaked operations)';
  rsLaunchdbvmWasNotAssigned = 'launchdbvm was not assigned';

procedure TAbout.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  About:=nil;
  action:=caFree;
end;

procedure TAbout.FormShow(Sender: TObject);
var
    a,b,c,d: dword;
    i: integer;
begin
  {$ifdef net}
    groupbox1.Caption:=unit2.CEnorm;
  {$else}
    groupbox1.Caption:=mainunit2.CEnorm;
  {$endif}


  i:=GetFontData(font.Handle).Height;
UpdateDBVMStatus;
end;


procedure TAbout.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (ssCtrl in Shift) and (ssAlt in Shift) and (ssShift in Shift) then
  begin
    ShowMessage(rsDidYouReallyThinkYouDFindAnEasterEggByDoingThisWel);
    with TTlg.create(self) do show;
  end;
end;


procedure TAbout.lblDBVMClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  {$ifdef windows}
  //if not isRunningDBVM then
  begin
    //if not isDBVMCapable then exit;

    if button=mbLeft then
    begin


      if not Is64bitOS then
      begin
        if messagedlg(rsAreYouSureYouWantToLaunchDBVM, mtWarning, [mbno, mbyes], 0)=mryes then
        begin
          loaddbk32;
          if assigned(launchdbvm) then
            launchdbvm(-1)
          else
            raise exception.create(rsLaunchdbvmWasNotAssigned);

          formshow(self);
        end;
      end
      else
      begin
        if loaddbvmifneeded then
        begin
          formshow(self);
        end;
      end;
    end
    else
      if frmDBVMLoadManual<>nil then
        frmDBVMLoadManual.SetFocus
      else
        tfrmDBVMLoadManual.create(Application).Show;
  end;
  {$endif}
end;

procedure TAbout.UpdateDBVMStatus;
var
  supportsdbvm: boolean;
  pages: QWORD;
  memfree: qword;
  dmemfree: double;
  vers: DWORD;

  oldvmx_password1: QWORD;
  oldvmx_password2: DWORD;
  oldvmx_password3: QWORD;

begin
  {$ifdef windows}
  oldvmx_password1:=vmx_password1;
  oldvmx_password2:=vmx_password2;
  oldvmx_password3:=vmx_password3;
  OutputDebugString('UpdateDBVMStatus');

  if (vmx_password1=0) and (vmx_password2=0) and (vmx_password3=0) then
  begin
    OutputDebugString('vmx_password1=0');
    OutputDebugString('vmx_password2=0');
    OutputDebugString('vmx_password3=0');
    vmx_password1:=$76543210;
    vmx_password2:=$fedcba98;
    vmx_password3:=$90909090;
  end;

  if dbvm_version=0 then
  begin
    vmx_password1:=$76543210;
    vmx_password2:=$fedcba98;
    vmx_password3:=$90909090;
  end;

  if (dbvm_version>0) then
  begin
    lblDBVM.Font.Color:=clLime;

    memfree:=dbvm_getMemory(pages);
    dmemfree:=memfree;

    lbldbvm.caption:=Format(rsYourSystemIsRunningDBVMVersion, [inttostr(dbvm_version and $00ffffff), dmemfree, pages]);
    lbldbvm.Hint:=rsThisMeansThatYourSystemIsRunningDbvm;
    lbldbvm.ShowHint:=true;
    lbldbvm.Cursor:=crDefault;
  end
  else
  begin
    supportsdbvm:=isDBVMCapable;

    if supportsdbvm then
    begin
      lblDBVM.Font.Color:=clGreen;
      lbldbvm.caption:=rsYourSystemSupportsDBVM;
      lbldbvm.Hint:=rsThisMeansThatYouReCurrentlyNotRunningDbvm;
      lbldbvm.ShowHint:=true;
      lbldbvm.Cursor:=crHandPoint;
    end
    else
    begin
      lblDBVM.Font.Color:=clRed;
      lbldbvm.caption:=rsYourSystemDOESNOTSupportDBVM;
      lbldbvm.Hint:=rsThisMeansThatYouWillNeedANewCpuIntelToBeAbleToUseT;
      lbldbvm.ShowHint:=true;
      lbldbvm.Cursor:=crNo;
    end;
  end;

  vmx_password1:=oldvmx_password1;
  vmx_password2:=oldvmx_password2;
  vmx_password3:=oldvmx_password3;
  {$else}
  lblDBVM.visible:=false;
  {$endif}
end;


initialization
  {$i aboutunit.lrs}

end.
