object frmPathEditorMain: TfrmPathEditorMain
  Left = 0
  Top = 0
  Caption = 'Delphi Path Editor'
  ClientHeight = 361
  ClientWidth = 654
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 670
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 48
    Top = 37
    Width = 87
    Height = 16
    Caption = 'Delphi Version:'
  end
  object Label2: TLabel
    Left = 48
    Top = 298
    Width = 45
    Height = 16
    Caption = 'Theme:'
  end
  object btnSave: TSpeedButton
    Left = 48
    Top = 152
    Width = 23
    Height = 22
    Action = actSave
  end
  object btnCancel: TSpeedButton
    Left = 77
    Top = 152
    Width = 23
    Height = 22
    Action = actCancel
  end
  object btnAdd: TSpeedButton
    Left = 106
    Top = 152
    Width = 23
    Height = 22
    Action = actAdd
  end
  object btnRemove: TSpeedButton
    Left = 135
    Top = 152
    Width = 23
    Height = 22
    Action = actRemove
  end
  object cmbDelphis: TComboBox
    Left = 48
    Top = 59
    Width = 153
    Height = 24
    Style = csDropDownList
    TabOrder = 0
  end
  object cmbTheme: TComboBox
    Left = 48
    Top = 320
    Width = 153
    Height = 24
    Style = csDropDownList
    TabOrder = 1
    OnClick = cmbThemeClick
  end
  object ListBox1: TListBox
    Left = 256
    Top = 0
    Width = 398
    Height = 361
    Align = alRight
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
  end
  object imlActions: TImageList
    Left = 176
    Top = 256
    Bitmap = {
      494C010104000800200010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FBFBFB00C1C4C000879383006D8365006B82640084908000BDC1BC00F9F9
      F900000000000000000000000000000000000000000000000000000000000000
      0000FAFAFA00C0C0C50083839500656583006464830081819200BCBCC200F7F7
      F70000000000000000000000000000000000000000000000000000000000FDFE
      FD000000000070956F00014D0000004C0000004C0000014D000070956F000000
      0000FDFEFD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D1D3
      D00059784F0023760B001D8900001F9100001F910000208B0100207708005477
      4900CACBC900000000000000000000000000000000000000000000000000D0D0
      D40050507A000D0D7B0001018C00010193000101930001018D000B0B7B004A4A
      7A00C9C9CC00000000000000000000000000000000000000000000000000FEFF
      FE0000000000117B100000F6000006FF060006FF060000F60000117B10000000
      0000FEFFFE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C1C6C0003075
      1E00219702001E9E00001CA000001EA201001DA2000022A3020023A004002098
      02002A751600B7BBB60000000000000000000000000000000000C1C1C5001E1E
      79000000950000009C000000A3000202A5000202A5000000A30000009C000000
      960017177A00B7B7BD000000000000000000000000000000000000000000FDFF
      FD0000000000117B100000EC000006FF060006FF060000EC0000117B10000000
      0000FDFFFD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E0E1E00032772300209E
      050017A1000048B93600B8E8B300BDE9B80090D7860020AD040021AB040021A5
      06001F9E04002C791B00D7D9D7000000000000000000DFDFE00023237C000000
      99005858BD006363C7000000A9000404B1000404B1000000AA005454C3005E5E
      C00000009B001A1A7D00D7D7D90000000000FDFEFD00FDFEFD00FDFEFD00FBFE
      FB00FDFFFD00117B100000EA000005FA050005FA050000EA0000117B1000FDFF
      FD00FBFEFB00FDFEFD00FDFEFD00FDFEFD00FCFCFD00FCFCFE00FCFCFE00FCFC
      FE00FCFCFE00FCFCFE00FCFCFE00FCFCFE00FCFCFE00FCFCFE00FCFCFE00FCFC
      FE00FCFCFE00FDFDFF00FCFCFE00FDFDFE000000000073906E001C9D06001BA7
      04001AAF0600B4E6B00000000000FDFFFF00F0FCF4004AC138001AB2010022B3
      0A001EA907001C9E0600678A6100FDFDFD00FEFEFE006E6E910000009B005353
      BC00F8F8FD00FBFBFD005F5FCB000000B2000000B2004D4DC700F0F0FA00FEFE
      FF006262C10000009C005E5E8C00FCFCFC000000000000000000000000000000
      000000000000127A110000D7000007E6070007E6070000D70000127A11000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E0E0DF00328928001EAB0D000EAE
      00005ECB5300F3FEF700F1FFF300EEFEF000FAFFFD0099DE940018B5060021B8
      0F001DB40A001DAB0C002D8B2000D3D5D200E0E0E20026268C000000A9004747
      C100E9E9F40000000000F4F4FB005959CE004747C900EDEDF90000000000F3F3
      F7005A5AC6000000A9001D1D8F00D5D5D700669A660011791000117911001178
      1100127912000775070004CB070007D00C0007D00C0004CB0700017201001279
      120011781100117911001179100071956F008A8AB7007979C0007777C6007777
      C4007777C5007676C5007676C5007676C5007676C5007676C5007676C5007777
      C5007777C4007878C7007474BE00B5B5CB00A4B0A2001F9A15001CB20F0027BD
      1B00D0F2D00000000000BCEABC0099DD9500F9FFFB00E1F8E30038C32D001BBD
      0F0020BC15001FB414001C9E120092A59000AAAAB60011119E000B0BB5000000
      B8004040C600E6E6F30000000000F6F6FC00F2F2FB0000000000EFEFF7005252
      CA000000B8000C0CB6000D0DA0009696AA00004E000014B419001EBB24001CBB
      22001DB821001FBF240021C0270020C0270020C0270021C027001FBF24001DB8
      21001CBB22001FB9230013BD1900005A00000000AA000909DF000C0CEA000C0C
      E7000C0CE9000D0DE9000D0DE9000D0DE9000D0DE9000D0DE9000D0DE9000C0C
      E9000C0CE8000C0CE9000A0AE90003036B0085A083001CA5170015B70D006CD1
      6900E2F3E400D8EFD90059CE540044CA3E00E9F9EA00FDFFFF0082DB7F0019C2
      120024C41E0020BA19001CA71700789B75008484A3001212A8001313BB001616
      C5000909C3004646CC00E9E9F7000000000000000000F3F3F9005757CF000606
      C1001515C5001313BC001111AA0074749B00004D000037B63E0050C258004BC0
      52004EC154004BBF510049BE510049BF500049BF500049BE51004BBF51004EC1
      55004BC0520050C1570037BE3E00065A06000B0BAD003434DD004343E4003F3F
      E1004040E2004141E3004141E3004040E3004040E3004141E3004141E3004040
      E2003F3FE2004343E3003636E60002026D008BA589001EAA1E0020BE1F0030C8
      300035C9350038CB380035CC340035CC3400B0E7B10000000000CFF3D1002FCA
      2E001FC71E0021BF21001EAC1D007DA07C008C8CA8001818AE001919C1001C1C
      CA001212C9005656D700ECECF9000000000000000000F5F5FB006767D9001111
      C8001B1BC9001919C1001818AF007D7DA200004C00005BB6610085CB8B007DC6
      82007EC783007CC5810078C37D0078C37E0078C37E0078C37D007CC582007EC7
      84007CC6820085CA8B005BBC6100004C0000171795006363CD007C7CD7007777
      D5007878D5007777D6007878D6007878D6007878D6007878D6007777D6007979
      D5007777D5007D7DD6006666D40006066500B6C2B60028AA2C0023C2270022CB
      260026CF2A002DD0310037D23B0031D035006BDA6E00F5FDF600F9FEFA0068DB
      6B0018C91C0022C2270024AD2800A6B6A500BBBBC7002828AF002121C5001212
      CB005C5CDA00F0F0FA0000000000F2F2F800EEEEF70000000000F6F6FC006E6E
      DE001212CB002121C6002525B300A9A9B900004D00006EAE7300A7CEAA0099C6
      9D0099C69E00A4CFA800AED5B300AED5B200AED5B200AED5B300A4CFA80099C6
      9E0099C69D00A7CDAA006DB27300004B000013137E008C8CCC00BCBCE400B2B2
      DF00B5B5E100B4B4E000B5B5E100B5B5E100B5B5E100B5B5E100B4B4E000B4B4
      E000B1B1DF00BCBCE4008F8FD20000005700EEF0EE004BA54F0024C32D0026CD
      2F0029D333002ED4370032D53B0031D53A0035D43D00C7F0CA0000000000B9EF
      BD001FCA290023C42C0042A54600E8EAE800EEEEF0004C4CA8002020C7006666
      D800F3F3FC0000000000F3F3F8006969DB005959D900EBEBF60000000000FCFC
      FE007676DC001F1FC6004545AC00E8E8EB00668D660014781400177917001678
      1600167916000D730E00C8DDCA00E0ECE300E0ECE300C8DDCA00017102001679
      16001678160016791600147814006F916F009090B90056569B006565A3006565
      A3006767A5006666A4006767A5006767A5006767A5006767A5006767A4006666
      A4006565A4006666A40051519A009E9EBE00000000009AB59C0028BD350027C9
      34002AD437002CD73B002ED83C0031D83F0023D5310081E2880000000000FDFF
      FE005BD465001EC02C008FB2910000000000000000009D9DB9002B2BC3006A6A
      D500F4F4F900F6F6FA007070DF002A2AD8002A2AD9006161DD00EDEDF800F8F8
      FA007474D7002B2BC7008F8FB100000000000000000000000000000000000000
      00000000000014781400BED1C100E6EEE800E6EEE800BED1C100147814000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F7F7006AB16F002BC4
      3B002ACE3B002CD53E002DD93E002EDA400029D93B003DD94D00ACE7B300BCEB
      C2007ADA840058A95E00F1F2F1000000000000000000F6F6F6007070B5002E2E
      CA007070D7007878DE002C2CDA003B3BDD003C3CDD002C2CDA006E6EDD007575
      D7002F2FCC006565B300F0F0F20000000000FDFEFD00FDFEFD00FEFEFE00FCFD
      FC00FEFFFE0014771400BFD2C200E6EDE700E6EDE700BFD2C20014771400FEFF
      FE00FCFDFC00FEFEFE00FDFEFD00FDFDFD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FDFDFE000000000000000000ECF1EC0070BC
      78002EBF3F002AC83E002CD040002DD341002ED342002AD03E0022C6370028C0
      3A0064AF6B00E3E6E30000000000000000000000000000000000EAEAF0007777
      C0003A3AC4003737CD004141D5004242D8004141D8004242D5003838CE003A3A
      C8006E6EB700E3E3EA000000000000000000000000000000000000000000FDFE
      FD000000000013771400C5D7C700EBF2EC00EBF2EC00C5D7C700137714000000
      0000FDFEFD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FAFB
      FA00B1DAB5006ACB75003CC04E0034C1470034C146003BC04C0065CA7100ADDB
      B100F7F9F700000000000000000000000000000000000000000000000000F9F9
      FB00B1B1DC007272CE005353C8004A4AC8004A4AC8005050C6006F6FCE00AEAE
      DB00F5F5F700000000000000000000000000000000000000000000000000FDFE
      FD000000000013771300AFC6B200D6E3D900D6E3D900AFC6B200137713000000
      0000FDFEFD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FAFDFA00E1F3E300BEE5C200BCE4C000DFF2E100F9FDF9000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F8F8FC00E1E1F300BBBBE400B9B9E400DFDFF200F7F7FC000000
      000000000000000000000000000000000000000000000000000000000000FDFE
      FD0000000000678D6700024D0200024D0200024D0200024D0200678D67000000
      0000FDFEFD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000F00FF00FE817FFFFE007E007E817FFFF
      C003C003E817FFFF800180010000000082000000F81FFFFF0000042000000000
      0400024000000000000001800000000000400180000000000000024000000000
      002004200000000080218001F81FFFFF800180010000FFFEC003C003E817FFFF
      E007E007E817FFFFF81FF81FE817FFFF00000000000000000000000000000000
      000000000000}
  end
  object actPathActions: TActionList
    Images = imlActions
    Left = 184
    Top = 192
    object actSave: TAction
      Caption = '&Save'
      Enabled = False
      Hint = 
        'Save the modified Path back to the selected Delphi Environment s' +
        'ettings.'
      ImageIndex = 0
      Visible = False
    end
    object actCancel: TAction
      Caption = '&Cancel'
      Enabled = False
      Hint = 'Discard the path modifications made.'
      ImageIndex = 1
      Visible = False
    end
    object actAdd: TAction
      Caption = '&Add'
      Hint = 'Add a path to the list.'
      ImageIndex = 2
    end
    object actRemove: TAction
      Caption = '&Remove'
      Hint = 'Remove the path from the list.'
      ImageIndex = 3
    end
  end
  object mnuPathActions: TPopupMenu
    Images = imlActions
    Left = 320
    Top = 184
    object Save1: TMenuItem
      Action = actSave
    end
    object Cancel1: TMenuItem
      Action = actCancel
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Add1: TMenuItem
      Action = actAdd
    end
    object Remove1: TMenuItem
      Action = actRemove
    end
  end
  object dlgNoDelphi: TTaskDialog
    Buttons = <>
    Caption = 'BDS Path Not Found'
    CommonButtons = [tcbClose]
    DefaultButton = tcbClose
    MainIcon = 1
    RadioButtons = <>
    Text = 
      'The Software\Embarcadero\BDS path was not found in the registry ' +
      'which indicates there are no versions of Delphi installed.'
    Title = 'No versions of Delphi are installed.'
    Left = 56
    Top = 232
  end
  object ccRegistryLayoutSaver: TccRegistryLayoutSaver
    Left = 512
    Top = 280
  end
end
