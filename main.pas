unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, System.ImageList, Vcl.ImgList, Vcl.ToolWin,
  IdUDPServer, IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, IdAntiFreezeBase, IdAntiFreeze, IdGlobal,
  IdSocketHandle;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ImageList1: TImageList;
    ListView1: TListView;
    Splitter1: TSplitter;
    ListView2: TListView;
    Timer1: TTimer;
    UDPClient1: TIdUDPClient;
    UDPServer1: TIdUDPServer;
    StatusBar1: TStatusBar;
    IdAntiFreeze1: TIdAntiFreeze;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UDPServer1UDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle);
  private
    { Private declarations }
    FIP: string;
    procedure OnIdle(Sender: TObject; var Done: Boolean);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses IdStack;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  UDPServer1.Active := False;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := IDYES = MessageBox(TForm(Sender).Handle, '要退出应用吗？', '退出确认', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  LocalIPs: TStrings;
  IP: string;
begin
  LocalIPs := TStringList.Create;
  try
    GStack.AddLocalAddressesToList(LocalIPs);
    for IP in LocalIPs do
    begin
      if IP.StartsWith('192.168.1.') then
      begin
        Break;
      end;
    end;
  finally
    LocalIPs.Free;
  end;
  FIP := IP;

  Application.OnIdle := OnIdle;
  UDPClient1.BoundIP := FIP;
  UDPServer1.Active := True;
end;

procedure TForm1.OnIdle(Sender: TObject; var Done: Boolean);
begin
  StatusBar1.SimpleText := TimeToStr(Time);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  S: string;
begin
  TTimer(Sender).Enabled := False;
  try
    UDPClient1.Broadcast('Anyone on line?', 8080);
    S := UDPClient1.ReceiveString(5);
    ShowMessage(S);
  finally
    TTimer(Sender).Enabled := True;
  end;
end;

procedure TForm1.UDPServer1UDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle);
begin
  UDPServer1.Send(ABinding.PeerIP, ABinding.PeerPort, 'IP:' + FIP + '^M');
end;

end.
