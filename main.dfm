object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = #25991#20214#21516#27493
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
        Width = 30
      end
      item
        Caption = #20027#26426
        Width = 150
      end>
    Ctl3D = False
    ReadOnly = True
    RowSelect = True
    SmallImages = ImageList1
    SortType = stData
    TabOrder = 1
    ViewStyle = vsReport
    OnCompare = ListView1Compare
    OnSelectItem = ListView1SelectItem
    ExplicitLeft = -3
    ExplicitTop = 37
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
    Ctl3D = False
    ReadOnly = True
    RowSelect = True
    SmallImages = ImageList2
    TabOrder = 2
    ViewStyle = vsReport
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 393
    Width = 690
    Height = 19
    AutoHint = True
    Panels = <
      item
        Width = 160
      end
      item
        Width = 150
      end
      item
        Width = 50
      end>
    ParentShowHint = False
    ShowHint = True
    OnHint = StatusBar1Hint
  end
  object ImageList1: TImageList
    Height = 24
    Width = 24
    Left = 40
    Top = 88
  end
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 136
    Top = 88
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
    Left = 584
    Top = 72
  end
  object ImageList2: TImageList
    ShareImages = True
    Left = 456
    Top = 176
  end
end
