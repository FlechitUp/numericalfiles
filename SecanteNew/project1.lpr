program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp, newtseclib, crt, ParseMath;
  { you can add units after this }

type

  { Secante }

  Secante = class(TCustomApplication)
  protected
    rpt :Double;
    Parse :TParseMath;
    NewSecVar : TRaizNewtSec;
    valI, valI2 :String;
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ Secante }

procedure Secante.DoRun;
var
  ErrorMsg: String;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h', 'help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h', 'help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  { add your program here }

  NewSecVar := TRaizNewtSec.Create;
  //rpt := NewSecVar.MSecante(0,0.001);
  //WriteLn('Respuesta ',rpt:0:2, ' = ', rpt);

  WriteLn('-----Newton-----');
  WriteLn('Esribe la funcition');
  Readln(valI);
  NewSecVar.set_funct(valI);
  {WriteLn('Escribe su derivada !!');
  ReadLn(valI2);
  NewSecVar.set_Deriv_funct(valI2);

  rpt := NewSecVar.MNewton(0.5, 0.0000001);
  WriteLn('Respuesta ',rpt:0:2, ' = ', rpt);
  ReadKey;  }

  WriteLn('-----Secante-----');
  rpt := NewSecVar.MSecante2(0.5, 0.0000001);
  WriteLn('Respuesta ',rpt:0:5, ' = ', rpt);
  ReadKey;


  WriteLn('-----Punto Fijo-----');
  rpt := NewSecVar.MPuntoFijo1(-2,0.000001);
  WriteLn('Respuesta ',rpt:0:2, ' = ', rpt);
  readkey;



  // stop program loop
  Terminate;
end;

constructor Secante.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor Secante.Destroy;
begin
  inherited Destroy;
end;

procedure Secante.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: Secante;
begin
  Application:=Secante.Create(nil);
  Application.Title:='My Application';
  Application.Run;
  Application.Free;
end.

