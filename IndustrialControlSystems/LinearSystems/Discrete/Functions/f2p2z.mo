within IndustrialControlSystems.LinearSystems.Discrete.Functions;
function f2p2z
  "Function of a process with oneintegrator, one pole and two zeroes: k(1+sT1)(1+sT2)/(1+sT3)s"
  input Real alpha "Parametro di discretizzazione";
  input Real T1 "Zero";
  input Real T2 "Zero";
  input Real T3 "Polo";
  input Real u "Current input";
  input Real u_pre1 "Previous input";
  input Real u_pre2 "two steps ago input";
  input Real y_pre1 "Previous output";
  input Real y_pre2 "two steps ago output";
  input Real Ts "Sampling time [s]";
  input Real mu "Gain";
  output Real y "Output";
algorithm
  y := 1/(alpha*Ts + T3)*(
          + T3*y_pre1
          - (-T3-alpha*Ts+Ts)*y_pre1
          + alpha*Ts*y_pre1
          - (T3+alpha*Ts-Ts)*y_pre2
          + mu*T1*T2*u
          + alpha^2*mu*Ts^2*u
          + alpha*mu*Ts*T2*u
          + alpha*mu*Ts*T1*u
          + mu*(-T1-alpha*Ts+Ts)*T2*u_pre1
          + mu*T1*(-T2-alpha*Ts+Ts)*u_pre1
          + alpha*mu*Ts*(-T2-alpha*Ts+Ts)*u_pre1
          + alpha*mu*Ts*(-T1-alpha*Ts+Ts)*u_pre1
          + mu*(-T1-alpha*Ts+Ts)*(-T2-alpha*Ts+Ts)*u_pre2);

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
end f2p2z;
