unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, System.ImageList, Vcl.ImgList, Vcl.ToolWin,
  IdUDPServer, IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, IdAntiFreezeBase, IdAntiFreeze, IdGlobal,
  IdSocketHandle;

type
  TFormMain = class(TForm)
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
    ImageList2: TImageList;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UDPServer1UDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure StatusBar1Hint(Sender: TObject);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
  private
    { Private declarations }
    FIP: string;
    procedure OnIdle(Sender: TObject; var Done: Boolean);
    procedure InsertFiles(strPath: string; ListView: TListView; ImageList: TImageList);
    function Exists(IP: string): Boolean;
    function IP2Int(const IP : string): DWord;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses Winapi.ShellApi, IdStack;

function TFormMain.Exists(IP: string): Boolean;
var
  Items: TListItems;
  Item: TListItem;
begin
  if IP.IsEmpty then begin
    Exit(True);
  end;

  Result := False;
  Items := ListView1.Items;
  for Item in Items do
  begin
    if Item.SubItems[0].Equals(IP) then
    begin
      Result := True;
    end;
  end;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  UDPServer1.Active := False;
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := IDYES = MessageBox(TForm(Sender).Handle, '要退出应用吗？', '退出确认', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  LocalIPs: TStrings;
  IP: string;
begin
  // InsertFiles('', ListView2, ImageList3);

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
  StatusBar1.Panels[0].Text := '本机 IP 地址: ' + IP;

  Application.OnIdle := OnIdle;
  UDPClient1.BoundIP := FIP;
  UDPServer1.Active := True;
end;

procedure TFormMain.InsertFiles(strPath: string; ListView: TListView; ImageList: TImageList);
var
  i: Integer;
  Icon: TIcon;
  SearchRec: TSearchRec;
  ListItem: TListItem;
  FileInfo: SHFILEINFO;
begin
  // Create a temporary TIcon
  Icon := TIcon.Create;
  ListView.Items.BeginUpdate;
  try
    with ListView do
    begin
      ListItem := ListView.Items.Add;
      // Get The DisplayName
      SHGetFileInfo(PChar(strPath), 0, FileInfo, SizeOf(FileInfo), SHGFI_DISPLAYNAME);
      ListItem.Caption := FileInfo.szDisplayName;
      // Get The TypeName
      SHGetFileInfo(PChar(strPath), 0, FileInfo, SizeOf(FileInfo), SHGFI_TYPENAME);
      ListItem.SubItems.Add(FileInfo.szTypeName);
      // Get The Icon That Represents The File
      SHGetFileInfo(PChar(strPath), 0, FileInfo, SizeOf(FileInfo), SHGFI_ICON or SHGFI_SMALLICON);
      Icon.Handle := FileInfo.hIcon;
      ListItem.ImageIndex := ImageList.AddIcon(Icon);
      // Destroy the Icon
      DestroyIcon(FileInfo.hIcon);
    end;
  finally
    Icon.Free;
    ListView.Items.EndUpdate;
  end;
end;

function TFormMain.IP2Int(const IP: string): DWord;
var
  lst : TStringList;
  i : integer;
begin
  Result := 0;
  lst := TStringList.Create;
  try
    lst.Delimiter := '.';
    lst.DelimitedText := IP;

    for i := 0 to lst.Count - 1 do
      Result := Result + StrToInt64(lst[i]) shl (24 - i * 8);
  finally
    lst.Free;
  end;
end;

procedure TFormMain.ListView1Compare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  Compare := Integer(Item2.Data) - Integer(Item1.Data);
end;

procedure TFormMain.ListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  IP: string;
  DW: DWord;
begin
  if Selected then begin
    DW := DWord(Item.Data);
    if DW = 0 then begin

    end else begin
      IP := Item.SubItems[0];
    end;
  end;
end;

procedure TFormMain.OnIdle(Sender: TObject; var Done: Boolean);
begin
  // StatusBar1.SimpleText := TimeToStr(Time);
end;

procedure TFormMain.StatusBar1Hint(Sender: TObject);
begin
  StatusBar1.Panels[2].Text := Application.hint;
end;

procedure TFormMain.Timer1Timer(Sender: TObject);
var
  S: string;
  IP: string;
begin
  TTimer(Sender).Enabled := False;
  try
    UDPClient1.Broadcast('Anyone on line?', 8080);
    S := UDPClient1.ReceiveString(2);
    IP := S.Substring(3);
    if not Exists(IP) then
    begin
      with ListView1.Items.Add do
      begin
        SubItems.Add(IP);
        if IP.Equals(FIP) then
        begin
          Data := Pointer(0);
        end else begin
          Data := Pointer(IP2Int(IP));
        end;
        ListView1.CustomSort(nil, 0);
      end;
    end;
  finally
    TTimer(Sender).Enabled := True;
  end;
end;

procedure TFormMain.UDPServer1UDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle);
begin
  UDPServer1.Send(ABinding.PeerIP, ABinding.PeerPort, 'IP:' + FIP);
end;

end.
