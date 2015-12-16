within IndustrialControlSystems.LinearSystems.Discrete.Functions;
function fCmplx "Function process with two complex poles"
  input Real alfa "Parametro di discretizzazione";
  input Real u "Current input";
  input Real u_pre1 "Previous input";
  input Real u_pre2 "ingresso a 2 passi precedente";
  input Real y_pre1 "Previous output";
  input Real y_pre2 "uscita a 2 passi precedente";
  input Real Ts "Sampling time [s]";
  input Real mu "Gain";
  input Real xi "Smorzamento";
  input Real omegan "Natural pulse";
  output Real y "Output";
protected
  Real A;
  Real B;
  Real C;
  Real D;
  Real E;
  Real F;
  Real G;
  Real H;
  Real I;
  Real L;
  Real M;
  Real N;
  Real O;
  Real P;
algorithm
  A := alfa*Ts;
  B := Ts - alfa*Ts;
  C := -2;
  D := A^2;
  E := 2*A*B;
  F := B^2;
  G := omegan;
  H := 2*xi*omegan;
  I := 1 + A*H + G*G*D;
  L := C - A*H + B*H + E*G*G;
  M := 1 - B*H + F*G*G;
  N := D*G^2;
  O := E*G^2;
  P := F*G^2;
  y := (mu*N*u + mu*O*u_pre1 + mu*P*u_pre2 - L*y_pre1 - M*y_pre2)/I;
  annotation (Documentation(revisions="<html>
<dl><dt>Industrial Control Systems (v 1.0.0) : April-May 2012</dt>
<dl><dt>List of revisions:</dt>
<p><ul>
<li>11 May 2012 (author: Marco Bonvini)</li>
</ul></p>
<dl><dt><b>Main Authors:</b> <br/></dt>
<dd>Marco Bonvini; &lt;<a href=\"mailto:bonvini@elet.polimi.it\">bonvini@elet.polimi.it</a>&gt;</dd>
<dd>Alberto Leva &lt;<a href=\"mailto:leva@elet.polimi.it\">leva@elet.polimi.it</a>&gt;<br/></dd>
<dd>Politecnico di Milano</dd>
<dd>Dipartimento di Elettronica e Informazione</dd>
<dd>Via Ponzio 34/5</dd>
<dd>20133 Milano - ITALIA -<br/></dd>
<dt><b>Copyright:</b> </dt>
<dd>Copyright &copy; 2010-2012, Marco Bonvini and Alberto Leva.<br/></dd>
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>.</i><br/></dd>
</dl></html>"));
end fCmplx;
