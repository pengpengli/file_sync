object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 412
  ClientWidth = 690
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Splitter1: TSplitter
    Left = 250
    Top = 43
    Height = 350
    ExplicitLeft = 280
    ExplicitTop = 216
    ExplicitHeight = 100
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 690
    Height = 43
    AutoSize = True
    ButtonHeight = 43
    ButtonWidth = 73
    Caption = 'ToolBar1'
    Images = ImageList1
    ShowCaptions = True
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Hint = #21047#26032
      Caption = 'ToolButton1'
      ImageIndex = 0
    end
  end
  object ListView1: TListView
    Left = 0
    Top = 43
    Width = 250
    Height = 350
    Align = alLeft
    Columns = <
      item
        Caption = #24207#21495
      end
      item
        Caption = #20027#26426
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    ExplicitLeft = 112
    ExplicitTop = 192
    ExplicitHeight = 150
  end
  object ListView2: TListView
    Left = 253
    Top = 43
    Width = 437
    Height = 350
    Align = alClient
    Columns = <
      item
      end
      item
        Caption = #25991#20214#21517#31216
      end>
    TabOrder = 2
    ExplicitLeft = 408
    ExplicitTop = 224
    ExplicitWidth = 250
    ExplicitHeight = 150
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 393
    Width = 690
    Height = 19
    Panels = <>
    ParentShowHint = False
    ShowHint = True
    SimplePanel = True
    ExplicitLeft = 376
    ExplicitTop = 400
    ExplicitWidth = 0
  end
  object ImageList1: TImageList
    Height = 24
    Width = 24
    Left = 96
    Top = 8
  end
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 96
    Top = 128
  end
  object UDPClient1: TIdUDPClient
    BroadcastEnabled = True
    Port = 8080
    Left = 320
    Top = 72
  end
  object UDPServer1: TIdUDPServer
    BroadcastEnabled = True
    Bindings = <>
    DefaultPort = 8080
    ThreadedEvent = True
    OnUDPRead = UDPServer1UDPRead
    Left = 456
    Top = 72
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 320
    Top = 136
  end
end