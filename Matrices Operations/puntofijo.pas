unit PuntoFijo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ArrReal,ArrStr, Matrices,ParseMath, math,crt;
type TPuntoFijo = class
     public
        valores_X, matfun : TArrReal;             //Arreglo de respuestas
        valores_Erores : TArrReal;
        constructor create();
        function f_x(fx_ListI,var_ListI : TArrString; val_ListI: TArrReal;Nrovar:Integer ; ErrorI : Real):TArrReal;
        function CalcError(Nrovar :Integer):Real;
end;

implementation

constructor TPuntoFijo.create();
begin
    valores_X:= TArrReal.Create();
    matfun := TArrReal.Create();
    valores_Erores := TArrReal.Create();
    valores_Erores.push(-0.1);
end;

function TPuntoFijo.f_x(fx_ListI,var_ListI : TArrString; val_ListI: TArrReal;Nrovar:Integer; ErrorI : Real ):TArrReal;
var
  Parse:TParseMath;
  i,j : Integer;
  g, ErrorO : Real;
begin
  Parse:=TParseMath.create();
  ErrorO:=50;

  for i:=0 to Nrovar-1 do begin
    Parse.AddVariable(var_ListI.get(i),(val_ListI.get(i)));
    valores_X.push(val_ListI.get(i));
    matfun.push(val_ListI.get(i));
  end;

  for i:=0 to Nrovar-1 do begin
    Parse.Expression:=fx_ListI.get(i);
    matfun.push(Parse.Evaluate());
  end;
  WriteLn('***------***');
  matfun.print(Nrovar);
  WriteLn('***------***');

  j:=matfun.tam()-Nrovar;
  for i:=0 to  Nrovar-1 do begin
    val_ListI.setArr(i,matfun.get(j));
    j:= j+1;
  end;

  while(ErrorO>ErrorI)do
  begin

  for i:=0 to Nrovar-1 do begin
    Parse.NewValue(var_ListI.get(i),(val_ListI.get(i)));
    //WriteLn('val asig ', val_ListI.get(i));

    //valores_X.push(val_ListI.get(i));
    //matfun.push(val_ListI.get(i));
  end;

   ErrorO:= CalcError(Nrovar);
   WriteLn('error ', ErrorO);
   //ReadKey;

  for i:=0 to Nrovar-1 do begin
    Parse.Expression:=fx_ListI.get(i);
    matfun.push(Parse.Evaluate());
  end;

  j:=matfun.tam()-Nrovar;
  for i:=0 to  Nrovar-1 do begin
    val_ListI.setArr(i,matfun.get(j));
    j:= j+1;
  end;

end;
  WriteLn('......');
  matfun.print(Nrovar);
  WriteLn('......');
  f_x := matfun;

end;


function TPuntoFijo.CalcError(Nrovar :Integer):Real;
var
  i,j : Integer;
  sum : Real;
begin
  if (matfun.tam()=Nrovar)then begin
     //WriteLn('--');
     CalcError := -1.0 ;
  end
  else
  begin
    sum :=0;
    i:=matfun.tam-(2*Nrovar);
    j := i+ Nrovar;
    while i < j do begin
      //WriteLn('a-b',valores_X.get(i+Nrovar),' - ',valores_X.get(i) );
      //WriteLn('*********');
      sum:= sum + power(matfun.get(i+Nrovar)-matfun.get(i),2);;
      i:= i+1;
    end;
    sum := power(sum,0.5);
    //WriteLn('error ', sum:0:2);
    CalcError := sum;

  end;


end;

end.

