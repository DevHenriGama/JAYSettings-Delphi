object Form1: TForm1
  Left = 125
  Top = 123
  Caption = 'JAYSettings 1.0'
  ClientHeight = 207
  ClientWidth = 345
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  TextHeight = 15
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 36
    Height = 15
    Caption = 'Chave:'
  end
  object Label2: TLabel
    Left = 24
    Top = 96
    Width = 29
    Height = 15
    Caption = 'Valor:'
  end
  object SpeedButton1: TSpeedButton
    Left = 312
    Top = 48
    Width = 23
    Height = 22
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 311
    Top = 118
    Width = 23
    Height = 22
    OnClick = SpeedButton2Click
  end
  object btnSalvar: TButton
    Left = 24
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 0
    OnClick = btnSalvarClick
  end
  object Edit1: TEdit
    Left = 24
    Top = 48
    Width = 281
    Height = 23
    TabOrder = 1
    Text = 'JAYSettings'
  end
  object Edit2: TEdit
    Left = 24
    Top = 117
    Width = 281
    Height = 23
    TabOrder = 2
  end
  object btnLer: TButton
    Left = 230
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Ler'
    TabOrder = 3
    OnClick = btnLerClick
  end
  object CheckBox1: TCheckBox
    Left = 127
    Top = 164
    Width = 97
    Height = 17
    Caption = 'Use Encrypt'
    TabOrder = 4
  end
end
