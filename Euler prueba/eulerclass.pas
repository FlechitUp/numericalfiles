unit Eulerclass;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Matrices, StrMat, ParseMath;

type TEuler = class
  public
     parse : TParseMath;

     matrizInput : TMatrices;
     function makeEuler(N_num : Integer; x_a, x_b :Real; f_x : String):TStrMatriz;
     function makeHeun(N_num : Integer; x_a, x_b :Real; f_x : String):TStrMatriz;
     function evaluar(valorX, valorY : Real ; f_x : String ) : Real;
     procedure comprobar(N_num : Integer; mat: TStrMatriz;f_x : String );
  end;

implementation


function TEuler.evaluar(valorX, valorY : Real ; f_x : String ) : Real;
var
   MiParse : TParseMath;
begin
  try
  Miparse := TParseMath.create();
  MiParse.AddVariable('x',valorX);
  MiParse.AddVariable('y',valorY);
  MiParse.Expression:= f_x;
  evaluar := MiParse.Evaluate();
  except
     evaluar:=0;
     Exit;
  end;
end;


function TEuler.makeEuler(N_num : Integer; x_a, x_b :Real; f_x : String):TStrMatriz;
var
  h_num, e_num :Real; //e_num es para las distancias
  y_n1,y_n, x_n: Real;
  i,j: Integer;


begin
  h_num := (x_b-x_a)/N_num;
  matrizInput := TMatrices.Create(N_num+1,2);
  WriteLn('Esribe los primeros elementos de la tabla');
  ReadLn(x_n);
  matrizInput.setMatriz(0,0,x_n);    //x_n
  ReadLn(y_n);
  matrizInput.setMatriz(1,0,y_n);    //y_n

   for i:= 1 to N_num do
    begin
        y_n1 := y_n+h_num*evaluar(x_n,y_n, f_x);
        x_n := x_n+h_num;
        matrizInput.setMatriz(0,i,x_n);
        matrizInput.setMatriz(1,i,y_n1);
        e_num:= abs(y_n1-y_n);
        y_n := y_n1;
        WriteLn('ok ',y_n1);
        //matrizInput.printM();
        //ReadLn;
    end;
   matrizInput.printM();
   makeEuler := matrizInput.toStr(matrizInput);

end;


function TEuler.makeHeun(N_num : Integer; x_a, x_b :Real; f_x : String): TStrMatriz;
var
  h_num,resp1,y_nE :Real;
  y_n1,y_n, x_n: Real;
  i,j,n : Integer;

begin

  h_num := (x_b-x_a)/N_num;
  matrizInput := TMatrices.Create(N_num+1,2);
  WriteLn('Esribe los primeros elementos de la tabla');
  ReadLn(x_n);
  matrizInput.setMatriz(0,0,x_n);    //x_n
  ReadLn(y_n);
  matrizInput.setMatriz(1,0,y_n);    //y_n

  for i:= 1 to N_num do
  begin
       resp1 := evaluar(x_n,y_n,f_x);
       y_nE := y_n+h_num*resp1; //Hallo Euler
       x_n := x_n+h_num;
       //y_n := y_nE;
       y_n1 := y_n + h_num*(resp1+evaluar(x_n,y_nE,f_x))/2;
       matrizInput.setMatriz(0,i,x_n);
       matrizInput.setMatriz(1,i,y_n1);
       y_n := y_n1;
    end;

   matrizInput.printM();
   makeHeun := matrizInput.toStr(matrizInput);
end;

procedure TEuler.comprobar(N_num : Integer; mat: TStrMatriz;f_x : String );
var
  i : Integer;
begin

  //for i:=0 to mat.lista.Count do begin
         WriteLn('** ', evaluar(StrToFloat(mat.get(i,0)), StrToFloat(mat.get(i,1)), f_x));
  //end;

end;

end.

