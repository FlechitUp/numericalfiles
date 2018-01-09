unit rungekuttaclass;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ParseMath, Matrices, StrMat;
type TRungekutta = class
  public
      matrizInput : TMatrices;
      function evaluar(valorX, valorY : Real ; f_x : String ):Real;
      function makeRK4(f_x : String; x_numb, y_numb, x_lim :Real;  h_numb: Real):TStrMatriz;
  end;

implementation

function TRungekutta.evaluar(valorX, valorY : Real ; f_x : String ) : Real;
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

function TRungekutta.makeRK4(f_x : String; x_numb, y_numb, x_lim :Real;  h_numb: Real):TStrMatriz;
var
   k1 ,k2 ,k3 ,k4 ,y_1: Real;
   N_numb, i,i1 : Integer;
begin

   N_numb:= round((x_lim - x_numb)/h_numb);
   matrizInput := TMatrices.Create(N_numb+1,6);
   //matrizInput.setMatriz(0,5,x_numb);


   k1 := evaluar(x_numb,y_numb,f_x);
   k2 := evaluar(x_numb + (h_numb/2), y_numb + (k1/2)*h_numb,f_x);
   k3 := evaluar(x_numb + (h_numb/2), y_numb + (k2/2)*h_numb,f_x);
   k4 := evaluar(x_numb + h_numb, y_numb + k3*h_numb,f_x);

    matrizInput.setMatriz(0,0,x_numb);
    matrizInput.setMatriz(0,1,y_numb);
    matrizInput.setMatriz(0,2,k1);
    matrizInput.setMatriz(0,3,k2);
    matrizInput.setMatriz(0,4,k3);
    matrizInput.setMatriz(0,5,k4);
    //matrizInput.printM();

    for i := 1 to  N_numb do
    begin
     k1 := evaluar(x_numb,y_numb,f_x)*h_numb;
     k2 := evaluar(x_numb + (h_numb/2), y_numb + (k1/2),f_x)*h_numb;
     k3 := evaluar(x_numb + (h_numb/2), y_numb + (k2/2),f_x)*h_numb;
     k4 := evaluar(x_numb + h_numb , y_numb + k3,f_x)*h_numb;
     y_1 := y_numb + (k1 + 2*k2 + 2*k3 +k4)/6;

     x_numb := x_numb + h_numb;
     y_numb := y_1;

     { LLenado de Matriz }
         matrizInput.setMatriz(i,0,x_numb);
         matrizInput.setMatriz(i,1,y_numb);
         matrizInput.setMatriz(i,2,k1);
         matrizInput.setMatriz(i,3,k2);
         matrizInput.setMatriz(i,4,k3);
         matrizInput.setMatriz(i,5,k4);
         //matrizInput.printM();
         //ReadLn;
     { End LLenado de Matriz }
     end;

     makeRK4 := matrizInput.toStr(matrizInput);
end;


end.

