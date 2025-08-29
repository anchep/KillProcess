{ <description>

  Copyright (c) <2025> <copyright holders>
  Anchep 2025/8/29 15:15:40 2025/8/29

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to
  deal in the Software without restriction, including without limitation the
  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
  sell copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
  IN THE SOFTWARE.
}


unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Spin,
  ExtCtrls, ComCtrls, Menus, Windows;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    PopupMenu1: TPopupMenu;
    ProgressBar1: TProgressBar;
    SpinEdit1: TSpinEdit;
    Timer1: TTimer;
    Timer2: TTimer;
    TrayIcon1: TTrayIcon;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormWindowStateChange(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.FormWindowStateChange(Sender: TObject);
begin
  if Form1.WindowState = wsMinimized then
  begin
    Visible := False;  // 隐藏主窗口
    TrayIcon1.Visible := True;  // 显示托盘图标（可选）
  end;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
const
  URL = 'https://www.280i.com';  // 目标网址
var
  ExecResult: integer;
begin
  ExecResult := ShellExecute(0, 'open', PChar(URL), nil, nil, SW_SHOWNORMAL);
  if ExecResult <= 32 then
  begin
    ShowMessage(Format('无法打开网址：%s'#13'错误代码：%d',
      [URL, ExecResult]));
  end;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  Application.Terminate;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
var
  CmdLine: string;
  Result: integer;       // 执行结果
begin
  CmdLine := '/f /im ' + Edit1.Text;
  ////showMessage(CmdLine);
  //WinExec(pansichar(CmdLine), SW_HIDE);  //老命令，已经不推荐了
  Result := ShellExecute(0, 'open', 'taskkill.exe', PChar(CmdLine), nil, SW_HIDE);
  // 检查执行结果（ShellExecute 返回值 >32 表示成功）
  if Result <= 32 then
  begin
    ShowMessage(Format('终止进程失败！错误代码：%d', [Result]));
  end;
  ProgressBar1.Position := 0;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  ProgressBar1.Position := ProgressBar1.Position + 1;
end;

procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin
  Visible := True;  // 显示主窗口
  WindowState := wsNormal;  // 恢复正常窗口状态
  TrayIcon1.Visible := False;  // 隐藏托盘图标（可选）
  BringToFront;  // 窗口置顶
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Timer1.Interval := SpinEdit1.Value * 60 * 1000;
  ProgressBar1.Max := SpinEdit1.Value * 60;
  if Timer1.Enabled = False then
  begin
    Timer1.Enabled := True;
    Button1.Caption := '执行中';
    Timer2.Enabled := True;
  end
  else
  begin
    Timer1.Enabled := False;
    Button1.Caption := '已停止';
    Timer2.Enabled := False;
    ProgressBar1.Position := 0;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  CmdLine: string;
  Result: integer;       // 执行结果
begin
  CmdLine := '/f /im ' + Edit1.Text;
  ////showMessage(CmdLine);
  //WinExec(pansichar(CmdLine), SW_HIDE);  //老命令，已经不推荐了
  Result := ShellExecute(0, 'open', 'taskkill.exe', PChar(CmdLine), nil, SW_HIDE);
  // 检查执行结果（ShellExecute 返回值 >32 表示成功）
  if Result <= 32 then
  begin
    ShowMessage(Format('终止进程失败！错误代码：%d', [Result]));
  end;
end;

end.
