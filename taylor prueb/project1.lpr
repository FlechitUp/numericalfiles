program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp, TaylorExpo ,crt
  { you can add units after this };

type

  { TMyApplication }

  TMyApplication = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    taylorE: TTaylorExpo;
    X : Double;
    N : double;
    select: integer;
    rpt :real;
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TMyApplication }

procedure TMyApplication.DoRun;
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

  writeln('Elige');
  WriteLn('1 sen');
  WriteLn('2 cos');
  WriteLn('3 arcth');
  WriteLn('4 ln');
  WriteLn('5 expo');
  ReadLn(select);

  taylorE:= TTaylorExpo.Create;
  writeln('Ingresa ');
  Readln(X);
  writeln('Ingresa error ');
  Readln(N);

        {
  //rpt := taylorE.taylorexpo(x,N);
  //writeln('la respuesta e expo x es ',rpt);
  rpt := taylorE.taylorsen(x,N);
  writeln('la respuesta sen(x) es ',rpt);
  //rpt := taylorE.taylorcos(x,N);
  //writeln('la respuesta cos(x) es ',rpt);
  rpt := taylorE.taylorarctgh(x,N);
  writeln('la respuesta arctgh(x) es ',rpt);
  //rpt := taylorE.taylorlog(x,N);
  //writeln('la respuesta ln(x) es ',rpt);
  readkey;
  // stop program loop
        }

   case select of
        1: begin rpt := taylorE.taylorsen(x,N); writeln('la respuesta sen(x) es ',rpt:0:2,' = ',rpt); readkey;  end;
        2: begin rpt := taylorE.taylorcos(x,N); writeln('la respuesta cos(x) es ',rpt:0:2,' = ',rpt);readkey;  end;
        3: begin rpt := taylorE.taylorarctgh(x,N);writeln(' arctgh(x) es ',rpt:0:2,' = ',rpt); readkey; end;
        4: begin rpt := taylorE.taylorlog(x,N); writeln('la respuesta ln(x) es ',rpt:0:2,' = ',rpt);readkey;  end;
        5: begin rpt := taylorE.taylorexpo(x,N); writeln('la respuesta e expo x es ',rpt:0:2,' = ',rpt);readkey;  end;

   end;

  Terminate;
end;

constructor TMyApplication.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TMyApplication.Destroy;
begin
  inherited Destroy;
end;

procedure TMyApplication.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: TMyApplication;
begin
  Application:=TMyApplication.Create(nil);
  Application.Title:='Taylor';
  Application.Run;
  Application.Free;
end.

